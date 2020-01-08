#include include.ahk
otp_input := new AGui(, "otp_input")
otp_input.add_agc("text", "name_label", "", "name")
otp_input.add_agc("edit", "name", "w100")
otp_input.add_agc("text", "passphrase_label", "", "passphrase")
otp_input.add_agc("edit", "passphrase", "w100 Password*")
otp_input.add_agc("Button", "OK", "Hidden Default")
otp_input.OK.method := "otp_input_ok"
otp_input.close := Func("otp_input_close")
otp_input.escape := Func("otp_input_close")
otp_input.show("AutoSize")
return
otp_input_ok(){
    global otp_input
    otp_input.submit("NoHide")
    CmdRun("wsl bash $(wslpath -u """ . A_ScriptDir . """)/print-onetimepass.sh " . otp_input.name.value . " " . otp_input.passphrase.value)
    otp_input.destroy()
    ExitApp
}
otp_input_close(){
    global otp_input
    otp_input.destroy()
    ExitApp
}
