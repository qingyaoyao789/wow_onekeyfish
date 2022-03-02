CoordMode "Pixel"
CoordMode "Mouse"
#MaxThreadsPerHotkey 3

MyGui := Gui(, "wow钓鱼脚本")
MyGui.Opt("+AlwaysOnTop   +Owner") 
MyGui.Add("Button", , "钓鱼").OnEvent("Click", Copyfish)
MyGui.Add("Button", , "还原").OnEvent("Click", Storenor)
MyGui.Add("Button", , "打开音量").OnEvent("Click", OpenVol)
MyGui.Add("Text", ,"按F1键启动(或暂停)钓鱼脚本")
MyGui.OnEvent("Close", ExitApp)
MyGui.Show()

Copyfish(*)
{
FileCopy "x:\...\fish\Config.wtf", "x:\World of Warcraft\_retail_\WTF",1 ;钓鱼设置 路径自行修改
sleep 500
FileCopy "x:\...\fish\AddOns.txt", "x:\World of Warcraft\_retail_\WTF\战网名\账号\服务器\角色名",1 ;钓鱼角色插件设置 路径自行修改
sleep 500
MsgBox "钓鱼设置复制完成"
}

Storenor(*)
{
FileCopy "x:\...\backup\Config.wtf", "x:\World of Warcraft\_retail_\WTF",1  ;恢复设置 路径自行修改
sleep 500
FileCopy "x:\...\backup\AddOns.txt", "x:\World of Warcraft\_retail_\WTF\战网名\账号\服务器\角色名",1 ;恢复角色插件设置 路径自行修改
sleep 500
MsgBox "正常设置复制完成"
}

OpenVol(*)
{
Run "C:\Windows\System32\sndvol.exe -t 69666530"  ;打开音量控制
}


F1::  ;F1启动(或暂停)脚本
{
MyGui.Show("x900 y82 NoActivate")
if WinExist("魔兽世界")
    WinActivate 
else
{
    msgbox "游戏未启动"
    return
}
static start_fish:=false
if start_fish
{
start_fish:=false
return
}
start_fish:=true
Loop
{
fish()
sleep 50
if not start_fish
break
}
start_fish:=false

}

fish()
{

Send "^4"  ;抛竿,自行修改
Starttime:=A_TickCount
sleep 500
fishx:=500
fishy:=460
loop
{
MouseMove fishx,fishy
sleep 200
if ImageSearch(&FoundX, &FoundY, 1488, 766, 1524,785, "*70 D:\wowtools\bot\fish\20220301\fishcheck.png")  ;鱼漂位置 和图片,对比
{
if A_TickCount-Starttime>20000
break
if PixelSearch(&Px, &Py, 1722, 935, 1725, 945,0x33bb33, 30) ;鱼上钩时,音量变大
{
Send "{F10}"  ;收钩,快捷键自行修改
sleep 500
break
}
}
else 
{
fishx+=50
if fishx>1410
{
sleep 100
break
}
}
sleep 100
}
sleep 100
}


+z::ExitApp ;shift+z 退出脚本
+x::Reload  ;shift+x 重置脚本
#MaxThreadsPerHotkey 1