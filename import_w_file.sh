#!/bin/bash

# Check if file argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file="$1"

# Check if file exists
if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found."
    exit 1
fi

# Read each line in the file
while read -r module_name vlan_number subnet; do
    # Import commands
    terraform import "module.${module_name}.aci_bridge_domain.devvie_bridge_domain" "uni/tn-devvie/BD-vlan_${vlan_number}_bd"
    terraform import "module.${module_name}.aci_application_profile.devvie_app_profile" "uni/tn-devvie/ap-${module_name}_ap"
    terraform import "module.${module_name}.aci_application_epg.devvie_application_epg" "uni/tn-devvie/ap-${module_name}_ap/epg-${module_name}_epg"
    terraform import "module.${module_name}.aci_epg_to_domain.net_2_domain" "uni/tn-devvie/ap-${module_name}_ap/epg-${module_name}_epg/rsdomAtt-[uni/phys-physdom_devvie]"
    terraform import "module.${module_name}.aci_subnet.subnet" "uni/tn-devvie/ap-${module_name}_ap/epg-${module_name}_epg/subnet-[${subnet}]"
done < "$input_file"