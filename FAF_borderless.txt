#cs ----------------------------------------------------------------------------

 AutoIt Version:  3.3.14.5
 Author:          Ajack

 Script Function: Make FA.exe app borderless fullscreen

#ce ----------------------------------------------------------------------------

#include <Constants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

; Get a handle on the Forged Alliance window (works after you launch the game / open lobby)
Local Const $hWnd = WinGetHandle("[TITLE:Forged Alliance; CLASS:wxWindowClass]")
If @error Then MsgBox(0, "error", "Could not get handle on the Forged Aliiance window")

; Get window style settings into a local var
Local $iStyle = _WinAPI_GetWindowLong($hWnd, $GWL_STYLE)

; Modify the variable - setting style settings with a XOR (deleting) and OR (adding)
$iStyle = BitOR(BitXOR($iStyle, $WS_MINIMIZEBOX, $WS_MAXIMIZEBOX, $WS_CAPTION, $WS_BORDER, $WS_SIZEBOX), $WS_POPUP)

; Apply the style to the window (override current window settings)
_WinAPI_SetWindowLong($hWnd, $GWL_STYLE, $iStyle)

; Set new window position
_WinAPI_SetWindowPos($hWnd, $HWND_TOP, 0, 0, @DesktopWidth, @DesktopHeight, $SWP_FRAMECHANGED)