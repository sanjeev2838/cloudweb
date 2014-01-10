json.set! :status ,true
json.child do
    json.ipaddress  @child_profile.ipaddress
    json.firmware  @child_profile.firmware
    json.bootloader @child_profile.bootloader
    json.hwconfig  @child_profile.hwconfig
    json.macaddress  @child_profile.macaddress
end