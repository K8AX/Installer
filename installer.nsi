Unicode true

####################################################################
# Includes

!include MUI2.nsh
!include FileFunc.nsh
!include LogicLib.nsh

!insertmacro Locate
Var /GLOBAL switch_overwrite
!include MoveFileFolder.nsh

####################################################################
# File Info

!define PRODUCT_NAME "RobloxTX"
!define PRODUCT_DESCRIPTION "ReShade presets made by K8AX, made with care by Extravi."
!define COPYRIGHT "Copyright © 2023 sitiom, Extravi"
!define VERSION "1.0.1"

VIProductVersion "${VERSION}.0"
VIAddVersionKey "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey "ProductVersion" "${VERSION}"
VIAddVersionKey "FileDescription" "${PRODUCT_DESCRIPTION}"
VIAddVersionKey "LegalCopyright" "${COPYRIGHT}"
VIAddVersionKey "FileVersion" "${VERSION}.0"

####################################################################
# Installer Attributes

ManifestDPIAware true

Name "${PRODUCT_NAME}"
Outfile "Setup - ${PRODUCT_NAME}.exe"
Caption "Setup - ${PRODUCT_NAME}"
BrandingText "${PRODUCT_NAME}"

RequestExecutionLevel user
 
InstallDir "$LOCALAPPDATA\${PRODUCT_NAME}"

####################################################################
# Interface Settings

InstType "Full";1

####################################################################
# Pages

!define MUI_ICON "extravi-reshade.ico"
!define MUI_UNICON "extravi-reshade.ico"
!define MUI_ABORTWARNING
!define MUI_WELCOMEFINISHPAGE_BITMAP "extravi-reshade.bmp"
!define MUI_WELCOMEPAGE_TEXT "This will install ${PRODUCT_NAME} on your computer.$\r$\n\
$\r$\n\
Before continuing, ensure that Roblox is closed. If Roblox is open, the installer will terminate the process before it begins.$\r$\n\
$\r$\n\
There may be issues with the setup. If that's the case, it's recommended that you ask your questions in Extravi's Discord server, or contact ESportMan#4875 on Discord.$\r$\n\
$\r$\n\
Click Next to continue."
!define MUI_LICENSEPAGE_RADIOBUTTONS
!define MUI_COMPONENTSPAGE_NODESC
!define MUI_FINISHPAGE_TEXT_LARGE
!define MUI_FINISHPAGE_TEXT "Setup has finished installing ${PRODUCT_NAME} on your computer. The effects will be applied the next time you launch Roblox.$\r$\n\
$\r$\n\
Click Finish to exit Setup."
!define MUI_FINISHPAGE_SHOWREADME "https://docs.google.com/document/d/1DmP66mFuZK99pTsNyxmE7GxMVK2G-0YzPmWIxkA00nQ/edit?usp=sharing"
!define MUI_FINISHPAGE_SHOWREADME_CHECKED
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show RobloxTX documentation. (RECOMMENDED)"
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Subscribe to Extravi on youtube, again!"
!define MUI_FINISHPAGE_RUN_CHECKED
!define MUI_FINISHPAGE_RUN_FUNCTION "OpenLink"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "Extravi's ReShade-Preset\license.txt"
!insertmacro MUI_PAGE_COMPONENTS
!define MUI_PAGE_CUSTOMFUNCTION_SHOW "StartTaskbarProgress"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

####################################################################
# Language

!insertmacro MUI_LANGUAGE "English"

####################################################################
# Sections

Var robloxPath

SpaceTexts none

Section "ReShade (required)"
  SectionIn 1 RO

  ExecWait "TaskKill /IM RobloxPlayerBeta.exe /F"
  
  SetOutPath $INSTDIR

  WriteUninstaller "$INSTDIR\uninstall.exe"

  ; Uninstall Regkeys
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "DisplayIcon" "$INSTDIR\uninstall.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "DisplayVersion" "${VERSION}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "QuietUninstallString" "$INSTDIR\uninstall.exe /S"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "Publisher" "Extravi"

  NSCurl::http GET "https://github.com/BlueSkyDefender/AstrayFX/archive/refs/heads/master.zip" "AstrayFX-master.zip" /END
  nsisunz::Unzip "AstrayFX-master.zip" "$INSTDIR"
  Delete "AstrayFX-master.zip"

  NSCurl::http GET "https://github.com/BlueSkyDefender/Depth3D/archive/refs/heads/master.zip" "Depth3D-master.zip" /END
  nsisunz::Unzip "Depth3D-master.zip" "$INSTDIR"
  Delete "Depth3D-master.zip"

  NSCurl::http GET "https://github.com/crosire/reshade-shaders/archive/refs/heads/legacy.zip" "reshade-shaders-legacy.zip" /END
  nsisunz::Unzip "reshade-shaders-legacy.zip" "$INSTDIR"
  Delete "reshade-shaders-legacy.zip"

  NSCurl::http GET "https://github.com/crosire/reshade-shaders/archive/refs/heads/master.zip" "reshade-shaders-master.zip" /END
  nsisunz::Unzip "reshade-shaders-master.zip" "$INSTDIR"
  Delete "reshade-shaders-master.zip"

  NSCurl::http GET "https://github.com/JakobPCoder/ReshadeMotionBlur/archive/refs/heads/main.zip" "ReshadeMotionBlur-main.zip" /END
  nsisunz::Unzip "ReshadeMotionBlur-main.zip" "$INSTDIR"
  Delete "ReshadeMotionBlur-main.zip"

  NSCurl::http GET "https://github.com/luluco250/FXShaders/archive/refs/heads/master.zip" "FXShaders-master.zip" /END
  nsisunz::Unzip "FXShaders-master.zip" "$INSTDIR"
  Delete "FXShaders-master.zip"
  
  NSCurl::http GET "https://github.com/bituq/ZealShaders/archive/refs/heads/master.zip" "ZealShaders-master.zip" /END
  nsisunz::Unzip "ZealShaders-master.zip" "$INSTDIR"
  Delete "ZealShaders-master.zip"

  NSCurl::http GET "https://github.com/Fubaxiusz/fubax-shaders/archive/refs/heads/master.zip" "fubax-shaders-master.zip" /END
  nsisunz::Unzip "fubax-shaders-master.zip" "$INSTDIR"
  Delete "fubax-shaders-master.zip"

  NSCurl::http GET "https://github.com/martymcmodding/qUINT/archive/refs/heads/master.zip" "qUINT-master.zip" /END
  nsisunz::Unzip "qUINT-master.zip" "$INSTDIR"
  Delete "qUINT-master.zip"

  NSCurl::http GET "https://github.com/martymcmodding/ReShade-Optical-Flow/archive/refs/heads/main.zip" "ReShade-Optical-Flow-main.zip" /END
  nsisunz::Unzip "ReShade-Optical-Flow-main.zip" "$INSTDIR"
  Delete "ReShade-Optical-Flow-main.zip"

  NSCurl::http GET "https://github.com/rj200/Glamarye_Fast_Effects_for_ReShade/archive/refs/heads/main.zip" "qUINT-master.zip" /END
  nsisunz::Unzip "qUINT-master.zip" "$INSTDIR"
  Delete "qUINT-master.zip"

  NSCurl::http GET "https://github.com/Radegast-FFXIV/Warp-FX/archive/refs/heads/master.zip" "Warp-FX-master.zip" /END
  nsisunz::Unzip "Warp-FX-master.zip" "$INSTDIR"
  Delete "Warp-FX-master.zip"

  NSCurl::http GET "https://github.com/AlucardDH/dh-reshade-shaders/archive/refs/heads/master.zip" "dh-reshade-shaders-master.zip" /END
  nsisunz::Unzip "dh-reshade-shaders-master.zip" "$INSTDIR"
  Delete "dh-reshade-shaders-master.zip"

  NSCurl::http GET "https://github.com/rj200/Glamarye_Fast_Effects_for_ReShade/archive/refs/heads/main.zip" "Glamarye_Fast_Effects_for_ReShade-main.zip" /END
  nsisunz::Unzip "Glamarye_Fast_Effects_for_ReShade-main.zip" "$INSTDIR"
  Delete "Glamarye_Fast_Effects_for_ReShade-main.zip"

  NSCurl::http GET "https://github.com/mj-ehsan/NiceGuy-Shaders/archive/refs/heads/main.zip" "NiceGuy-Shaders-main.zip" /END
  nsisunz::Unzip "NiceGuy-Shaders-main.zip" "$INSTDIR"
  Delete "NiceGuy-Shaders-main.zip"

  NSCurl::http GET "https://github.com/CeeJayDK/SweetFX/archive/refs/heads/master.zip" "SweetFX-master.zip" /END
  nsisunz::Unzip "SweetFX-master.zip" "$INSTDIR"
  Delete "SweetFX-master.zip"

  NSCurl::http GET "https://github.com/brussell1/Shaders/archive/refs/heads/master.zip" "Shaders-master.zip" /END
  nsisunz::Unzip "Shaders-master.zip" "$INSTDIR"
  Delete "Shaders-master.zip"


  StrCpy $switch_overwrite 1 $INSTDIR

  RMDir /r "$robloxPath\reshade-presets"
  RMDir /r "$robloxPath\reshade-shaders"
  RMDir /r "$robloxPath\ClientSettings"
  Delete "$robloxPath\Reshade.ini"
  Delete "$robloxPath\dxgi.dll"
  Delete "$robloxPath\reshade.dll"

  !insertmacro MoveFolder "$INSTDIR\SweetFX-master" "$robloxPath\reshade-shaders" "*"
  RMDir /r "$INSTDIR\SweetFX-master"

  !insertmacro MoveFolder "$INSTDIR\AstrayFX-master\Shaders" "$robloxPath\reshade-shaders\Shaders\AstrayFX" "*"
  !insertmacro MoveFolder "$INSTDIR\AstrayFX-master\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\AstrayFX-master"
  Delete "$robloxPath\reshade-shaders\Shaders\AstrayFX\Clarity.fx"

  !insertmacro MoveFolder "$INSTDIR\Shaders-master" "$robloxPath\reshade-shaders" "*"
  RMDir /r "$INSTDIR\Shaders-master"

  !insertmacro MoveFolder "$INSTDIR\Depth3D-master\Shaders" "$robloxPath\reshade-shaders\Shaders\Depth3D" "*"
  !insertmacro MoveFolder "$INSTDIR\Depth3D-master\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\Depth3D-master"

  NSCurl::http GET "https://github.com/Extravi/extravi.github.io/raw/main/update/dependencies.zip" "dependencies.zip" /END
  nsisunz::Unzip "dependencies.zip" "$robloxPath\reshade-shaders\Shaders"
  Delete "dependencies.zip"

  NSCurl::http GET "https://raw.githubusercontent.com/cyrie/Stormshade/master/reshade-shaders/Shaders/MXAO.fx" "$robloxPath\reshade-shaders\Shaders\MXAO.fx" /END

  NSCurl::http GET "https://gist.githubusercontent.com/martymcmodding/69c775f844124ec2c71c37541801c053/raw/46a4ea9894e7aed287e3c86a911719422eac97ea/qUINT_motionvectors.fx" "$robloxPath\reshade-shaders\Shaders\qUINT_motionvectors.fx" /END

  !insertmacro MoveFolder "$INSTDIR\reshade-shaders-master\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  !insertmacro MoveFolder "$INSTDIR\reshade-shaders-master\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\reshade-shaders-master"

  !insertmacro MoveFolder "$INSTDIR\reshade-shaders-legacy\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  !insertmacro MoveFolder "$INSTDIR\reshade-shaders-legacy\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\reshade-shaders-legacy"

  !insertmacro MoveFolder "$INSTDIR\prod80-ReShade-Repository-master\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  !insertmacro MoveFolder "$INSTDIR\prod80-ReShade-Repository-master\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\prod80-ReShade-Repository-master"

  !insertmacro MoveFolder "$INSTDIR\fubax-shaders-master\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  !insertmacro MoveFolder "$INSTDIR\fubax-shaders-master\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\fubax-shaders-master"

  !insertmacro MoveFolder "$INSTDIR\FXShaders-master\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  !insertmacro MoveFolder "$INSTDIR\FXShaders-master\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\FXShaders-master"

  !insertmacro MoveFolder "$INSTDIR\qUINT-master\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  RMDir /r "$INSTDIR\qUINT-master"

  !insertmacro MoveFolder "$INSTDIR\ZealShaders-master\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  RMDir /r "$INSTDIR\ZealShaders-master"

  !insertmacro MoveFolder "$INSTDIR\ReshadeMotionBlur-main" "$robloxPath\reshade-shaders\Shaders" "*"
  RMDir /r "$INSTDIR\ReshadeMotionBlur-main"

  !insertmacro MoveFolder "$INSTDIR\ReShade-Optical-Flow-main\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  RMDir /r "$INSTDIR\ReShade-Optical-Flow-main"

  !insertmacro MoveFolder "$INSTDIR\69c775f844124ec2c71c37541801c053-46a4ea9894e7aed287e3c86a911719422eac97ea" "$robloxPath\reshade-shaders\Shaders" "*"
  RMDir /r "$INSTDIR\69c775f844124ec2c71c37541801c053-46a4ea9894e7aed287e3c86a911719422eac97ea"

  !insertmacro MoveFolder "$INSTDIR\Warp-FX-master\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  RMDir /r "$INSTDIR\Warp-FX-master"
 
  !insertmacro MoveFolder "$INSTDIR\dh-reshade-shaders-master\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  !insertmacro MoveFolder "$INSTDIR\dh-reshade-shaders-master\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\dh-reshade-shaders-master"
  Delete "$robloxPath\reshade-shaders\Shaders\dh_Lain.fx"
  Delete "$robloxPath\reshade-shaders\Shaders\dh_rtgi.fx"

  !insertmacro MoveFolder "$INSTDIR\Glamarye_Fast_Effects_for_ReShade-main\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  RMDir /r "$INSTDIR\Glamarye_Fast_Effects_for_ReShade-main"

  !insertmacro MoveFolder "$INSTDIR\NiceGuy-Shaders-main" "$robloxPath\reshade-shaders" "*"
  RMDir /r "$INSTDIR\NiceGuy-Shaders-main"

  NSCurl::http GET "https://github.com/K8AX/RobloxTX/raw/main/config.zip" "config.zip" /END
  nsisunz::Unzip "config.zip" "$robloxPath"
  Delete "config.zip"

  SetOutPath $robloxPath
SectionEnd

SectionGroup /e "Presets"
  Section "K8AX's ReShade-Presets"
    SectionIn 1
    NSCurl::http GET "https://github.com/K8AX/RobloxTX/raw/main/reshade-presets.zip" "reshade-presets.zip" /END
    nsisunz::Unzip "reshade-presets.zip" "$robloxPath\reshade-presets"
    Delete "reshade-presets.zip"
  SectionEnd
  Section "K8AX's ReShade-Textures"
    SectionIn 1
    NSCurl::http GET "https://github.com/K8AX/RobloxTX/raw/main/RobloxTXTextures-master.zip" "RobloxTXTextures-master.zip" /END
    nsisunz::Unzip "RobloxTXTextures-master.zip" "$robloxPath\reshade-shaders\Textures"
    Delete "RobloxTXTextures-master.zip"
  SectionEnd
SectionGroupEnd

SectionGroup /e "rbxfpsunlocker"
  Section "rbxfpsunlocker"
   SectionIn 1
   ExecWait "TaskKill /IM rbxfpsunlocker.exe /F"
   NSCurl::http GET "https://github.com/axstin/rbxfpsunlocker/releases/latest/download/rbxfpsunlocker-x64.zip" "rbxfpsunlocker-x64.zip" /END
   nsisunz::Unzip "rbxfpsunlocker-x64.zip" "$INSTDIR"
   Delete "rbxfpsunlocker-x64.zip"
   CreateShortCut "$DESKTOP\Roblox FPS Unlocker.lnk" "$INSTDIR\rbxfpsunlocker.exe"
   CreateShortCut "$SMPROGRAMS\Roblox FPS Unlocker.lnk" "$INSTDIR\rbxfpsunlocker.exe"
   RMDir /r "$robloxPath\r"
   Exec "$INSTDIR\rbxfpsunlocker.exe"
  SectionEnd
SectionGroupEnd

Section "uninstall"
  ${Locate} "$LOCALAPPDATA\Roblox\Versions" "/L=F /M=RobloxPlayerBeta.exe" "un.SetRobloxPath"

  ExecWait "TaskKill /IM RobloxPlayerBeta.exe /F"
  ExecWait "TaskKill /IM rbxfpsunlocker.exe /F"
  Delete "$INSTDIR\rbxfpsunlocker.exe"
  Delete "$INSTDIR\settings"
  Delete "$robloxPath\settings"
  Delete "$INSTDIR\uninstall.exe"
  RMDir /r $INSTDIR

  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets"

  Delete "$robloxPath\ReShade.ini"
  RMDir /r "$robloxPath\reshade-presets"
  RMDir /r "$robloxPath\reshade-shaders"
  RMDir /r "$robloxPath\ClientSettings"
  Delete "$robloxPath\dxgi.dll"
  Delete "$robloxPath\ReShade.log"
  Delete "$robloxPath\NunitoSans-Regular.ttf"
  Delete "$robloxPath\Hack-Regular.ttf"
  Delete "$DESKTOP\Roblox FPS Unlocker.lnk"
  Delete "$SMPROGRAMS\Roblox FPS Unlocker.lnk"
  Delete "$robloxPath\license.txt"
SectionEnd

####################################################################
# Functions

Function .onInit
  ${Locate} "$PROGRAMFILES\Roblox\Versions" "/L=F /M=RobloxPlayerBeta.exe" "Troubleshoot"

  StrCpy $robloxPath ""
  ${Locate} "$LOCALAPPDATA\Roblox\Versions" "/L=F /M=RobloxPlayerBeta.exe" "SetRobloxPath"  
  
  ${If} $robloxPath == ""
    MessageBox MB_YESNO|MB_ICONEXCLAMATION "Roblox installation not found. Would you like to reinstall Roblox and try again?" IDYES yes
    Abort
    yes:
    NScurl::http GET "https://www.roblox.com/download/client" "$INSTDIR\RobloxPlayerLauncher.exe" /POPUP /END
    ExecWait "$INSTDIR\RobloxPlayerLauncher.exe"
    MessageBox MB_ICONQUESTION "Roblox has been reinstalled, if that does not seem to be the case, please check your User Account Control settings."
    RMDir /r $INSTDIR
    Abort
  ${EndIf}
FunctionEnd

Function "Troubleshoot"
    MessageBox MB_YESNO|MB_ICONEXCLAMATION "It seems like Roblox is installed system-wide in the Program Files directory. Would you like to attempt to install again under your own user? Make sure you follow all on-screen instructions, and ensure that Roblox is closed before proceeding." IDYES yes
    Abort
    yes:
    ExecWait "TaskKill /IM RobloxPlayerBeta.exe /F"
    MessageBox MB_ICONQUESTION `A User Account Control pop-up will appear, make sure to click "YES".`
    ${Locate} "$PROGRAMFILES\Roblox\Versions" "/L=F /M=RobloxPlayerBeta.exe" "SetRobloxPath"
    ExecWait '"$robloxPath\RobloxPlayerLauncher.exe"" -uninstall'
    MessageBox MB_ICONQUESTION "Roblox was removed from C:\Program Files (x86). Now will, attempt to reinstall Roblox."
    NScurl::http GET "https://www.roblox.com/download/client" "$INSTDIR\RobloxPlayerLauncher.exe" /POPUP /END
    ExecWait "$INSTDIR\RobloxPlayerLauncher.exe"
    MessageBox MB_ICONQUESTION "Roblox has been reinstalled, if that does not seem to be the case, please check your User Account Control settings."
    RMDir /r $INSTDIR
  Abort
FunctionEnd

Function "SetRobloxPath"
  SetOutPath $R8
  StrCpy $robloxPath $R8
  StrCpy $0 StopLocate
  Push $0
FunctionEnd
Function "un.SetRobloxPath"
  SetOutPath $R8
  StrCpy $robloxPath $R8
  StrCpy $0 StopLocate
  Push $0
FunctionEnd

Function "StartTaskbarProgress"
  w7tbp::Start
FunctionEnd

Function "OpenLink"
  ExecShell "open" "https://www.youtube.com/channel/UCOZnRzWstxDLyW30TjWEevQ?sub_confirmation=1"
FunctionEnd
