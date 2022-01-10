
 --CONTENTS--
 1 - Installation Instructions
 2 - Flash under Operating System
 3 - Flash Program Options


*****************************************************************************
*                       1. Installation Instructions                        *
*                                                                           *
*     Please print out these instructions or write them down before         *
*     starting this flash update utility.                                   *
*                                                                           *
*     This utility provides the ability to update the TPM firmware (FW)     *
*     from 64 bit Windows operating system.                                 *
*                                                                           *
*                                                                           *
*****************************************************************************


*****************************************************************************
*                     2. Flash Under Operating System                       *
*                                                                           *
*     1.  IMPORTANT: Please make sure all TPM based application are closed  *
*         before the TPM FW update                                          *
*									    *
*     2.  IMPORTANT: Please make sure all your data which is encrypted by   *
*         the TPM is decrypted before the TPM FW update. For example,       *
*         the Bitlocker function should be turned off before the TPM FW     *
*         update.                                                           *
*                                                                           *
*     3.  Click on the Start button and type cmd.exe,  Right-click on       *
*         the cmd.exe application and select run as administrator to        *
*         open the Command Prompt with Administrator privilege.             *
*                                                                           *
*     4.  In the "Command Prompt" window, change to the directory where the *
*         above files were extracted.  		                            *
*                                                                           *
*     5.  Enter the command "flash.cmd [Arg1] [Arg2] [Arg3]" and press the  *
*         Enter key to start the flashing process.                          *
*                                                                           *
*     6.  If Bitlocker is on, You may see a confirmation prompt "Do you want*
*         to continue to update TPM FW?". Click "Y" to continue.            * 
*         If silent install, the promption will be skipped.                 *
*                                                                           *
*     7.  You will see the prompt "Please enter BIOS setup Administrator    *
*         Password",if you don't provide BIOS setup Administrator           *
*         Password as a parameter when execute flash.cmd. Input BIOS        *
*         setup Administrator Password and press Enter.                     * 
*                                                                           *
*     8.  If Flash.cmd is successfully executed, then system will be        *
*         shutdown and reboot				                    *
*                                                                           *
*     9.  After the system reboots, there will be several Beep, please don't*
*         remove power. then TPM FW will flash to TPM chip. After several   *
*         reboots, system will boot up again.                               *                                                                     
*                                                                           *
*    10.  The TPM FW be successfully updated                                *
*                                                                           *
*****************************************************************************


*****************************************************************************
*                          3. Flash Program Options                         *
*                                                                           *
*     To deploy this application, please open the Windows Command Prompt    *
*     with Administrator privilege, and change to the directory where the   *
*         above files were extracted. After that, run                       *
*     "Flash.cmd /1 12345678 /s" to start the update process.               *
*				                                            *
*     Command options:                                                      *
*                                                                           *
*     Flash.cmd [Arg1] [Arg2] [Arg3] 				            *
*                                                                           *
*     [Arg1]= /1 or /2  - /1: update TPM FW to TPM spec 1.2                 *
*                       - /2: update TPM FW to TPM spec 2.0         	    *
*     [Arg2]= 1234567   - input BIOS administrator password                 *
*									    *
*     [Arg4]= /s	- silent install				    *
*     The following example shows how to update TPM FW by command:          *
*       flash.cmd /1 2345678 /s                                             *
*       flash.cmd /2 3456789 /s                                             *
*****************************************************************************
