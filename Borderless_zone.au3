#cs ----------------------------------------------------------------------------

 AutoIt Version:  3.3.14.5
 Author:          Ajack

 Script Function: Make an app borderless fullscreen

#ce ----------------------------------------------------------------------------

#include <Constants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <WindowsConstants.au3>

#Region ### START Koda GUI section ### Form=
Global $Choose_game = GUICreate("Choose_game", 331, 223, -1, -1)
Global $Setting = GUICtrlCreateButton("SET", 96, 184, 75, 25)
Global $Abort = GUICtrlCreateButton("CANCEL", 176, 184, 75, 25)
Global $Selection = GUICtrlCreateList("", 8, 0, 313, 175)
GUICtrlSetData(-1, "Minecraft|Star Wars Jedi Outcast|Supreme Commander Forged Alliance")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $Setting
			$Pick = GUICtrlRead($Selection)
			Switch $Pick
				Case "Minecraft"
			Minecraft()
				Case "Star Wars Jedi Outcast"
			SWJO()
				Case "Supreme Commander Forged Alliance"
			SCFA()
			EndSwitch
		Case $Abort
			Exit
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd



; Get a handle on the Minecraft window
Func Minecraft()
	Global $hWnd = WinGetHandle("[TITLE:Minecraft; CLASS:LWJGL]")
	If @error Then handle_error()
	GUIDelete("Choose_game")
	apply_parameters()
EndFunc

; Get a handle on the Star Wars Jedi Outcast window
Func SWJO()
	Global $hWnd = WinGetHandle("[TITLE:Jedi Knight 2; CLASS:Jedi Knight 2]")
	If @error Then handle_error()
	GUIDelete("Choose_game")
	apply_parameters()
EndFunc

; Get a handle on the Supreme Commander Forged Alliance window
Func SCFA()
	Global $hWnd = WinGetHandle("[TITLE:Forged Alliance; CLASS:wxWindowClass]")
	If @error Then handle_error()
	GUIDelete("Choose_game")
	apply_parameters()
EndFunc

; Could not get a handle error
Func handle_error()
	GUIDelete("Choose_game")
	MsgBox(0, "error", "Could not get handle on the chosen window")
	Exit
EndFunc

Func apply_parameters()

; Get window style settings into a local var
Local $iStyle = _WinAPI_GetWindowLong($hWnd, $GWL_STYLE)

; Modify the variable - setting style settings with a XOR (deleting) and OR (adding)
$iStyle = BitOR(BitXOR($iStyle, $WS_MINIMIZEBOX, $WS_MAXIMIZEBOX, $WS_CAPTION, $WS_BORDER, $WS_SIZEBOX), $WS_POPUP)

; Apply the style to the window (override current window settings)
_WinAPI_SetWindowLong($hWnd, $GWL_STYLE, $iStyle)

; Set new window position
_WinAPI_SetWindowPos($hWnd, $HWND_TOP, 0, 0, @DesktopWidth, @DesktopHeight, $SWP_FRAMECHANGED)

Exit
EndFunc
