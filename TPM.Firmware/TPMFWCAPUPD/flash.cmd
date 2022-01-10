@echo off 
:begin
if "%1" == "/1" SET TPMFW=Tpm12
if "%1" == "-1" SET TPMFW=Tpm12
if "%1" == "/2" SET TPMFW=Tpm20
if "%1" == "-2" SET TPMFW=Tpm20

rem %2 = bios password

SET Silentmode=
if "%3" == "/s" SET Silentmode=Y
if "%3" == "/S" SET Silentmode=Y
if "%3" == "-s" SET Silentmode=Y
if "%3" == "-S" SET Silentmode=Y

if "%1" == "" GOTO helpmessage

if %PROCESSOR_ARCHITECTURE% == x86  SET Flashtool="%~dp0\DevCapWIN.exe"
if %PROCESSOR_ARCHITECTURE% == AMD64 SET Flashtool="%~dp0\DevCapWINx64.exe"


rem wmic /namespace:\\root\cimv2\security\microsofttpm path win32_tpm get /value|FIND "IFX" >>log.txt
rem if "%ERRORLEVEL%"=="0" goto BitlockerCheck
rem goto showerror1 


:BitlockerCheck
echo ----------------------------------------------------------------------------
echo +                 Check Bitlocker                                          +
echo ----------------------------------------------------------------------------
echo ---------- Check Bitlocker          ---------- >log.txt
manage-bde.exe -status|FIND "Protection On" >>log.txt
IF "%ERRORLEVEL%"=="0"  goto BTLon
goto BTLoff
  
:BTLon
echo ----------------------------------------------------------------------------
echo +                 Warning Bitlocker is Turned ON                           +
echo ----------------------------------------------------------------------------

echo ---------- Warning Bitlocker is Turned ON ---------- >>log.txt
:OpenOffer
SET MENU=
ECHO   Do you want to continue to update TPM FW?
SET /P MENU="Y/N: "
IF %MENU%==Y GOTO Continue
IF %MENU%==y GOTO Continue
IF %MENU%==N GOTO end
IF %MENU%==n GOTO end
GOTO OpenOffer

:BTLoff
echo ----------------------------------------------------------------------------
echo +                 Bitlocker is Turned OFF                                  +
echo ----------------------------------------------------------------------------
echo ---------- Bitlocker is Turned OFF              ---------- >>log.txt

:Continue
echo ---------- Continue to update TPM FW            ---------- >>log.txt

rem check TPM spec
wmic /namespace:\\root\cimv2\security\microsofttpm path win32_tpm get /value|FIND "SpecVersion=2.0" >>log.txt
if "%ERRORLEVEL%"=="0" goto TPM20

:TPM12
if "%TPMFW%" == "Tpm12" goto warning1
if "%TPMFW%" == "Tpm20" goto warning2
goto helpmessage 

:TPM20
if "%TPMFW%" == "Tpm12" goto warning3
if "%TPMFW%" == "Tpm20" goto warning4
goto helpmessage 

:warning1
echo ----------------------------------------------------------------------------
echo +                 You are going to update TPM1.2 FW                        +
echo ----------------------------------------------------------------------------
SET TPMFW=Tpm1212
wmic /namespace:\\root\cimv2\security\microsofttpm path win32_tpm get /value|FIND "ManufacturerVersion=6.40" 
if "%ERRORLEVEL%"=="0" goto TPMVendor
wmic /namespace:\\root\cimv2\security\microsofttpm path win32_tpm get /value|FIND "ManufacturerVersion=6.41" 
if "%ERRORLEVEL%"=="0" goto TPMVendor
wmic /namespace:\\root\cimv2\security\microsofttpm path win32_tpm get /value|FIND "ManufacturerVersion=6.42" 
if "%ERRORLEVEL%"=="0" goto TPMVendor
wmic /namespace:\\root\cimv2\security\microsofttpm path win32_tpm get /value|FIND "ManufacturerVersion=6.43" 
if "%ERRORLEVEL%"=="0" goto latestone
goto notsupported

:warning2
echo ----------------------------------------------------------------------------
echo +                 You are going to switch TPM spec from 1.2 to 2.0         +
echo ----------------------------------------------------------------------------
SET TPMFW=Tpm1220
if "%Silentmode%" == "Y" goto TPMVendor
:OpenOffer1
ECHO   Do you want to continue to switch TPM FW?
SET /P MENU="Y/N: "
IF %MENU%==Y GOTO TPMVendor
IF %MENU%==y GOTO TPMVendor
IF %MENU%==N GOTO end
IF %MENU%==n GOTO end
GOTO OpenOffer1

:warning3
echo ----------------------------------------------------------------------------
echo +                 You are going to switch TPM spec from 2.0 to 1.2         +
echo ----------------------------------------------------------------------------
SET TPMFW=Tpm2012
if "%Silentmode%" == "Y" goto TPMVendor
:OpenOffer2
ECHO   Do you want to continue to switch TPM FW?
SET /P MENU="Y/N: "
IF %MENU%==Y GOTO TPMVendor
IF %MENU%==y GOTO TPMVendor
IF %MENU%==N GOTO end
IF %MENU%==n GOTO end
GOTO OpenOffer2

:warning4
echo ----------------------------------------------------------------------------
echo +                 You are going to update TPM 2.0 FW                       +
echo ----------------------------------------------------------------------------
SET TPMFW=Tpm2020

wmic /namespace:\\root\cimv2\security\microsofttpm path win32_tpm get /value|FIND "ManufacturerVersion=7.60" 
if "%ERRORLEVEL%"=="0" goto TPMVendor
wmic /namespace:\\root\cimv2\security\microsofttpm path win32_tpm get /value|FIND "ManufacturerVersion=7.61" 
if "%ERRORLEVEL%"=="0" goto TPMVendor
wmic /namespace:\\root\cimv2\security\microsofttpm path win32_tpm get /value|FIND "ManufacturerVersion=7.62" 
if "%ERRORLEVEL%"=="0" goto latestone
goto notsupported

:TPMVendor

SET FWFILE=
if "%TPMFW%" == "Tpm1212" SET FWFILE=IFX_Tpm1212DevCap.bin
if "%TPMFW%" == "Tpm2012" SET FWFILE=IFX_Tpm2012DevCap.bin
if "%TPMFW%" == "Tpm1220" SET FWFILE=IFX_Tpm1220DevCap.bin
if "%TPMFW%" == "Tpm2020" SET FWFILE=IFX_Tpm2020DevCap.bin

:biospassword
if "%2" == "" GOTO BIOSP
if "%2" == "/s" GOTO BIOSP
if "%2" == "/S" GOTO BIOSP
if "%2" == "-s" GOTO BIOSP
if "%2" == "-S" GOTO BIOSP

%Flashtool% /CAPFILE:%FWFILE% /PW:%2 /Shutdown

if not %errorlevel%==0 goto showerror4
echo ----------------------------------------------------------------------------
echo +                 Your system is going to shutdown/reboot                  +
echo ----------------------------------------------------------------------------
goto end

:BIOSP
SET BIOSPWD=
echo ---------- Please enter BIOS setup Administrator Password              ---------- >>log.txt
echo ---------- TPM FW can't be updated without BIOS Administrator Password ---------- >>log.txt
SET /P BIOSPWD="BIOS Administrator Password is: "
%Flashtool% /CAPFILE:%FWFILE% /pw:%BIOSPWD% /shutdown

if not %errorlevel%==0 goto showerror4
echo ----------------------------------------------------------------------------
echo +                 Your system is going to shutdown/reboot                  +
echo ----------------------------------------------------------------------------
goto end

:showerror1
echo ----------------------------------------------------------------------------
echo +                 NOT Infineon TPM device                                  +
echo ----------------------------------------------------------------------------
if "%Silentmode%" == "Y" goto end
pause
goto end

:latestone
echo ----------------------------------------------------------------------------
echo +                  TPM FW is the latest one                                +
echo ----------------------------------------------------------------------------
if "%Silentmode%" == "Y" goto end
pause
goto end

:notsupported
echo ----------------------------------------------------------------------------
echo +                  Current TPM FW is NOT in support list                   +
echo ----------------------------------------------------------------------------
if "%Silentmode%" == "Y" goto end
pause
goto end

:showerror4
echo ----------------------------------------------------------------------------
echo +                 Error: Please update BIOS to the latest one              +
echo ----------------------------------------------------------------------------
if "%Silentmode%" == "Y" goto end
pause
goto end

:helpmessage
echo ----------------------------------------------------------------------------
echo +                Commands                                                  +
echo +    [Arg1]= /1 or /2  - /1: update TPM FW to TPM spec 1.2                 +
echo +                      - /2: update TPM FW to TPM spec 2.0         	   +
echo +    [Arg2]= 1234567   - input BIOS administrator password                 +
echo +    [Arg3]= /s	       - silent install			                   +
echo ----------------------------------------------------------------------------

:end

