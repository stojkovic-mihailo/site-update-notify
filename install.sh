#!/bin/bash
#CHECKING ALL REQUIRED SOFTWARE
reqs=("curl" "notify-send" "paplay")
dir_base="./"
install_command=""

#OS installation commands dict
declare -A os_ic
os_ic["id"]="pkg install "
os_ic["opensuse-tumbleweed"]="zypper -n in "
os_ic["debian"]="apt install "

function set_install_command(){
    os_id=$(grep -i '^ID="' /etc/os-release | sed 's/"//g' | sed 's/ID=//')
    echo "OS id $os_id got, checking compatibility..."
    if [ -v os_ic['$os_id'] ]; then
        install_command=os_ic['$os_id']
        echo "OS compatible with current version of the script"
        return 0
    else
        echo "Operating system with id $os_id is not compatible. Exiting..."
        return 1
    fi
    
}

function install_reqs(){
    
    for req in "${reqs[@]}"
    do
        if ! command -v $req &> /dev/null
        then
            echo "$req not found... trying to install"
            $install_command $req
        else
            echo "$req already installed"
        fi
    done
}

    




function main(){

    if [ "$EUID" -ne 0 ]; then
        echo "Installer Error. Run the script as super-user."
        return
    fi
    #Installing requirements
    set_install_command
    local status=$?
    if [ $status -ne "0" ]; then
        return 1
    fi
    echo "Installing required software..."
    install_reqs
    
    echo "Making directory tree at $dir_base"
    mkdir -p "$dir_base/entries/.tmp" 
    echo "All done."
    return 0
}



main
