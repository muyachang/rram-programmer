
avrdude_bin=./avrdude.exe
config_file=avrdude.conf
partno=atmega32u2
programmer=stk500v1
port=COM3
baudrate=19200

flash_hex=firmwares/atmel-usbdfu.hex

fuse_low=0xFF
fuse_high=0xD9
fuse_ext=0xF4

# FLASH
echo "=============="
echo "= Bootloader ="
echo "=============="
while true; do
	read -p 'Do you want to erase flash first (Y/N)? ' yn
	case $yn in
		[Yy]* ) $avrdude_bin -e -p $partno -c $programmer -C $config_file -P $port -b $baudrate; break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done
while true; do
	read -p 'Do you want to program flash with '$flash_hex' (Y/N)? ' yn
	case $yn in
		[Yy]* ) $avrdude_bin -p $partno -c $programmer -C $config_file -P $port -b $baudrate -D -U flash:w:$flash_hex; break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done
echo ""

# FUSE
echo "========="
echo "= Fuses ="
echo "========="
while true; do
	read -p 'Do you want to program fuses with lfuse:'$fuse_low' hfuse:'$fuse_high' efuse:'$fuse_ext' (Y/N)?' yn
	case $yn in
		[Yy]* ) $avrdude_bin -p $partno -c $programmer -C $config_file -P $port -b $baudrate -U lfuse:w:$fuse_low:m -U hfuse:w:$fuse_high:m -U efuse:w:$fuse_ext:m; break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done
echo ""

read -p 'Press any key to exit ...' yn


# Some additional information
#   Erase and Write:
#     ./avrdude.exe -v -e -p atmega32u2 -c stk500v1 -C avrdude.conf -P COM3 -b 19200 -D -U flash:w:Firmwares/atmel-usbdfu.hex
#   Write Fuse:
#     ./avrdude.exe -v    -p atmega32u2 -c stk500v1 -C avrdude.conf -P COM3 -b 19200 -D -U lfuse:w:0xFF:m -U efuse:w:0xF4:m -U hfuse:w:0xD9:m
#   Write Lock Bits:
#     ./avrdude.exe -v    -p atmega16u2 -c stk500v1 -C avrdude.conf -P COM3 -b 19200 -D -U lock:w:0xFF:m
