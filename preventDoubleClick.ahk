; Request admin privileges if not already running as admin
if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Initialize the last click time variable
LastClickTime := 0

LButton::
CurrentTime := A_TickCount ;Had issues with A_TimeSincePriorHotkey 
TimeSinceLastClick := CurrentTime - LastClickTime

If (TimeSinceLastClick < 40) {
	; Too fast, ignore this click
	Return
} else {
	; Good timing, send the actual button press and preserve drag
	LastClickTime := A_TickCount
	Send {LButton Down}
	KeyWait, LButton  ; Wait for physical button release
	Send {LButton Up}
	Return
}

F12::
ExitApp
Return
