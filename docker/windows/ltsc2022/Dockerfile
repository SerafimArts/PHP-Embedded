FROM mcr.microsoft.com/powershell:nanoserver-ltsc2022

# configure powershell
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

# install git; add to path
RUN Invoke-WebRequest 'https://github.com/git-for-windows/git/releases/download/v2.40.1.windows.1/MinGit-2.40.1-64-bit.zip' -OutFile 'C:\\MinGit.zip' -SkipCertificateCheck

RUN Expand-Archive c:\\MinGit.zip -DestinationPath C:\\git
RUN New-Item -Path 'HKCU:' -Name 'Environment' | Out-Null
RUN New-ItemProperty -Path 'HKCU:\\Environment' -Name 'Path' -Value 'C:\\git\\cmd;C:\\git\\bin;C:\\git\\usr\\bin' | Out-Null
RUN git config --global --add safe.directory '*'

CMD "pwsh c:\phpe\docker\windows\build.ps1"
