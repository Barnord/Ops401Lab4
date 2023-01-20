#!/usr/bin/env powershell

# Enable password complexity
# Courtesy of this dude: https://social.technet.microsoft.com/Forums/office/en-US/50c827f8-0b8f-4b07-a90f-582948187ccb/disabling-password-complexity-via-powershell?forum=winserverpowershell
# I copied, pasted, and switched the 0 and the 1, because binary.
secedit /export /cfg c:\secpol.cfg
(gc C:\secpol.cfg).replace("PasswordComplexity = 0", "PasswordComplexity = 1") | Out-File C:\secpol.cfg
secedit /configure /db c:\windows\security\local.sdb /cfg c:\secpol.cfg /areas SECURITYPOLICY
rm -force c:\secpol.cfg -confirm:$false

# SMB Server Config script from Zac, proving it's disabled:
Get-SmbServerConfiguration | Format-List EnableSMB1Protocol