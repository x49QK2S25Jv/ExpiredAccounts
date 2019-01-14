#Task one Variables
$TodaysDate = (Get-Date -Format dd/MM/yyyy)
Clear-Host

$menu=@"
1 Show accounts which have expired 
2 Show accounts which are expiring soon
3 Show accounts which have expired and expiring soon
4 Show accounts which have expired and expiring soon in AD OU
Select a task by number or Q to quit
"@

do {
$r = Read-Host $menu

Switch ($r) {
#Task two, ask for expired only
"1" {
    if ($ExpiredAccounts -eq ""){
Write-Host "No accounts have expired" -ForegroundColor Green
    }
else {
Write-Host "The below accounts have expired" -ForegroundColor Magenta
$ExpiredAccounts = Search-ADAccount -AccountExpired | Format-Table Name,LastLogonDate,AccountExpirationDate -AutoSize | Out-String
Write-Host "$ExpiredAccounts"
    }  
        }
"2" {
$DaysBack = Read-host "How many days forward to check"
$DaysBackDate = (Get-Date).AddDays("$DaysBack")
$ExpiringAccounts = Search-ADAccount -AccountExpiring -TimeSpan $DaysBack | Format-Table Name,LastLogonDate,AccountExpirationDate -AutoSize | Out-String
if ($ExpiringAccounts -eq "") {
Write-Host "No accounts are going to expire within $ExpiringAccountDaysRequested day/s" -ForegroundColor Green
    }
else {
Write-Host "The below accounts are expiring within $DaysBack days" -ForegroundColor Magenta
Write-Host "$ExpiringAccounts"
    }
        }
"3" {
    if ($ExpiredAccounts -eq "") {
Write-Host "No accounts have expired" -ForegroundColor Green
    }
else {
Write-Host "The below accounts have expired" -ForegroundColor Magenta
Write-Host "$ExpiredAccounts"
$DaysBack = Read-host "How many days forward to check"
$DaysBackDate = (Get-Date).AddDays("$DaysBack")
$ExpiringAccounts = Search-ADAccount -AccountExpiring -TimeSpan $DaysBack | Format-Table Name,LastLogonDate,AccountExpirationDate -AutoSize | Out-String
if ($ExpiringAccounts -eq ""){
Write-Host "No accounts are going to expire within $ExpiringAccountDaysRequested day/s" -ForegroundColor Green
    }
else {
Write-Host "The below accounts are expiring within $DaysBack days" -ForegroundColor Magenta
Write-Host "$ExpiringAccounts"
    }
        }
            } 
"4" {
Write-Host "Please enter OU search base e.g. "
Write-host "OU=Staff,OU=Users,OU=BladeIT,DC=ad,DC=bladeit,DC=co,DC=nz" -ForegroundColor Green
$ADOU = Read-Host
if ($ExpiredAccounts -eq "") {
Write-Host "No accounts have expired" -ForegroundColor Green
    }
else {
Write-Host "The below accounts have expired" -ForegroundColor Magenta
$ExpiredAccounts = Search-ADAccount -AccountExpired | Format-Table Name,LastLogonDate,AccountExpirationDate -AutoSize | Out-String
Write-Host "$ExpiredAccounts"
$DaysBack = Read-host "How many days forward to check"
$DaysBackDate = (Get-Date).AddDays("$DaysBack")
$ExpiringAccounts = Search-ADAccount -AccountExpiring -TimeSpan $DaysBack | Format-Table Name,LastLogonDate,AccountExpirationDate -AutoSize | Out-String
if ($ExpiringAccounts -eq ""){
Write-Host "No accounts are going to expire within $ExpiringAccountDaysRequested day/s" -ForegroundColor Green
    }
else {
Write-Host "The below accounts are expiring within $DaysBack days" -ForegroundColor Magenta
Write-Host "$ExpiringAccounts"
    }
        }
            } 
default {
    Write-Host "I don't understand what you want to do." -ForegroundColor Yellow
    }
"Q" {
    Write-Host "Closing" -ForegroundColor Green
    Sleep 1
    Exit
    }
        }}#end switch
until ($response -eq "q")