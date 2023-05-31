<#
.SYNOPSIS
	Stop and restart all services from a list
.NOTES
	You have to edit the array ServicesList.
	This stop all service in the list (order by list)
	When all are stopped, restart the service ith a 30s timer.
.NOTES
  Version:        1.0
  Author:         Letalys
  Creation Date:  31/05/2023
  Purpose/Change: Initial script development
.LINK
    Author : Letalys (https://github.com/Letalys)
#>

Clear-Host

$ServicesList =@(
	"Service1",
	"Service2"
)

Write-Host -BackgroundColor Blue "Stopping Services"
Foreach($Service in $ServicesList){
    Write-Host -NoNewline "[$Service] : "
    Stop-Service $Service
    While((Get-Service -Name $Service).Status -ne "Stopped"){
        Start-Sleep -Seconds 1
    }
    Write-Host -ForegroundColor Green "OK"
}

Write-Host -BackgroundColor Blue "Starting Services"
Foreach($Service in $ServicesList){
    Write-Host -NoNewline "[$Service] : "
    Start-Service $Service
    While((Get-Service -Name $Service).Status -ne "Running"){
        Start-Sleep -Seconds 1
    }
    Write-Host -ForegroundColor Green "OK"
    Start-Sleep -Seconds 30
}

Write-Host -BackgroundColor Blue "Checking Services"
Foreach($Service in $ServicesList){
    Write-Host -NoNewline "[$Service] : "
    Write-Host (Get-Service $Service).Status
}
Write-Host -BackgroundColor Blue "End Process"
