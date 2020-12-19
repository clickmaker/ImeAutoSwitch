#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include lib\IME.ahk
#InstallKeybdHook

; メイン
_Main:
    SetTimer,_ImeAutoSwitch,ON
return

_ImeAutoSwitch:
    ; キーの入力状態を取得する
    ; vk1C 変換キー
    ; キーリスト
    ; http://ahkwiki.net/KeyList
    ; 英数、ひらがな/カタカナ、全角/半角キーは動作不安定
    ; AutoHotkeyのバージョンが上がってvk~, sc~を分けて判定できるようになっている
    GetKeyState, KeyState, vk1C, P

    ; IME ON/OFFの状態を取得
    ImeState := IME_GET()
    
    ; キーを離している場合
    If KeyState = U
    {
        ; IME ONだったらOFFにする
        If ImeState = 1
        {
            IME_SET(0)
        }
    }
    ; キーを押している場合
    Else If KeyState = D
    {
        ; IME OFFだったらONにする。ひらがなモードにしている。
        If ImeState = 0
        {
            IME_SET(1)
            IME_SetConvMode(0x09)
        }
    }
    ; ウェイト
    Sleep 200
return



