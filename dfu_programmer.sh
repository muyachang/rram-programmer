
dfu_programmer_bin=./dfu_programmer.exe
partno=atmega32u2

flash_hex=firmwares/atmel-usbserial.hex
flash_eep=firmwares/atmel-usbserial.eep

rram_suite=(
	"firmwares/testchip-icsrl_uart_server.hex"
)

cortex_m3_suite=(
	"firmwares/testchip-apb_mux_tests.hex"
	"firmwares/testchip-debug_tests.hex"
	"firmwares/testchip-default_slaves_tests.hex"
	"firmwares/testchip-dhry.hex"
	"firmwares/testchip-dualtimer_demo.hex"
	"firmwares/testchip-gpio_driver_tests.hex"
	"firmwares/testchip-gpio_tests.hex"
	"firmwares/testchip-hello.hex"
	"firmwares/testchip-interrupt_demo.hex"
	"firmwares/testchip-memory_tests.hex"
	"firmwares/testchip-romtable_tests.hex"
	"firmwares/testchip-self_reset_demo.hex"
	"firmwares/testchip-sleep_demo.hex"
	"firmwares/testchip-timer_driver_tests.hex"
	"firmwares/testchip-timer_tests.hex"
	"firmwares/testchip-trace_tests.hex"
	"firmwares/testchip-uart_driver_tests.hex"
	"firmwares/testchip-uart_tests.hex"
	"firmwares/testchip-watchdog_demo.hex"
)	
	
	
	

# FLASH
echo "========="
echo "= Flash ="
echo "========="
while true; do
	read -p 'Do you want to erase flash first (Y/N)? ' yn
	case $yn in
		[Yy]* ) $dfu_programmer_bin $partno erase --flash; break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done
while true; do
	read -p 'Do you want to program flash with '$flash_hex' (Y/N)? ' yn
	case $yn in
		[Yy]* ) $dfu_programmer_bin $partno flash $flash_hex --flash; break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done
echo ""

# EEPROM
echo "=========="
echo "= EEPROM ="
echo "=========="
while true; do
	read -p 'Do you want to erase eeprom first (Y/N)? ' yn
	case $yn in
		[Yy]* ) $dfu_programmer_bin $partno erase --eeprom --force; break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done
while true; do
	read -p 'Do you want to program eeprom with '$flash_eep' (Y/N)? ' yn
	case $yn in
		[Yy]* ) $dfu_programmer_bin $partno flash $flash_eep --eeprom; break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done
echo ""

# EXTDF
echo "=================="
echo "= External Flash ="
echo "=================="
while true; do
	read -p 'Do you want to erase external flash first (Y/N)? ' yn
	case $yn in
		[Yy]* ) $dfu_programmer_bin $partno erase --extdf; break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done
while true; do
	read -p 'Do you want to program external flash with ICSRL RRAM demo suite (Y/N)? ' yn
	case $yn in
		[Yy]* ) for hexName in "${rram_suite[@]}"
				do
					echo "Programming: '$hexName' ... "
					$dfu_programmer_bin $partno flash $hexName --extdf --force --suppress-validation;
					echo ""
				done
				break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done
while true; do
	read -p 'Do you want to program external flash with Cortex M3 demo suite (Y/N)? ' yn
	case $yn in
		[Yy]* ) for hexName in "${cortex_m3_suite[@]}"
				do
					echo "Programming: '$hexName' ... "
					$dfu_programmer_bin $partno flash $hexName --extdf --force --suppress-validation;
					echo ""
				done
				break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done
echo ""

read -p 'Press any key to exit ...' yn

# Some additional information
#   [FLASH]
#     ./dfu_programmer.exe atmega32u2 erase --flash
#     ./dfu_programmer.exe atmega32u2 flash firmwares/atmel-usbserial.hex --flash
#   [EEPROM]
#     ./dfu_programmer.exe atmega32u2 erase --eeprom --force
#     ./dfu_programmer.exe atmega32u2 flash firmwares/atmel-usbserial.eep --eeprom
#   [EXTDF]
#     ./dfu_programmer.exe atmega32u2 erase --extdf
#     ./dfu_programmer.exe atmega32u2 flash firmwares/testchip-icsrl_uart_server.hex    --extdf --force --suppress-validation