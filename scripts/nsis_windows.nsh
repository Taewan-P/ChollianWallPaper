; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Chollian Wallpaper"
# scripts/bundle_macos.py and src/about.h must be modified too.
!define PRODUCT_VERSION "2021.10"
!define PRODUCT_PUBLISHER "Jino Park"
!define PRODUCT_WEB_SITE "https://github.com/pjessesco/ChollianWallPaper"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\ChollianWallpaper.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!define MUI_LICENSEPAGE_RADIOBUTTONS
; FIXME : Currently hard-coded for github workflow environment
!insertmacro MUI_PAGE_LICENSE "D:\a\ChollianWallPaper\ChollianWallPaper\LICENSE"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\ChollianWallpaper.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "ChollianInstaller.exe"
InstallDir "$PROGRAMFILES\Chollian Wallpaper"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  
  File /r "D:\a\ChollianWallPaper\ChollianWallPaper\build_${CONFIG}\bundle_${CONFIG}\"
  
  CreateDirectory "$SMPROGRAMS\Chollian Wallpaper"
  CreateShortCut "$SMPROGRAMS\Chollian Wallpaper\Chollian Wallpaper.lnk" "$INSTDIR\ChollianWallpaper.exe"
  CreateShortCut "$DESKTOP\Chollian Wallpaper.lnk" "$INSTDIR\ChollianWallpaper.exe"
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\Chollian Wallpaper\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\Chollian Wallpaper\Uninstall.lnk" "$INSTDIR\UninstallChollian.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\UninstallChollian.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\ChollianWallpaper.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\UninstallChollian.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\ChollianWallpaper.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "Chollian Wallpaper is completely deleted."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Delete Chollian Wallpaper?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  RMDIR /r "$INSTDIR\"

  Delete "$SMPROGRAMS\Chollian Wallpaper\Uninstall.lnk"
  Delete "$SMPROGRAMS\Chollian Wallpaper\Website.lnk"
  Delete "$DESKTOP\Chollian Wallpaper.lnk"
  Delete "$SMPROGRAMS\Chollian Wallpaper\Chollian Wallpaper.lnk"

  RMDir "$SMPROGRAMS\Chollian Wallpaper"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd
