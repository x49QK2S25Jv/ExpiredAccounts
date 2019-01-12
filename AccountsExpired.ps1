#Task one Variables
$ExpiringAccountDaysRequested = Read-Host -Prompt "Please tell me how many days until the account expires you would like to see"
$ExpiringAccountDaysRequestedDate = (Get-Date)


$ExpiredAccounts = Search-ADAccount -AccountExpired | Format-Table Name,LastLogonDate,AccountExpirationDate -AutoSize | Out-String
$ExpiringAccounts = Search-ADAccount -AccountExpiring | Format-Table Name,AccountExpirationDate -AutoSize | Out-String

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
}}
 
"2" {
if ($ExpiringAccounts -eq ""){
Write-Host "No accounts are going to expire within $ExpiringAccountDaysRequested" day/s -ForegroundColor Green}
else
{
Write-Host "The below accounts are expiring soon" -ForegroundColor Magenta
Write-Host "$ExpiringAccounts"
}

}
"3"{
if ($ExpiredAccounts -eq ""){
Write-Host "No accounts have expired" -ForegroundColor Green
}
else
{
Write-Host "The below accounts have expired" -ForegroundColor Magenta
Write-Host "$ExpiredAccounts"
}

if ($ExpiringAccounts -eq ""){
Write-Host "No accounts are going to expire within the next $ExpiringAccountDaysRequested" day/s -ForegroundColor Green}
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
} #end switch