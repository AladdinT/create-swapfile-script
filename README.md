# Create Swapfile Script

This Bash script automates the process of creating a swapfile on a Linux system. Swapfiles are used to provide additional virtual memory when physical RAM is full, thereby preventing system slowdowns and crashes due to memory exhaustion.

## How to Execute the Script

1. Clone this repository to your local machine using the following command:
    ```
    git clone https://github.com/AladdinT/create-swapfile-script
    ```
3. Navigate to the directory containing the script:
    ```
    cd create-swapfile-script
    ```
4. Make the script executable:
    ```
    sudo chmod +x create_swapfile.sh
    ```
5. Run the script with sudo privileges:
    ```
    sudo ./create_swapfile.sh
    ```

## Script Functionality

- Lists used and free memory, active swap files, and available free space.
- Prompts the user to create a new swapfile.
- If the user chooses to create a swapfile:
    - Prompts for the size of the swapfile in GB.
    - Creates the swapfile, sets permissions, activates it, and adds an entry to /etc/fstab for automatic activation on boot.
- Displays success messages and the memory status after swapfile creation.
  ![Screenshot from 2024-05-11 08-17-41](https://github.com/AladdinT/create-swapfile-script/assets/73729408/415fc214-8a19-4f02-a41e-13097f00d5d8)


## Note

- It's important to review the script and understand its implications before executing it, especially on production systems.
- Make sure you have sufficient disk space available before creating a swapfile.
