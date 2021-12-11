# rram-programmer

Welcome to rram-programmer, this repo provides all the necessary files in order to update the firmware through DFU.

- ## Required Drivers
  - Atmel DFU Driver

- ## Pre-step: Install Atmel DFU Driver (Only needed the first time)
    Normally when you are using rram-pyterminal, the evaluation board is in application mode. Therefore in Device Manager you would see it listed as one of the COM ports, as the figure shown below.
![Picture1](https://user-images.githubusercontent.com/4018299/143365986-056bc2bd-62e2-43ff-8779-b3cc35bf9882.png)

    If this is your first time updating the firmware, there's high chance that the board in DFU mode won't be detected properly as the figure below.
![Picture1](https://user-images.githubusercontent.com/4018299/143366692-d520119c-c946-4038-9270-5b355b631aa3.png)

    In such case, go to "atmel driver" folder, right click "atmel_usb_dfu.inf", and select "Install", as the figure below. This would install the required inf file so the system could detect the board in DFU mode properly.
![Picture1](https://user-images.githubusercontent.com/4018299/143367450-af7aaa10-96bd-4d06-9305-cb0cce7fff5b.png)

    After the driver is installed, press Atmel Reset button and the board in DFU mode should be detected properly as the figure below.
![Picture1](https://user-images.githubusercontent.com/4018299/143366974-4324c8b0-6b13-4c6f-abd8-c6df71e3e25d.png)

- ## Main Steps
  - ### Step 1: Turn off the evaluation board
    ![Picture1](https://user-images.githubusercontent.com/4018299/143366200-1b21984f-7edd-4920-9431-c1d54f066c49.png)

  - ### Step 2: Switch from APP mode to DFU mode and reset the Atmel MCU, the power LED would be on after this step.
    ![Picture1](https://user-images.githubusercontent.com/4018299/143720957-882e2e4d-75b8-4611-98f1-36fea43fd9ed.png)

  - ### Step 3: Launch "dfu_programmer.bat" and key in 'y' or 'n' depending on your need, if the board is properly detected, it should be similar to the figure below.
    ![Picture1](https://user-images.githubusercontent.com/4018299/143366541-bbec3986-387d-4845-94d4-0b3bedbc0152.png)

  - ### Step 4: Switch back from DFU mode to APP mode and reset the Atmel MCU.
    ![Picture1](https://user-images.githubusercontent.com/4018299/143720880-0ca0e63b-d81d-408a-817c-5163b92f8960.png)

    There are three groups throughout the script: `FLASH`, `EEPROM`, and `External Flash`. Each with the explanation below:
    - `FLASH`: This firmware is for atmel atmega32u2 MCU, which controls the voltage regulator, DAC, external flash ... etc.
    - `EEPROM`: This is not a firmware, but rather some data that are the initial values for some settings, such as for voltage regulator the initial states and values for each voltages, initial values for the DAC outputs ... etc.
    - `External Flash`: This can be seperated into two categories: "ICSRL RRAM demo suite" and "Cortex M3 demo suite". "ICSRL RRAM demo suite" is essentially the firmware for [rram-pyterminal](https://github.com/muyachang/rram-pyterminal), and "Cortex M3 demo suite" is a set of firmwares that demonstrate basic functionalities of the ARM Cortex M3.

- ## Troubleshooting
  - ### Problem 1: dfu-programmer showing "no device present"
    ![Picture1](https://user-images.githubusercontent.com/4018299/143367076-c21a5b4f-c580-4467-a8c4-951ff3b7d060.png)

    - #### Possible cause 1: The board is not in DFU mode
      - ##### Solution: Follow the main steps and enter the DFU mode

    - #### Possible cause 2: Atmel Driver is not installed properly
      - ##### Solution: Follow the pre-step and install the driver

