
$apps = @(
    [pscustomobject]@{
           app = "StreamElements"; 
           source = 'https://cdn.streamelements.com/obs/dist/obs-streamelements-installer-wrapper/windows/latest/obs-streamelements-setup-latest.exe'; 
           destination = "c:\Temp\streamelements.exe"; 
           location1 = 'C:\Program Files \obs-studio\obs-streamelements-uninstaller.exe' ; 
           location2 = 'C:\Program Files (x86)\obs-studio\obs-streamelements-uninstaller.exe';
       } 
    [pscustomobject]@{
           app = "Chrome";
           source = 'http://dl.google.com/chrome/install/375.126/chrome_installer.exe';
           destination = "c:\Temp\chrome.exe";
           location1 = 'C:\Program Files\Google\Chrome\Application\chrome.exe' ; 
           location2 = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'; 
       }
   )
   $apps | ForEach-Object {

        #Check if software is installed. If installed end

        if ((Test-Path $_.location1 ) -Or (Test-Path $_.location2)){
        write-host $_.app ' is already installed!!!'
        }
        else {
            #Check if the installer is in the folder. If installer exist, replace it
        
            If ((Test-Path $_.destination) -eq $false) {
                New-Item -ItemType File -Path $_.destination -Force
            } 

            #install software

            Invoke-WebRequest $_.source -OutFile $_.destination

            Start-Process -FilePath $_.destination -Wait

            #Delete installer
            write-host $_.app ' Install completed without errors'
            Remove-Item -recurse $_.destination
        }
        
   }