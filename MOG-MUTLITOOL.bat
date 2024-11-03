��
@echo off
setlocal enabledelayedexpansion

:: Create a temporary VBS script to show a message box
echo Set objArgs = WScript.Arguments > %temp%\messagebox.vbs
echo MsgBox "MOG-MULTITOOL made by @misterofgames_yt", 0, "Welcome" >> %temp%\messagebox.vbs

:: Run the VBS script to display the message box
cscript //nologo %temp%\messagebox.vbs

:: Delete the temporary VBS script
del %temp%\messagebox.vbs

:: Print a welcome message
echo.
echo Welcome to the Discord Multi-Tool!
echo You can include emojis in your messages by copying and pasting them.
echo.

:: Ask for User Choice
:chooseMethod
cls
echo Choose how you want to send messages:
echo 1. Use Webhook URL
echo 2. Use Account Token
echo 3. Exit
set /p method="Choose an option (1-3): "

if "%method%"=="1" goto webhookMethod
if "%method%"=="2" goto tokenMethod
if "%method%"=="3" exit

goto chooseMethod

:webhookMethod
cls
set /p webhook="Enter your Webhook URL: "
:sendWebhookMessage
set /p message="Enter the message to send (you can include emojis): "
echo Sending message via Webhook...

:: Send message using the webhook URL and suppress output
curl -k -X POST -H "Content-Type: application/json" -d "{\"content\":\"%message%\"}" %webhook% > nul 2>&1

echo Message sent via Webhook!
set /p again="Do you want to send another message? (y/n): "
if /i "%again%"=="y" goto sendWebhookMessage
goto chooseMethod

:tokenMethod
cls
set /p token="Enter your Account Token: "
set /p channel_id="Enter the Channel ID where you want to send messages: "
:sendTokenMessage
set /p message="Enter the message to send (you can include emojis): "
echo Sending message via Account Token...

:: Send message using the account token and channel ID and suppress output
curl -k -X POST -H "Authorization: %token%" -H "Content-Type: application/json" -d "{\"content\":\"%message%\"}" https://discord.com/api/v10/channels/%channel_id%/messages > nul 2>&1

echo Message sent via Account Token!
set /p again="Do you want to send another message? (y/n): "
if /i "%again%"=="y" goto sendTokenMessage
goto chooseMethod