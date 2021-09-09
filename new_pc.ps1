$source = "https://cdn.streamelements.com/obs/dist/obs-streamelements-installer-wrapper/windows/latest/obs-streamelements-setup-latest.exe";
$destination = "c:\Temp\streamelements.exe"

#Check if software is installed. If installed end

if ((Test-Path "C:\Program Files \obs-studio\obs-streamelements-uninstaller.exe") -Or (Test-Path "C:\Program Files (x86)\obs-studio\obs-streamelements-uninstaller.exe")){
write-host "You are all set! Have a good stream!!!" 
Exit
}

#Check if the installer is in the folder. If installer exist, replace it
 
If ((Test-Path $destination) -eq $false) {
    New-Item -ItemType File -Path $destination -Force
} 

#install software

Invoke-WebRequest $source -OutFile $destination

$path = "C:\Temp\streamelements.exe"
Start-Process -FilePath $path -ArgumentList "/S","/v","/qn" -Wait

#Delete installer
write-host "Install completed without errors"
Remove-Item -recurse "C:\Temp\streamelements.exe"
