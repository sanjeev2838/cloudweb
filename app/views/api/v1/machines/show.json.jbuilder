json.set! :status ,true
json.set! :status_code , 2001
json.set! :message , "machine found"
json.machine do
    json.ipaddress  @machine.ipaddress
    json.firmware  @machine.firmware
    json.bootloader @machine.bootloader
    json.hwconfig  @machine.hwconfig
    json.macaddress  @machine.macaddress
end