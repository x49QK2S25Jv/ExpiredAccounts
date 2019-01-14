#Task one Variables
$TodaysDate = (Get-Date -Format dd/MM/yyyy)
Clear-Host
$ExpiredAccounts = Search-ADAccount -AccountExpired | Format-Table Name,LastLogonDate,AccountExpirationDate -AutoSize | Out-String


#Write-Host (Script is not required to be run as "administrator" or domain admin) -ForegroundColor Green
$menu=@"
1 Show accounts which have expired 
2 Show accounts which are expiring soon
3 Show accounts which have expired and expiring soon
Q Quit
Select a task by number or Q to quit
"@

$r = Read-Host $menu

Switch ($r) {
#Task two, ask for expired only
"1" {
    if ($ExpiredAccounts -eq ""){
Write-Host "No accounts have expired" -ForegroundColor Green
}
else
{
Write-Host "The below accounts have expired" -ForegroundColor Magenta
Write-Host "$ExpiredAccounts"
    }
        }
 
"2" {
$DaysBack = Read-host "How many days forward to check"
$DaysBackDate = (Get-Date).AddDays("$DaysBack")
$ExpiringAccounts = Search-ADAccount -AccountExpiring | Format-Table Name,LastLogonDate,AccountExpirationDate -AutoSize | Out-String
if ($ExpiringAccounts -eq ""){
$ExpiringAccountDaysRequested = Read-Host -Prompt "Show accounts which will expire in the next X day/s"
else{
Write-Host "No accounts are going to expire within $ExpiringAccountDaysRequested day/s" -ForegroundColor Green
else
}}
Write-Host "The below accounts are expiring within $DaysBack days" -ForegroundColor Magenta
Write-Host "$ExpiringAccounts"
    }
"3"{
if ($ExpiredAccounts -eq ""){
$ExpiringAccountDaysRequested = Read-Host -Prompt "Show accounts which will expire in the next"
Write-Host "No accounts have expired" -ForegroundColor Green
}
else
{
Write-Host "The below accounts have expired" -ForegroundColor Magenta
Write-Host "$ExpiredAccounts"
}
if ($ExpiringAccounts -eq ""){
Write-Host "No accounts are going to expire within the next $ExpiringAccountDaysRequested day/s"}
else
{
Write-Host "The below accounts are expiring soon" -ForegroundColor Magenta
Write-Host "$ExpiringAccounts"
}
}
 
"Q" {
    Write-Host "Quitting" -ForegroundColor Green
}
 
default {
    Write-Host "I don't understand what you want to do." -ForegroundColor Yellow
 }
    }#end switch
