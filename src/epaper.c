#include "epaper.h"

#include "app_error.h"

#include "nrf_log.h"
#include "nrf_log_ctrl.h"
#include "nrf_delay.h"
#include "nrfx_spim.h"
#include "nrfx_gpiote.h"

// static uint8_t framebuffer[15000];

static uint8_t lut_vcom0[] =
{
    0x00, 0x17, 0x00, 0x00, 0x00, 0x02,        
    0x00, 0x17, 0x17, 0x00, 0x00, 0x02,        
    0x00, 0x0A, 0x01, 0x00, 0x00, 0x01,        
    0x00, 0x0E, 0x0E, 0x00, 0x00, 0x02,        
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,        
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,        
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
};

static uint8_t lut_ww[] ={
    0x40, 0x17, 0x00, 0x00, 0x00, 0x02,
    0x90, 0x17, 0x17, 0x00, 0x00, 0x02,
    0x40, 0x0A, 0x01, 0x00, 0x00, 0x01,
    0xA0, 0x0E, 0x0E, 0x00, 0x00, 0x02,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
};

static uint8_t lut_bw[] ={
    0x40, 0x17, 0x00, 0x00, 0x00, 0x02,
    0x90, 0x17, 0x17, 0x00, 0x00, 0x02,
    0x40, 0x0A, 0x01, 0x00, 0x00, 0x01,
    0xA0, 0x0E, 0x0E, 0x00, 0x00, 0x02,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
};

static uint8_t lut_wb[] ={
    0x80, 0x17, 0x00, 0x00, 0x00, 0x02,
    0x90, 0x17, 0x17, 0x00, 0x00, 0x02,
    0x80, 0x0A, 0x01, 0x00, 0x00, 0x01,
    0x50, 0x0E, 0x0E, 0x00, 0x00, 0x02,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
};

static uint8_t lut_bb[] ={
    0x80, 0x17, 0x00, 0x00, 0x00, 0x02,
    0x90, 0x17, 0x17, 0x00, 0x00, 0x02,
    0x80, 0x0A, 0x01, 0x00, 0x00, 0x01,
    0x50, 0x0E, 0x0E, 0x00, 0x00, 0x02,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
};

static nrfx_spim_t spim_instance = NRFX_SPIM_INSTANCE(0);

static bool epaper_is_busy = false;

static void busy_event_handler(nrfx_gpiote_pin_t pin, nrf_gpiote_polarity_t action)
{
    if (pin == EPD_PIN_BUSY && action == GPIOTE_CONFIG_POLARITY_Toggle) {
        epaper_is_busy = !nrfx_gpiote_in_is_set(EPD_PIN_BUSY);
    }
}

void epaper_init(void)
{
    nrfx_spim_config_t spim_config = {
        .sck_pin        = EPD_PIN_CLK,
        .mosi_pin       = EPD_PIN_DIN,
        .miso_pin       = NRFX_SPIM_PIN_NOT_USED,
        .ss_pin         = EPD_PIN_CS,
        .ss_active_high = false,
        .irq_priority   = NRFX_SPIM_DEFAULT_CONFIG_IRQ_PRIORITY,
        .orc            = 0xFF,
        .frequency      = NRF_SPIM_FREQ_125K,
        .mode           = NRF_SPIM_MODE_0,
        .bit_order      = NRF_SPIM_BIT_ORDER_MSB_FIRST
    };

    APP_ERROR_CHECK(
        nrfx_spim_init(&spim_instance, &spim_config, NULL, NULL)
    );

    if (!nrfx_gpiote_is_init()) {
        APP_ERROR_CHECK(
            nrfx_gpiote_init()
        );
    }

    {
        nrfx_gpiote_in_config_t busy_config = NRFX_GPIOTE_CONFIG_IN_SENSE_TOGGLE(false);
        busy_config.pull = NRF_GPIO_PIN_PULLUP;
        APP_ERROR_CHECK(
            nrfx_gpiote_in_init(EPD_PIN_BUSY, &busy_config, busy_event_handler)
        );
    }

    {
        nrfx_gpiote_out_config_t reset_config = NRFX_GPIOTE_CONFIG_OUT_SIMPLE(true);
        APP_ERROR_CHECK(
            nrfx_gpiote_out_init(EPD_PIN_RST, &reset_config)
        );
    }

    {
        nrfx_gpiote_out_config_t dcx_config = NRFX_GPIOTE_CONFIG_OUT_SIMPLE(true);
        APP_ERROR_CHECK(
            nrfx_gpiote_out_init(EPD_PIN_DC, &dcx_config)
        );
    }
    nrfx_gpiote_in_event_enable(EPD_PIN_BUSY, true);
}


static void epaper_wait(void) 
{
    NRF_LOG_INFO("wait for display");
    while(epaper_is_busy) 
    {
        NRF_LOG_PROCESS();
        nrf_delay_ms(100);
    }
    NRF_LOG_INFO("display is ready");
}

static void epaper_reset()
{
    nrf_delay_ms(200);
    nrfx_gpiote_out_clear(EPD_PIN_RST);
    nrf_delay_ms(200);
    nrfx_gpiote_out_set(EPD_PIN_RST);
    nrf_delay_ms(200);
}

static void send_data(const uint8_t* bytes, uint8_t length)
{
    nrfx_spim_xfer_desc_t transfer = {
        .p_tx_buffer = bytes,
        .tx_length = length,
        .p_rx_buffer = NULL,
        .rx_length = 0
    };
    nrfx_gpiote_out_set(EPD_PIN_DC);
    APP_ERROR_CHECK(nrfx_spim_xfer(&spim_instance, &transfer, 0));
    nrfx_gpiote_out_clear(EPD_PIN_DC);
}

static void send_command(uint8_t cmd) 
{
    nrfx_spim_xfer_desc_t transfer = {
        .p_tx_buffer = &cmd,
        .tx_length = 1,
        .p_rx_buffer = NULL,
        .rx_length = 0
    };
    nrfx_gpiote_out_clear(EPD_PIN_DC);
    APP_ERROR_CHECK(nrfx_spim_xfer(&spim_instance, &transfer, 0));
    nrfx_gpiote_out_set(EPD_PIN_DC);
}

#define SEND_COMMAND(cmd, ...) \
{ \
    static uint8_t _data_bytes[] = __VA_ARGS__; \
    send_command(cmd);  \
    send_data(_data_bytes, sizeof(_data_bytes)/sizeof(uint8_t)); \
}

#define SEND_LUT(cmd, lut) \
{ \
    send_command(cmd);  \
    send_data(lut, sizeof(lut)/sizeof(uint8_t)); \
}

static void epaper_refresh()
{
    send_command(DISPLAY_REFRESH);
    nrf_delay_ms(100);
    epaper_wait();
}

void epaper_wakeup(void)
{
    epaper_reset();

    SEND_COMMAND(POWER_SETTING, {0x03, 0x00, 0x2b, 0x2b});
    SEND_COMMAND(BOOSTER_SOFT_START, {0x17, 0x17, 0x17});
    send_command(POWER_ON);

    epaper_wait();

    SEND_COMMAND(PANEL_SETTING, {0xbf, 0x0d});
    SEND_COMMAND(PLL_CONTROL, {0x3c});
    SEND_COMMAND(RESOLUTION_SETTING, {0x01, 0x90, 0x01, 0x2c});
    SEND_COMMAND(VCM_DC_SETTING, {0x28});
    SEND_COMMAND(VCOM_AND_DATA_INTERVAL_SETTING, {0x97});

    SEND_LUT(LUT_FOR_VCOM, lut_vcom0);
    SEND_LUT(LUT_WHITE_TO_WHITE, lut_ww);
    SEND_LUT(LUT_BLACK_TO_WHITE, lut_bw);
    SEND_LUT(LUT_WHITE_TO_BLACK, lut_wb);
    SEND_LUT(LUT_BLACK_TO_BLACK, lut_bb);
}

void epaper_sleep(void)
{
    send_command(POWER_OFF);
    epaper_wait();
    SEND_COMMAND(DEEP_SLEEP, {0xa5});
}

void epaper_clear(void)
{
    int width = (EPD_WIDTH + 7) / 8;
    send_command(DATA_START_TRANSMISSION_1);
    for(int row = 0; row < EPD_HEIGHT; ++row)
    {
        for(int col = 0; col < width; ++col)
        {
            static uint8_t white = 0xff;
            send_data(&white, 1);
        }
    }

    send_command(DATA_START_TRANSMISSION_2);
    for(int row = 0; row < EPD_HEIGHT; ++row)
    {
        for(int col = 0; col < width; ++col)
        {
            static uint8_t white = 0xff;
            send_data(&white, 1);
        }
    }

    epaper_refresh();
}

void epaper_display(uint8_t* framebuffer) 
{
    int width = (EPD_WIDTH + 7) / 8;
    send_command(DATA_START_TRANSMISSION_1);
    for(int row = 0; row < EPD_HEIGHT; ++row)
    {
        send_data(&framebuffer[row * width], width);
    }

    send_command(DATA_START_TRANSMISSION_2);
    for(int row = 0; row < EPD_HEIGHT; ++row)
    {
        send_data(&framebuffer[row * width], width);
    }

    epaper_refresh();
}