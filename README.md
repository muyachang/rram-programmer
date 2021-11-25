# rram-programmer

Welcome to rram-programmer, this repo provides all the necessary files in order to update the firmware through DFU.

### Required Drivers
- Atmel DFU Driver

### Pre-step: Install Atmel DFU Driver (Only needed the first time)
Normally when you are using rram-pyterminal, the evaluation board is in application mode. Therefore in Device Manager you would see it listed as one of the COM ports, as the figure shown below.
![Picture1](https://user-images.githubusercontent.com/4018299/143365986-056bc2bd-62e2-43ff-8779-b3cc35bf9882.png)

If this is your first time updating the firmware, there's high chance that the board under DFU mode won't be detected properly as the figure below.
![Picture1](https://user-images.githubusercontent.com/4018299/143366692-d520119c-c946-4038-9270-5b355b631aa3.png)

In such case, go to "atmel driver" folder, right click "atmel_usb_dfu.inf", and select "Install". This would install the required inf file so the system could detect the board under DFU mode properly. After this is done, press atmel reset button and the board should be detected properly as the figure below.
![Picture1](https://user-images.githubusercontent.com/4018299/143366974-4324c8b0-6b13-4c6f-abd8-c6df71e3e25d.png)

### Main Steps
#### Step 1: Turn off the evaluation board
![Picture1](https://user-images.githubusercontent.com/4018299/143366200-1b21984f-7edd-4920-9431-c1d54f066c49.png)

#### Step 2: Switch from APP mode to DFU mode, the power LED would be on after this step.
![Picture1](https://user-images.githubusercontent.com/4018299/143366339-c69582d0-e464-4348-84b1-e636c7a41c25.png)

![Picture1](https://user-images.githubusercontent.com/4018299/143366405-aa279e68-e6a8-48f1-a4c0-ec2bb29e3adf.png)

### Step 3: Launch "dfu_programmer.bat" and key in y/n depending on your need, if the board is properly detected, it should be similar to the figure below.
![Picture1](https://user-images.githubusercontent.com/4018299/143366541-bbec3986-387d-4845-94d4-0b3bedbc0152.png)

### Troubleshooting
#### dfu-programmer showing "no device present"
![Picture1](https://user-images.githubusercontent.com/4018299/143367076-c21a5b4f-c580-4467-a8c4-951ff3b7d060.png)

##### Possible cause 1: The board is not in DFU mode
###### Solution: Follow the main steps and enter the DFU mode

##### Possible cause 2: Atmel Driver is not installed properly
###### Solution: Follow the pre-step and install the driver

