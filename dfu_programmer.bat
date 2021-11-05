
@ECHO OFF

set dfu_programmer_bin=dfu_programmer.exe
set partno=atmega32u2

set flash_hex=firmwares/atmel-usbserial.hex
set flash_eep=firmwares/atmel-usbserial.eep

set rram_suite=^
	firmwares/testchip-icsrl_uart_server.hex

set cortex_m3_suite=^
	firmwares/testchip-apb_mux_tests.hex^
	firmwares/testchip-debug_tests.hex^
	firmwares/testchip-default_slaves_tests.hex^
	firmwares/testchip-dhry.hex^
	firmwares/testchip-dualtimer_demo.hex^
	firmwares/testchip-gpio_driver_tests.hex^
	firmwares/testchip-gpio_tests.hex^
	firmwares/testchip-hello.hex^
	firmwares/testchip-interrupt_demo.hex^
	firmwares/testchip-memory_tests.hex^
	firmwares/testchip-romtable_tests.hex^
	firmwares/testchip-self_reset_demo.hex^
	firmwares/testchip-sleep_demo.hex^
	firmwares/testchip-timer_driver_tests.hex^
	firmwares/testchip-timer_tests.hex^
	firmwares/testchip-trace_tests.hex^
	firmwares/testchip-uart_driver_tests.hex^
	firmwares/testchip-uart_tests.hex^
	firmwares/testchip-watchdog_demo.hex

::  FLASH
:erase_flash
echo =========
echo = Flash =
echo =========
set /p yn="Do you want to erase flash first (y/n)?"
if %yn%==y %dfu_programmer_bin% %partno% erase --flash & goto :write_flash
if %yn%==n goto :write_flash
echo Please answer y or n.
goto :erase_flash

:write_flash
set /p yn="Do you want to program flash with '%flash_hex%' (y/n)?"
if %yn%==y %dfu_programmer_bin% %partno% flash %flash_hex% --flash & goto :erase_eeprom
if %yn%==n goto :erase_eeprom
echo Please answer y or n.
goto :write_flash


::  EEPROM
:erase_eeprom
echo ==========
echo = EEPROM =
echo ==========
set /p yn="Do you want to erase eeprom first (y/n)?"
if %yn%==y %dfu_programmer_bin% %partno% erase --eeprom --force & goto :write_eeprom
if %yn%==n goto :write_eeprom
echo Please answer y or n.
goto :erase_eeprom

:write_eeprom
set /p yn="Do you want to program eeprom with '%flash_eep%' (y/n)?"
if %yn%==y %dfu_programmer_bin% %partno% flash %flash_eep% --eeprom & goto :erase_ext_flash
if %yn%==n goto :erase_ext_flash
echo Please answer y or n.
goto :write_eeprom


::  External Flash
:erase_ext_flash
echo ==================
echo = External Flash =
echo ==================
set /p yn="Do you want to erase external flash first (y/n)?"
if %yn%==y %dfu_programmer_bin% %partno% erase --extdf & goto :write_icsrl_suite_to_ext_flash
if %yn%==n goto :write_icsrl_suite_to_ext_flash
echo Please answer y or n.
goto :erase_ext_flash

:write_icsrl_suite_to_ext_flash
set /p yn="Do you want to program external flash with ICSRL RRAM demo suite (y/n)?"
if %yn%==y (
	(for %%h in (%rram_suite%) do (
		echo Programming: %%h ... 
		%dfu_programmer_bin% %partno% flash %%h --extdf --force --suppress-validation
		echo
	)) & goto :write_cortex_suite_to_ext_flash
)
if %yn%==n goto :write_cortex_suite_to_ext_flash
echo Please answer y or n.
goto :write_icsrl_suite_to_ext_flash

:write_cortex_suite_to_ext_flash
set /p yn="Do you want to program external flash with Cortex M3 demo suite (y/n)?"
if %yn%==y (
	(for %%h in (%cortex_m3_suite%) do (
		echo Programming: %%h ... 
		%dfu_programmer_bin% %partno% flash %%h --extdf --force --suppress-validation
		echo
	)) & goto :done
)
if %yn%==n goto :done
echo Please answer y or n.
goto :write_cortex_suite_to_ext_flash


:done
PAUSE



:: Some additional information
::   [FLASH]
::     ./dfu_programmer.exe atmega32u2 erase --flash
::     ./dfu_programmer.exe atmega32u2 flash firmwares/atmel-usbserial.hex --flash
::   [EEPROM]
::     ./dfu_programmer.exe atmega32u2 erase --eeprom --force
::     ./dfu_programmer.exe atmega32u2 flash firmwares/atmel-usbserial.eep --eeprom
::   [EXTDF]
::     ./dfu_programmer.exe atmega32u2 erase --extdf
::     ./dfu_programmer.exe atmega32u2 flash firmwares/testchip-icsrl_uart_server.hex    --extdf --force --suppress-validation