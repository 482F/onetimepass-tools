#include include.ahk
otp_register := new AGui(, "otp_register")
otp_register.add_agc("text", "name_label", "", "name")
otp_register.add_agc("edit", "name", "w100")
otp_register.add_agc("text", "key_label", "", "secret key")
otp_register.add_agc("edit", "key", "w100 Password*")
otp_register.add_agc("text", "passphrase_label", "", "passphrase")
otp_register.add_agc("edit", "passphrase", "w100 Password*")
otp_register.add_agc("Button", "OK", "Hidden Default")
otp_register.OK.method := "otp_register_ok"
otp_register.show("AutoSize")
return
otp_register_ok(){
    global otp_register
    otp_register.submit("NoHide")
    if (otp_register.name.value == "" or otp_register.key.value == ""){
        msgjoin("Invalid name or key.")
        ExitApp
    }
    if (regExMatch(otp_register.name.value, "\s") != 0){
        msgbox, % "name """ . name . """ is invalid. Don't include space."
        ExitApp
    }
    CmdRun("wsl $(wslpath -u """ . A_ScriptDir . """)/register-onetimepass.sh " . otp_register.name.value . " " . otp_register.key.value . " " . otp_register.passphrase.value)
    otp_register.destroy()
    ExitApp
}
