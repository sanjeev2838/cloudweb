json.set! :status ,true
json.parentprofileid @parent_profile.id
json.machine do
    json.ipaddress  @parent_profile.machine.ipaddress
    json.firmware  @parent_profile.machine.firmware
    json.bootloader @parent_profile.machine.bootloader
    json.hwconfig  @parent_profile.machine.hwconfig
    json.macaddress  @parent_profile.machine.macaddress
end