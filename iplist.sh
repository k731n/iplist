#!/bin/bash

# Color para mejorar la presentación

greenColour="\e[1;32m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Verifica si se pasó el nombre de la interfaz
selected_interface="$1"

# Mostrar todas las interfaces de red disponibles con sus direcciones IP
if [ -z "$selected_interface" ]; then
  echo -e "\n\n${yellowColour}󰌘 ${endColour} ${blueColour}Available interfaces ${endColour}${yellowColour}󰌘 \n\n ${endColour}"

  for interface in $(ls /sys/class/net/); do
    # Obtener la dirección IP de cada interfaz
    ip_address=$(ip -o -4 addr show "$interface" | awk '{print $4}' | cut -d "/" -f1)

    # Comprobar si la interfaz tiene IP
    if [ -n "$ip_address" ]; then
      echo -e "${turquoiseColour}INTERFACE ${endColour}${yellowColour}   ${endColour}${blueColour}$interface${endColour}${turquoiseColour} ${endColour}${yellowColour} 󱦂 ${endColour} ${redColour}$ip_address${endColour}\n"
    else 
      echo -e "${turquoiseColour}INTERFACE ${endColour}${yellowColour} 󱘖  ${endColour}${blueColour}$interface${endColour}${turquoiseColour} ${endColour} ${yellowColour} ${endColour}${turquoiseColour} NO IP ${endColour}${yellowColour} ${endColour}\n"
    fi
  done

else
  # Si se especifica una interfaz, copiar su IP al portapapeles y mostrar el mensaje
  ip_address=$(ip -o -4 addr show "$selected_interface" | awk '{print $4}' | cut -d "/" -f1)

  if [ -n "$ip_address" ]; then
    echo -n "$ip_address" | xclip -selection clipboard
    echo -e "\n\n${yellowColour}[*]${endColour} ${blueColour}IP ${endColour}${redColour}$selected_interface ${endColour}${blueColour}copied to clipboard.${endColour}\n"
  else
    echo -e "\n\n${redColour}[!] ${endColour}${yellowColour}The interface ${endColour}${redColour}$selected_interface ${endColour}${yellowColour}has no IP assigned.${endColour}\n"
  fi
fi
