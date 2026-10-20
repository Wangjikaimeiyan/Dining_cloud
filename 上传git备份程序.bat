@echo off
chcp 65001 >nul
title 一键Git提交推送
color 0A

:: === 强制所有输出及子进程使用 UTF-8 编码（解决 IDE 乱码）===
set "LANG=zh_CN.UTF-8"
set "LC_ALL=zh_CN.UTF-8"
set "PYTHONIOENCODING=utf-8"
set "LESSCHARSET=utf-8"
:: 对 Git 自身强制 UTF-8 输出
set "GIT_PAGER=cat"
set "LC_CTYPE=zh_CN.UTF-8"
:: 额外：设置控制台输出编码为 UTF-8（通过 PowerShell 静默执行）
powershell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8" 2>nul

set "msg="
for /f "delims=" %%s in ('powershell -Command "Add-Type -AssemblyName Microsoft.VisualBasic; $r=[Microsoft.VisualBasic.Interaction]::InputBox('请输入本次修改内容:','代码提交','日常更新'); if($r -ne $null){write $r}"') do set "msg=%%s"

if not defined msg (
    echo 已取消提交
    pause
    exit
)

echo.
echo 提交信息：%msg%
echo ------------------------
git add .
git commit -m "%msg%"
git push
echo ------------------------
echo 执行完毕！
pause