CmdRun(Command){
	runwait,% auth . comspec . " /c " . Command . " 2>&1 | clip",, Hide
	return
}
MsgJoin(Strs*){
	Msg := JoinStr(Strs*)
	Msgbox,% Msg
}
JoinStr(params*){
    str := ""
	for index,param in params
		str .= AlignDigit(A_Index, 3) . "  :  " . param . "`n"
	return SubStr(str, 1, -StrLen("`n"))
}
AlignDigit(Value, NoD){
	Loop,% NoD - StrLen(Value)
	{
		Value := "0" . Value
	}
	return Value
}
class AGui{
	static HwndDict := Object()
	__New(options:="", title:=""){
		Gui, New, +HwndHwnd %options%, %title%
		this.Hwnd := Hwnd
		Gui, %Hwnd%:+LabelAGui
		AGui.HwndDict[Hwnd] := this
	}
	do(command, params*){
		Hwnd := this.Hwnd
		Gui, %Hwnd%:%command%, % params[1], % params[2], % params[3]
		return
	}
	add_agc(type, name, param="", text=""){
		this[name] := new AGuiControl(this, type, name, param, text)
		return
	}
	show(options:="", title:=""){
		this.do("show", options, title)
		return
	}
	submit(NoHide:=False){
		k := ""
		if (NoHide)
			k := "NoHide"
		this.do("submit", k)
		return
	}
	cancel(){
		this.do("Cancel")
		return
	}
	font(options:="", FontName:=""){
		this.do("Font", options, FontName)
		return
	}
	color(WindowColor:="", ControlColor:=""){
		this.do("Color", WindowColor, ControlColor)
		return
	}
	margin(x:="", y:=""){
		this.do("Margin", x, y)
		return
	}
	add_option(option){
		this.do("+" . option)
		return
	}
	remove_option(option){
		this.do("-" . option)
		return
	}
	menu(MenuName:=""){
		this.do("Menu", MenuName)
		return
	}
	hide(){
		this.do("Hide")
		return
	}
	minimize(){
		this.do("Minimize")
		return
	}
	maximize(){
		this.do("Maximize")
		return
	}
	restore(){
		this.do("Restore")
		return
	}
	flash(Off:=False){
		k := ""
		if (Off)
			k := "Off"
		this.do("Flash", k)
		return
	}
	add(ControlType, Options:="", Text:=""){
		this.do("Add", ControlType, Options, Text)
		return
	}
	close(){
		this.destroy()
		return
	}
	escape(){
		this.destroy()
		return
	}
    size(){
        return
    }
    dropfiles(){
        return
    }
    contextmenu(){
        return
    }
	destroy(){
		Hwnd := this.Hwnd
		if not (AGui.HwndDict.HasKey(Hwnd))
			return
		Gui, %Hwnd%:destroy
		AGui.HwndDict.Delete(Hwnd)
		return
	}
}
class AGuiControl{
	__New(target_gui, type, name="", param="", text=""){
		global
		name := "AGuiControlVar_" . name
		%name% := ""
		if (name == "AGuiControlVar_")
			name := ""
		target_gui.add(type, "v" . name . " " . param, text)
		this.gui := target_gui
        this.type := type
		this.name := name
	}
	__Set(name, value){
        Object := 
		if (name = "value"){
			this.do("", value)
			return
		}else if (name = "method"){
			this.add_option("g" . value)
			return
		}else{
			Object.__Set(this, name, value)
		}
	}
	__Get(name){
        Object :=
		if (name = "value"){
			name := this.name
			value := %name%
			return %value%
		}else{
			return Object.__Get(this, name)
		}
	}
	do(sub_command="", param=""){
		name := this.name
		sub_command := this.gui.Hwnd . ":" . sub_command
		GuiControl, %sub_command%, %name%, %param%
		return
	}
	text(string){
		this.do("text", string)
	}
	move(param){
		this.do("move", param)
	}
	movedraw(param){
		this.do("movedraw", param)
	}
	focus(){
		this.do("focus")
	}
	enable(){
		this.do("enable")
	}
	disable(){
		this.do("disable")
	}
	hide(){
		this.do("hide")
	}
	show(){
		this.do("show")
	}
	choose(n){
		this.do("choose", n)
	}
	choosestring(string){
		this.do("choosestring", string)
	}
	font(param){
		this.do("font", param)
	}
	add_option(option){
		this.do("+" . option)
	}
	remove_option(option){
		this.do("-" . option)
	}
    LV_Default(){
        this.gui.do("ListView", this.name)
    }
    LV_ModifyCol(ColumnNumber="", Options="", ColumnTitle=""){
        this.LV_Default()
        if (ColumnTitle == ""){
            return LV_ModifyCol(ColumnNumber, Options)
        }
        return LV_ModifyCol(ColumnNumber, Options, ColumnTitle)
    }
    LV_InsertCol(ColumnNumber, Options="", ColumnTitle=""){
        this.LV_Default()
        return LV_InsertCol(ColumnNumber, Options, ColumnTitle)
    }
    LV_DeleteCol(ColumnNumber){
        this.LV_Default()
        return LV_DeleteCol(ColumnNumber)
    }
    LV_Add(options="", Col*){
        this.LV_Default()
        return LV_Add(options, Col*)
    }
    LV_Insert(RowNumber, Options="", Col*){
        this.LV_Default()
        return LV_Insert(RowNumber, Options, Col*)
    }
    LV_Modify(RowNumber, Options="", Col*){
        this.LV_Default()
        return LV_Modify(RowNumber, Options, Col*)
    }
    LV_Delete(RowNumber=""){
        this.LV_Default()
        return LV_Delete(RowNumber)
    }
    LV_GetCount(Type=""){
        this.LV_Default()
        if (Type == ""){
            return LV_GetCount()
        }
        return LV_GetCount(Type)
    }
    LV_GetNext(StartingRowNumber, Type=""){
        this.LV_Default()
        return LV_GetNext(StartingRowNumber, Type)
    }
    LV_GetText(RowNumber, ColumnNumber=""){
        this.LV_Default()
        tmp := ""
        if (ColumnNumber == ""){
            LV_GetText(tmp, RowNumber)
        }
        LV_GetText(tmp, RowNumber, ColumnNumber)
        return tmp
    }
}
AGUIClose(GuiHwnd){
	AGui.HwndDict[GuiHwnd].close()
	return
}
AGUIEscape(GuiHwnd){
	AGui.HwndDict[GuiHwnd].escape()
	return true
}
class AGuiControlText extends AGuiControl{
	__New(target_gui){
		base.__New(target_gui, "Text")
	}
}
