json.set! :status ,true
json.machine do
    json.ipaddress  @machine.ipaddress
    json.firmware  @machine.firmware
    json.bootloader @machine.bootloader
    json.hwconfig  @machine.hwconfig
    json.macaddress  @machine.macaddress
end