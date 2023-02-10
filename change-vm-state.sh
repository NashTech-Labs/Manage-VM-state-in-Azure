#!/bin/bash
nextcount=0
while [ $nextcount -ne 1 ]
do

echo "List of VM's"
az vm list -d -o table

echo "Enter VM Name:"
read vmname

echo "Enter Resource group Name:"
read vmrg

# read -p "Enter number for"$'\n'"1.Start VM"$'\n'"2.Stop VM"$'\n'choice

read -p "Enter number for:
    1.Start VM
    2.Stop VM ---> " choice

 case $choice in
     1)
       echo "Checking VM already in running state or not"
       vm_status=$(az vm get-instance-view --name $vmname --resource-group $vmrg --query instanceView.statuses[1] --output table | grep -o "VM running")
       echo $vm_status
       vm_current_state="VM running"

        if [[ $vm_current_state == $vm_status ]]; then
          echo "VM is already running"
        else
         az vm start --resource-group $vmrg --name $vmname
          echo "------Starting VM------"
        fi
     ;;
     2)
       echo "Checking VM already in stopped state or not"
       vm_status1=$(az vm get-instance-view --name $vmname --resource-group $vmrg --query instanceView.statuses[1] --output table | grep -o "VM stopped")
       echo $vm_status1
       vm_current_state="VM stopped"

        if [[ $vm_current_state == $vm_status1 ]]; then
          echo "VM is already stopped"
        else
         az vm stop --resource-group $vmrg --name $vmname
          echo "------Stopping VM------"
        fi
     ;;
     *)
     echo "Unknown value"
     ;;
    esac
    nextcount=1
    echo "Do you want to continue yes or no"  
    read temp
    if [ $temp = 'yes' ]; then
    nextcount=0
    fi
done