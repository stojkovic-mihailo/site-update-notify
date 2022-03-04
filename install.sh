#!/bin/bash
#CHECKING ALL REQUIRED SOFTWARE
reqs=("curl" "notify-send" "paplay")
dir_base="./"
install_command=""

function set_install_command(){
    install_command="zypper -n in "
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
    echo "Installing required software..."
    set_install_command
    install_reqs
    
    echo "Making directory tree at $dir_base"
    mkdir -p "$dir_base/entries/.tmp" 
    echo "All done."
}



main
