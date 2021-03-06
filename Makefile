PROJECT_NAME     := hello_pca10040
TARGETS          := nrf52832_xxaa
OUTPUT_DIRECTORY := _build

SDK_ROOT := ../../SDK
PROJ_DIR := .

$(OUTPUT_DIRECTORY)/nrf52832_xxaa.out: \
  LINKER_SCRIPT  := gcc_nrf52.ld

# Source files common to all targets
SRC_FILES += $(SDK_ROOT)/modules/nrfx/mdk/gcc_startup_nrf52.S
SRC_FILES += $(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_serial.c
SRC_FILES += $(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_uart.c
SRC_FILES += $(SDK_ROOT)/components/libraries/log/src/nrf_log_default_backends.c
SRC_FILES += $(SDK_ROOT)/components/libraries/log/src/nrf_log_frontend.c
SRC_FILES += $(SDK_ROOT)/components/libraries/log/src/nrf_log_str_formatter.c
#SRC_FILES += $(SDK_ROOT)/components/libraries/button/app_button.c
SRC_FILES += $(SDK_ROOT)/components/libraries/util/app_error.c
SRC_FILES += $(SDK_ROOT)/components/libraries/util/app_error_handler_gcc.c
SRC_FILES += $(SDK_ROOT)/components/libraries/util/app_error_weak.c
#SRC_FILES += $(SDK_ROOT)/components/libraries/scheduler/app_scheduler.c
#SRC_FILES += $(SDK_ROOT)/components/libraries/sdcard/app_sdcard.c
#SRC_FILES += $(SDK_ROOT)/components/libraries/timer/experimental/app_timer2.c
SRC_FILES += $(SDK_ROOT)/components/libraries/util/app_util_platform.c
SRC_FILES += $(SDK_ROOT)/components/libraries/hardfault/hardfault_implementation.c
SRC_FILES += $(SDK_ROOT)/components/libraries/util/nrf_assert.c
SRC_FILES += $(SDK_ROOT)/components/libraries/atomic_fifo/nrf_atfifo.c
SRC_FILES += $(SDK_ROOT)/components/libraries/atomic/nrf_atomic.c
SRC_FILES += $(SDK_ROOT)/components/libraries/balloc/nrf_balloc.c
SRC_FILES += $(SDK_ROOT)/external/fprintf/nrf_fprintf.c
SRC_FILES += $(SDK_ROOT)/external/fprintf/nrf_fprintf_format.c
SRC_FILES += $(SDK_ROOT)/components/libraries/memobj/nrf_memobj.c
SRC_FILES += $(SDK_ROOT)/components/libraries/pwr_mgmt/nrf_pwr_mgmt.c
SRC_FILES += $(SDK_ROOT)/components/libraries/ringbuf/nrf_ringbuf.c
SRC_FILES += $(SDK_ROOT)/components/libraries/experimental_section_vars/nrf_section_iter.c
#SRC_FILES += $(SDK_ROOT)/components/libraries/strerror/nrf_strerror.c
SRC_FILES += $(SDK_ROOT)/modules/nrfx/mdk/system_nrf52.c
#SRC_FILES += $(SDK_ROOT)/components/boards/boards.c
#SRC_FILES += $(SDK_ROOT)/integration/nrfx/legacy/nrf_drv_clock.c
#SRC_FILES += $(SDK_ROOT)/integration/nrfx/legacy/nrf_drv_spi.c
SRC_FILES += $(SDK_ROOT)/integration/nrfx/legacy/nrf_drv_uart.c
#SRC_FILES += $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_clock.c
#SRC_FILES += $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_gpiote.c
#SRC_FILES += $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_ppi.c
#SRC_FILES += $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_timer.c
#SRC_FILES += $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_power_clock.c
SRC_FILES += $(SDK_ROOT)/modules/nrfx/drivers/src/prs/nrfx_prs.c
#SRC_FILES += $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_saadc.c
#SRC_FILES += $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_spi.c
#SRC_FILES += $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_spim.c
SRC_FILES += $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_uart.c
SRC_FILES += $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_uarte.c
#SRC_FILES += $(SDK_ROOT)/components/libraries/bsp/bsp.c
#SRC_FILES += $(SDK_ROOT)/components/libraries/block_dev/sdc/nrf_block_dev_sdc.c
#SRC_FILES += $(SDK_ROOT)/components/ble/common/ble_advdata.c
#SRC_FILES += $(SDK_ROOT)/components/ble/common/ble_srv_common.c
#SRC_FILES += $(SDK_ROOT)/components/ble/ble_radio_notification/ble_radio_notification.c
#SRC_FILES += $(SDK_ROOT)/external/utf_converter/utf.c
#SRC_FILES += $(SDK_ROOT)/external/fatfs/port/diskio_blkdev.c
#SRC_FILES += $(SDK_ROOT)/external/fatfs/src/ff.c
#SRC_FILES += $(SDK_ROOT)/components/softdevice/common/nrf_sdh.c
#SRC_FILES += $(SDK_ROOT)/components/softdevice/common/nrf_sdh_ble.c
#SRC_FILES += $(SDK_ROOT)/components/softdevice/common/nrf_sdh_soc.c
SRC_FILES += $(wildcard $(PROJ_DIR)/src/*.c)

# Include folders common to all targets
INC_FOLDERS += \
  $(SDK_ROOT)/components/nfc/ndef/generic/message \
  $(SDK_ROOT)/components/nfc/t2t_lib \
  $(SDK_ROOT)/components/nfc/t4t_parser/hl_detection_procedure \
  $(SDK_ROOT)/components/ble/ble_services/ble_ancs_c \
  $(SDK_ROOT)/components/ble/ble_services/ble_ias_c \
  $(SDK_ROOT)/components/libraries/pwm \
  $(SDK_ROOT)/components/softdevice/s132/headers/nrf52 \
  $(SDK_ROOT)/components/libraries/usbd/class/cdc/acm \
  $(SDK_ROOT)/components/libraries/usbd/class/hid/generic \
  $(SDK_ROOT)/components/libraries/usbd/class/msc \
  $(SDK_ROOT)/components/libraries/usbd/class/hid \
  $(SDK_ROOT)/modules/nrfx/hal \
  $(SDK_ROOT)/components/nfc/ndef/conn_hand_parser/le_oob_rec_parser \
  $(SDK_ROOT)/components/libraries/log \
  $(SDK_ROOT)/components/ble/ble_services/ble_gls \
  $(SDK_ROOT)/components/libraries/fstorage \
  $(SDK_ROOT)/components/nfc/ndef/text \
  $(SDK_ROOT)/components/libraries/mutex \
  $(SDK_ROOT)/components/libraries/gpiote \
  $(SDK_ROOT)/components/libraries/bootloader/ble_dfu \
  $(SDK_ROOT)/components/nfc/ndef/connection_handover/common \
  $(SDK_ROOT)/components/boards \
  $(SDK_ROOT)/components/nfc/ndef/generic/record \
  $(SDK_ROOT)/components/ble/ble_advertising \
  $(SDK_ROOT)/external/utf_converter \
  $(SDK_ROOT)/components/ble/ble_services/ble_bas_c \
  $(SDK_ROOT)/modules/nrfx/drivers/include \
  $(SDK_ROOT)/components/libraries/experimental_task_manager \
  $(SDK_ROOT)/components/ble/ble_services/ble_hrs_c \
  $(SDK_ROOT)/components/nfc/ndef/connection_handover/le_oob_rec \
  $(SDK_ROOT)/components/libraries/queue \
  $(SDK_ROOT)/components/libraries/pwr_mgmt \
  $(SDK_ROOT)/components/ble/ble_dtm \
  $(SDK_ROOT)/components/toolchain/cmsis/include \
  $(SDK_ROOT)/components/ble/ble_services/ble_rscs_c \
  $(SDK_ROOT)/components/ble/common \
  $(SDK_ROOT)/components/ble/ble_services/ble_lls \
  $(SDK_ROOT)/components/libraries/bsp \
  $(SDK_ROOT)/components/nfc/ndef/connection_handover/ac_rec \
  $(SDK_ROOT)/components/ble/ble_services/ble_bas \
  $(SDK_ROOT)/components/libraries/mpu \
  $(SDK_ROOT)/components/libraries/experimental_section_vars \
  $(SDK_ROOT)/components/softdevice/s132/headers \
  $(SDK_ROOT)/components/ble/ble_services/ble_ans_c \
  $(SDK_ROOT)/components/libraries/slip \
  $(SDK_ROOT)/components/libraries/delay \
  $(SDK_ROOT)/components/libraries/mem_manager \
  $(SDK_ROOT)/components/libraries/csense_drv \
  $(SDK_ROOT)/components/libraries/memobj \
  $(SDK_ROOT)/components/ble/ble_services/ble_nus_c \
  $(SDK_ROOT)/components/softdevice/common \
  $(SDK_ROOT)/components/ble/ble_services/ble_ias \
  $(SDK_ROOT)/components/libraries/usbd/class/hid/mouse \
  $(SDK_ROOT)/components/libraries/low_power_pwm \
  $(SDK_ROOT)/components/nfc/ndef/conn_hand_parser/ble_oob_advdata_parser \
  $(SDK_ROOT)/components/ble/ble_services/ble_dfu \
  $(SDK_ROOT)/external/fprintf \
  $(SDK_ROOT)/components/libraries/svc \
  $(SDK_ROOT)/components/libraries/atomic \
  $(SDK_ROOT)/components \
  $(SDK_ROOT)/components/libraries/scheduler \
  $(SDK_ROOT)/components/libraries/cli \
  $(SDK_ROOT)/components/ble/ble_services/ble_lbs \
  $(SDK_ROOT)/components/ble/ble_services/ble_hts \
  $(SDK_ROOT)/components/libraries/crc16 \
  $(SDK_ROOT)/components/nfc/t4t_parser/apdu \
  $(SDK_ROOT)/components/libraries/util \
  ./config \
  $(SDK_ROOT)/components/libraries/usbd/class/cdc \
  $(SDK_ROOT)/components/libraries/csense \
  $(SDK_ROOT)/components/libraries/balloc \
  $(SDK_ROOT)/components/libraries/ecc \
  $(SDK_ROOT)/components/libraries/hardfault \
  $(SDK_ROOT)/components/ble/ble_services/ble_cscs \
  $(SDK_ROOT)/components/libraries/hci \
  $(SDK_ROOT)/components/libraries/timer \
  $(SDK_ROOT)/integration/nrfx \
  $(SDK_ROOT)/components/nfc/t4t_parser/tlv \
  $(SDK_ROOT)/components/libraries/sortlist \
  $(SDK_ROOT)/components/libraries/spi_mngr \
  $(SDK_ROOT)/components/libraries/led_softblink \
  $(SDK_ROOT)/components/nfc/ndef/conn_hand_parser \
  $(SDK_ROOT)/components/libraries/sdcard \
  $(SDK_ROOT)/components/nfc/ndef/parser/record \
  $(SDK_ROOT)/modules/nrfx/mdk \
  $(SDK_ROOT)/components/ble/ble_services/ble_cts_c \
  $(SDK_ROOT)/components/ble/ble_services/ble_nus \
  $(SDK_ROOT)/components/libraries/twi_mngr \
  $(SDK_ROOT)/components/ble/ble_services/ble_hids \
  $(SDK_ROOT)/components/libraries/strerror \
  $(SDK_ROOT)/components/libraries/crc32 \
  $(SDK_ROOT)/components/nfc/ndef/connection_handover/ble_oob_advdata \
  $(SDK_ROOT)/components/nfc/t2t_parser \
  $(SDK_ROOT)/components/nfc/ndef/connection_handover/ble_pair_msg \
  $(SDK_ROOT)/components/libraries/usbd/class/audio \
  $(SDK_ROOT)/components/nfc/t4t_lib/hal_t4t \
  $(SDK_ROOT)/components/nfc/t4t_lib \
  $(SDK_ROOT)/components/ble/peer_manager \
  $(SDK_ROOT)/components/drivers_nrf/usbd \
  $(SDK_ROOT)/components/libraries/ringbuf \
  $(SDK_ROOT)/components/ble/ble_services/ble_tps \
  $(SDK_ROOT)/components/nfc/ndef/parser/message \
  $(SDK_ROOT)/components/ble/ble_services/ble_dis \
  $(SDK_ROOT)/components/nfc/ndef/uri \
  $(SDK_ROOT)/components/nfc/t4t_parser/cc_file \
  $(SDK_ROOT)/components/ble/nrf_ble_qwr \
  $(SDK_ROOT)/components/libraries/gfx \
  $(SDK_ROOT)/components/libraries/button \
  $(SDK_ROOT)/modules/nrfx \
  $(SDK_ROOT)/components/libraries/twi_sensor \
  $(SDK_ROOT)/integration/nrfx/legacy \
  $(SDK_ROOT)/components/libraries/usbd/class/hid/kbd \
  $(SDK_ROOT)/components/nfc/ndef/connection_handover/ep_oob_rec \
  $(SDK_ROOT)/external/fatfs/src \
  $(SDK_ROOT)/external/protothreads \
  $(SDK_ROOT)/external/protothreads/pt-1.4 \
  $(SDK_ROOT)/external/fatfs/port \
  $(SDK_ROOT)/external/segger_rtt \
  $(SDK_ROOT)/components/libraries/atomic_fifo \
  $(SDK_ROOT)/components/libraries/block_dev \
  $(SDK_ROOT)/components/libraries/block_dev/sdc \
  $(SDK_ROOT)/components/ble/ble_services/ble_lbs_c \
  $(SDK_ROOT)/components/nfc/ndef/connection_handover/ble_pair_lib \
  $(SDK_ROOT)/components/libraries/crypto \
  $(SDK_ROOT)/components/ble/ble_racp \
  $(SDK_ROOT)/components/libraries/fds \
  $(SDK_ROOT)/components/nfc/ndef/launchapp \
  $(SDK_ROOT)/components/ble/ble_services/ble_hrs \
  $(SDK_ROOT)/components/ble/ble_services/ble_rscs \
  $(SDK_ROOT)/components/nfc/ndef/connection_handover/hs_rec \
  $(SDK_ROOT)/components/nfc/t2t_lib/hal_t2t \
  $(SDK_ROOT)/components/libraries/usbd \
  $(SDK_ROOT)/components/nfc/ndef/conn_hand_parser/ac_rec_parser \
  $(SDK_ROOT)/components/libraries/stack_guard \
  $(SDK_ROOT)/components/libraries/log/src \
  $(SDK_ROOT)/components/ble/ble_radio_notification \

# Libraries common to all targets
LIB_FILES += \

# Optimization flags
OPT = -O3 -g3
# Uncomment the line below to enable link time optimization
#OPT += -flto

# C flags common to all targets
CFLAGS += $(OPT)
CFLAGS += -DBOARD_PCA10040
CFLAGS += -DCONFIG_GPIO_AS_PINRESET
CFLAGS += -DFLOAT_ABI_HARD
CFLAGS += -DNRF52
CFLAGS += -DNRF52832_XXAA
CFLAGS += -DNRF52_PAN_74
#CFLAGS += -DNRF_SD_BLE_API_VERSION=6
#CFLAGS += -DS132
#CFLAGS += -DSOFTDEVICE_PRESENT
CFLAGS += -DSWI_DISABLE0
CFLAGS += -mcpu=cortex-m4
CFLAGS += -mthumb -mabi=aapcs
CFLAGS += -Wall -Werror
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
# keep every function in a separate section, this allows linker to discard unused ones
CFLAGS += -ffunction-sections -fdata-sections -fno-strict-aliasing
CFLAGS += -fno-builtin -fshort-enums

# C++ flags common to all targets
CXXFLAGS += $(OPT)

# Assembler flags common to all targets
ASMFLAGS += -g3
ASMFLAGS += -mcpu=cortex-m4
ASMFLAGS += -mthumb -mabi=aapcs
ASMFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
ASMFLAGS += -DBOARD_PCA10040
ASMFLAGS += -DCONFIG_GPIO_AS_PINRESET
ASMFLAGS += -DFLOAT_ABI_HARD
ASMFLAGS += -DNRF52
ASMFLAGS += -DNRF52832_XXAA
ASMFLAGS += -DNRF52_PAN_74
#ASMFLAGS += -DNRF_SD_BLE_API_VERSION=6
#ASMFLAGS += -DS132
#ASMFLAGS += -DSOFTDEVICE_PRESENT
ASMFLAGS += -DSWI_DISABLE0

# Linker flags
LDFLAGS += $(OPT)
LDFLAGS += -mthumb -mabi=aapcs -L$(SDK_ROOT)/modules/nrfx/mdk -T$(LINKER_SCRIPT)
LDFLAGS += -mcpu=cortex-m4
LDFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
# let linker dump unused sections
LDFLAGS += -Wl,--gc-sections
# use newlib in nano version
LDFLAGS += --specs=nano.specs

nrf52832_xxaa: CFLAGS += -D__HEAP_SIZE=8192
nrf52832_xxaa: CFLAGS += -D__STACK_SIZE=8192
nrf52832_xxaa: ASMFLAGS += -D__HEAP_SIZE=8192
nrf52832_xxaa: ASMFLAGS += -D__STACK_SIZE=8192

# Add standard libraries at the very end of the linker input, after all objects
# that may need symbols provided by these libraries.
LIB_FILES += -lc -lnosys -lm


.PHONY: default help

# Default target - first one defined
default: nrf52832_xxaa

# Print all targets that can be built
help:
	@echo following targets are available:
	@echo		nrf52832_xxaa
#	@echo		flash_softdevice
	@echo		sdk_config - starting external tool for editing sdk_config.h
	@echo		flash      - flashing binary

TEMPLATE_PATH := $(SDK_ROOT)/components/toolchain/gcc


include $(TEMPLATE_PATH)/Makefile.common

$(foreach target, $(TARGETS), $(call define_target, $(target)))

.PHONY: flash flash_softdevice erase

# Flash the softdevice
#flash_softdevice:
#	@echo Flashing: s132_nrf52_6.1.1_softdevice.hex
#	openocd -d2 -f ~/mcu/nrf52/openocd_nrf52-cmsis.cfg -c 'init_reset halt; program $(SDK_ROOT)/components/softdevice/s132/hex/s132_nrf52_6.1.1_softdevice.hex verify; reset; exit'

# Flash the program
flash: $(OUTPUT_DIRECTORY)/nrf52832_xxaa.hex
	openocd -d2 -f ~/mcu/nrf52/openocd_nrf52-cmsis.cfg -c 'init_reset halt; program $< verify; reset; exit'

# disable control access port protection
recover:
	openocd -d2 -f ~/mcu/nrf52/openocd_nrf52-cmsis.cfg -c 'init; nrf52.dap apreg 1 0x0c; reset; exit'

# erase all flash
erase:
	openocd -d2 -f ~/mcu/nrf52/openocd_nrf52-cmsis.cfg -c 'init_reset halt; init; reset halt; nrf5 mass_erase; reset; exit'


# erase all flash
reset:
	openocd -d2 -f ~/mcu/nrf52/openocd_nrf52-cmsis.cfg -c 'init_reset halt; init; reset halt; reset; exit'


SDK_CONFIG_FILE := ./config/sdk_config.h
CMSIS_CONFIG_TOOL := $(SDK_ROOT)/external_tools/cmsisconfig/CMSIS_Configuration_Wizard.jar
sdk_config:
	java -jar $(CMSIS_CONFIG_TOOL) $(SDK_CONFIG_FILE)
