;@Ahk2Exe-SetMainIcon %A_ScriptDir%\SpotifyNoControl.ico
#NoTrayIcon
Global SPOTIFY_PATH:= A_Args[1], SPOTIFY_EXE:= "spotify.exe"
Try{
    ; if spotify is running -> get the PID
    WinGet, sPID, PID , ahk_exe %SPOTIFY_EXE%
    if(!sPID){ ; if not, run spotify
        Run,% SPOTIFY_PATH? SPOTIFY_PATH : "spotify:" , %A_AppData%, Hide, sPID
        ; wait for the window to exist
        WinWait, ahk_exe %SPOTIFY_EXE%,, 5
        ; get the PID
        WinGet, sPID, PID
        WinShow, 
    }
    ; Focus the main window
    WinActivate, ahk_pid %sPID%
    WinGet, sHwnd, List, ahk_pid %sPID%
    Loop, %sHwnd% {
        if(sHwnd%A_Index% = tempHwnd) ; skip the default window
            Continue
        ; resize the window to 0,0 and place it on the bottom of the z order
        DllCall("SetWindowPos", "UInt", sHwnd%A_Index%, "UInt", 1, "Int", 0, "Int", 0, "Int", 0, "Int", 0, "UInt", 0x0200 | 0x0002)
    }
    ExitApp, 0
} Catch {
    ExitApp, 1
}
