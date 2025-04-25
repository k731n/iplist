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
italic="\e[3m"
noItalic="\e[23m"
bold="\e[1m"
underline="\e[4m"
reset="\e[0m"
# Modo silencioso

silent=0

for arg in "$@"; do
  if [ "$arg" == "-s" ]; then
    silent=1
    break
  fi
done

if [ "$silent" -eq 1 ]; then
  exec &>/dev/null
fi

function helpPanel(){

  echo -e "\n${greenColour}╔══════════════════════════════════════════════════════ ${purpleColour}${bold}${underline}::: ${reset}${endColour}${greenColour}${bold}${underline}IPlist${reset}${endColour}${purpleColour}${bold}${underline} :::${reset}${greenColour} ══════════════════════════════════════════════════════╗ ${endColour}\n"
  echo -e "${purpleColour}[*]${endColour} ${grayColour}Format${endColour}${greenColour}:${endColour}"
  echo -e "\t\t${purpleColour}╭─[Interface ID] ${endColour}${grayColour}Interface ${endColour}${greenColour}════════ ${endColour}${grayColour}IP ${endColour}${greenColour}════════ ${endColour}${grayColour}Netmask ${endColour}${greenColour}════════ ${endColour}${grayColour}Broadcast IP ${endColour}${purpleColour}[Interface ID]─╮${endColour}\n"
  echo -e "${purpleColour}[*] ${endColour}${grayColour}Use${endColour}${greenColour}:${endColour}"
  printf "\t${grayColour}%-28s${endColour}${greenColour} ---> ${endColour}${grayColour} %b%s${endColour}\n" \
    "$0" "${purpleColour}List ${endColour}${grayColour}all interfaces and an ${endColour}${purpleColour}[ID]${endColour} ${grayColour}for easy copy${endColour}"
  printf "\t${grayColour}%s ${endColour}${purpleColour}%-16s${endColour}${greenColour} ---> ${endColour}${grayColour} %b%s${endColour}\n" \
    "$0" "<id>" "${purpleColour}Copy ${endColour}${grayColour}IP(s) of the selected ${endColour}${purpleColour}interface(s) ID(s) ${endColour}${grayColour}to clipboard${endColour}"
  printf "\t${grayColour}%s ${endColour}${purpleColour}%-16s${endColour}${greenColour} ---> ${endColour}${grayColour} %b%s${endColour}\n" \
    "$0" "<inteface>" "${purpleColour}Copy ${endColour}${grayColour}IP(s) of the given ${purpleColour}interface(s) name(s)${endColour}${grayColour} to clipboard${endColour}"
  printf "\t${grayColour}%s ${endColour}${purpleColour}%-11b${endColour}${greenColour} ---> ${endColour}${grayColour} %b%s${endColour}\n" \
    "$0" "${purpleColour}-s <id${endColour}${greenColour}/${endColour}${purpleColour}inteface>${endColour}" "Use the ${purpleColour}silent mode ${endColour}${grayColour}to ${purpleColour}copy ${endColour}${grayColour}selected ${purpleColour}interface ${endColour}${grayColour}IP(s) to clipboard${endColour}"
  printf "\t${grayColour}%s ${endColour}${purpleColour}%-15s ${endColour} ${greenColour}---> ${endColour}${grayColour} %b%s${endColour}\n" \
    "$0" "-a" "${purpleColour}Copy all ${endColour}${grayColour}interfaces IPs to clipboard${endColour}"
  printf "\t${grayColour}%s ${endColour}${purpleColour}%-16s${endColour}${greenColour} ---> ${endColour}${grayColour} %b%s${endColour}\n" \
    "$0" "-h" "${purpleColour}Show${endColour}${grayColour} this panel                                                          ${endColour}${grayColour}${italic}by ${noItalic}${endColour}${redColour}${italic}k731n${noItalic}${endColour}"
  #echo -e "${grayColour}${italic}by ${noItalic}${endColour}${redColour}${italic}k731n${noItalic}${endColour}"
  echo -e "\n${greenColour}╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ ${endColour}\n"
}


function copyAllIP(){
  allIPs=()
  interfaces=()
for interface in $(ls /sys/class/net/); do
  # Obtener la dirección IP de cada interfaz
  IPs=$(ip -o -4 addr show "$interface" 2>/dev/null | awk '{print $4}' | cut -d "/" -f1)

  for ip in $IPs; do
    allIPs+=("$ip")  
  done

  interfaces+=("$interface")
done


  if [ "${#allIPs[@]}" -gt 0 ]; then
    echo -n ${allIPs[@]} 2>/dev/null | sed 's/ /, /g' | xclip -selection clipboard
    echo -e "\n${greenColour}[*]${endColour} ${grayColour}The IP(s) of the interface(s)${endColour}${purpleColour}: ${endColour}${greenColour}$(echo "${interfaces[@]}" | sed 's/ /, /g')${endColour}${grayColour} have been copied to clipboard.${endColour}\n"
  else
    echo -e "\n\n${redColour}[!] ${endColour}${grayColour}The interface ${endColour}${redColour}$selected_interface ${endColour}${grayColour}has no IP assigned.${endColour}\n"
  fi
}



# Indicadores
copy_all=false

while getopts ":ash" arg; do
  case $arg in 
    a) copy_all=true ;;
    h) helpPanel; exit 0;;
    \?) echo -e "\n${redColour}[!] Invalid option: -$OPTARG${endColour}" >&2; helpPanel; exit 1;;
  esac
done

shift $((OPTIND -1))

if $copy_all;then
  copyAllIP 
  exit 0
fi




if [ -z "$1" ]; then
  i=1
  declare -A indexed_interfaces
  printed=0
  interfaces=($(ls /sys/class/net/))
  last_index=$((${#interfaces[@]} -1))

  echo -e "\n\n${greenColour}╔═════════════════════════════════ ${endColour}${purpleColour}Available Interfaces${endColour}${greenColour} ═════════════════════════════════╗ ${endColour}\n"
  
  max_len=0
  for iface in "${interfaces[@]}"; do
    len=${#iface}
    (( len > max_len )) && max_len=$len
  done

  max_len_ip=0
  for iface in "${interfaces[@]}"; do
    ip_address=$(ip -o -4 addr show "$iface" 2>/dev/null | awk '{print $4}' | cut -d "/" -f1 | head -n1)
    len_ip=${#ip_address}
    (( len_ip > max_len_ip )) && max_len_ip=$len_ip
  done

  max_len_netmask=0
  for iface in "${interfaces[@]}"; do
    netmask=$(ifconfig | grep -A 1 "$iface:" | tail -n 2 | awk 'NR == 2' | grep "inet"  | awk '{print $4}')
    len_netmask=${#netmask}
    if [ -n $no_netmask ]; then
        len_netmask=14     
    fi
    (( len_netmask > max_len_netmask )) && max_len_netmask=$len_netmask
  done

  max_len_broadcast=0
  for iface in "${interfaces[@]}"; do
    broadcast=$(ifconfig | grep -A 1 "$iface:" | tail -n 2 | awk 'NR == 2' | grep "inet"  | awk '{print $6}')
    len_broadcast=${#broadcast}
    if [ -n $no_broadcast ]; then
      len_broadcast=14     
    fi
    (( len_broadcast > max_len_broadcast )) && max_len_broadcast=$len_broadcast
  done


  for index in "${!interfaces[@]}"; do
    # Obtener la dirección IP de cada interfaz
    interface="${interfaces[$index]}"
    ip_address=$(ip -o -4 addr show "$interface" 2>/dev/null | awk '{print $4}' | cut -d "/" -f1 | head -n 1)

    netmask=$(ifconfig | grep -A 1 "$interface:" | tail -n 2 | awk 'NR == 2' | grep "inet"  | awk '{print $4}')
    netmask_bar=$(echo -e "${greenColour} ════════ ${endColour}")
    [[ -z "$netmask" ]] && no_netmask=true

    broadcast=$(ifconfig | grep -A 1 "$interface:" | tail -n 2 | awk 'NR == 2' | grep "inet"  | awk '{print $6}')
    broadcast_bar=$(echo -e "${greenColour} ════════ ${endColour}")

    indexed_interfaces["$i"]="$interface"


     # Comprobar si la interfaz tiene IP

    if [ -z "$netmask" ]; then
        netmask="-- NO NTMSK --"
        netmask_bar=$(echo -e "${redColour} ════════ ${endColour}")
    fi

      
    if [ -z "$broadcast" ]; then
        broadcast="-- NO BCAST --"
        broadcast_bar=$(echo -e "${redColour} ════════ ${endColour}")
    fi


    if [ -n "$ip_address" ]; then
      if [ "$printed" -eq 0 ]; then
        prefix="╭─"
        prefix_right="─╮"
      elif [ "$index" -eq "$last_index" ]; then
        prefix="╰─"
        prefix_right="─╯"
      else
        prefix="├─"
        prefix_right="─┤"
      fi 

    printf "${purpleColour}%s${endColour}${purpleColour}[%d] ${endColour}${grayColour}%-*s${endColour}${greenColour} ════════ ${endColour}${grayColour}%-*s${endColour}%s${grayColour}%-*s${endColour}%s${grayColour}%-*s${endColour}${purpleColour} [%d]${endColour}${purpleColour}${prefix_right} ${endColour}\n" \
    "$prefix" "$i" "$max_len" "$interface" "$max_len_ip" "$ip_address" "$netmask_bar" "$max_len_netmask" "$netmask" "$broadcast_bar" "$max_len_broadcast" "$broadcast" "$i"
      printed=1
    else 
      if [ "$printed" -eq 0 ]; then
        prefix="╭─"
        prefix_right="─╮"
      elif [ "$index" -eq "$last_index" ]; then
        prefix="╰─"
        prefix_right="─╯"
      else
        prefix="├─"
        prefix_right="─┤"
      fi
    if [[ -z "$ip_address" ]]; then
      raw_ip_address="-- NO IP -- "
      padded_ip=$(printf "%-${max_len_ip}s" "$raw_ip_address")
      ip_address=$(echo -e "${grayColour}${padded_ip}${endColour}")
      suffix="[!]"
    else
      padded_ip=$(printf "%-${max_len_ip}s" "$ip_address")
      ip_address="${grayColour}${padded_ip}${endColour}"
      suffix="[$i]"
    fi

    printf "${redColour}%s${endColour}${redColour}%s ${endColour}${grayColour}%-*s${endColour}${redColour} ════════ ${endColour}${grayColour}%-*s${endColour}%s${grayColour}%-*s${endColour}%s${grayColour}%-*s${endColour}${redColour} %s${endColour}${redColour}${prefix_right} ${endColour}\n" \
    "$prefix" "$suffix" "$max_len" "$interface" "$max_len_ip" "$ip_address" "$netmask_bar" "$max_len_netmask" "$netmask" "$broadcast_bar" "$max_len_broadcast" "$broadcast" "$suffix"
    printed=1
    fi
    ((i++))
  done

echo -e "\n${greenColour}╚════════════════════════════════════════════════════════════════════════════════════════╝${endColour}\n"

elif [ "$#" -ge 1 ]; then
  i=1
  declare -A indexed_interfaces
  name_iface=()

  for interface in $(ls /sys/class/net/); do
    indexed_interfaces["$i"]="$interface"
    ((i++))
  done

  for arg in "$@"; do

    if [[ "$arg" =~ ^[0-9]+$ ]]; then
      iface="${indexed_interfaces[$arg]}"
      [ -n "$iface" ] && resolved_interfaces+=("$iface")
      name_iface+=("$iface")
    else
      resolved_interfaces+=("$arg")
      name_iface+=("$arg")
    fi
  done

  ip_output=()

  # Si se especifica una interfaz, copiar su IP al portapapeles y mostrar el mensaje
  for selected_interface in "${resolved_interfaces[@]}"; do
  ip_address=$(ip -o -4 addr show "$selected_interface" 2>/dev/null | awk '{print $4}' | cut -d "/" -f1)

  if [ -n "$ip_address" ]; then
    ip_output+=("$ip_address")
  fi
  done

  if [ -n "$ip_output" ] && [ -n "$ip_address" ]; then
    echo -n "${ip_output[@]}" | sed 's/ /, /g' | xclip -selection clipboard
    echo -e "\n${greenColour}[+]${endColour} ${grayColour}The IP(s) of the interface(s)${endColour}${purpleColour}: ${endColour}${greenColour}$(echo ${name_iface[@]} | sed 's/ / - /g') ${endColour}${grayColour}have been copied to clipboard.${endColour}\n"
  else
    echo -e "\n\n${redColour}[!] ${endColour}${grayColour}The interface(s) ${endColour}${redColour}$selected_interface ${endColour}${grayColour}has no IP assigned.${endColour}\n"
    exit 1
  fi

fi
