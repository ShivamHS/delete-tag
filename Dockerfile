FROM mcr.microsoft.com/dotnet/sdk:5.0-alpine3.13

COPY delete-tag.ps1 /

ENTRYPOINT [ "pwsh", "-File", "/delete-tag.ps1"]