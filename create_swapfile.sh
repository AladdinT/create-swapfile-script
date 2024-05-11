#!/bin/bash

# Check if script is run with sudo
if [ "$(id -u)" != "0" ]; then
    echo "Please run this script with sudo."
    exit 1
fi

# List used and free memory
echo "Memory usage:"
free -h
echo -e "\033[0;33m====================\033[0m"

# List active swap files
echo "Active swap files:"
swapon
echo -e "\033[0;33m====================\033[0m"

# List available free space
echo "Available free space:"
df -h --total | head -n 1
df -h --total | tail -n 1
echo -e "\033[0;33m====================\033[0m"
 
# Ask user if they want to create a new swapfile
read -p "Do you want to create a new swapfile? (Y/N): " choice

if [[ "$choice" =~ ^(y|Y|yes|YES|Yes)$ ]]; then
    # Find an available swapfile name
    count=1
    swapfile="swapfile"
    while [ -e "/$swapfile$count" ]; do
        ((count++))
    done
    swapfile="/$swapfile$count"

    # Ask user for the size of the swapfile in GB
    read -p "Enter the size of the $swapfile in GB: " size

    # Calculate the size in bytes
    size_in_Mbytes=$(echo "($size * 1024) / 1" | bc)

    echo -e "\033[0;43m== FLASHING ${size_in_Mbytes}MBs to ${swapfile} ==\033[0m"
    # Create the swapfile
    sudo dd if=/dev/zero of="$swapfile" bs=1M count="$size_in_Mbytes" status=progress

    echo -e "\033[0;43m== GRANTING PERMISSION to ${swapfile} ==\033[0m"
    # Set permissions
    sudo chmod 600 "$swapfile"
    ls -l $swapfile

    echo -e "\033[0;43m== ACTIVATING ${swapfile} ==\033[0m"
    # Set up Linux swap area
    sudo mkswap "$swapfile"

    # Enable swapfile
    sudo swapon "$swapfile"

    # Add entry to /etc/fstab
    echo "$swapfile none swap sw 0 0" | sudo tee -a /etc/fstab

    echo -e "\033[0;32m== ${swapfile} CREATED SUCESSFULLY ==\033[0m"
    # Show message and list memory
    echo -e "\033[0;42m Memory after swapfile creation: \033[0m"
    free -h
    echo -e "\033[0;42m Listing active swapfiles: \033[0m"
    swapon

else
    echo "No swapfile created."
    echo "Exiting...."
fi

