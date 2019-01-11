#Task one Variables


#Task one.a ask for variables
$ExpiringAccountDaysRequested = Read-Host -Prompt "Please tell me how many days until the account expires you would like to see"


#Task one.b menu

cls
sleep 1
#Task two, ask for expired only
$ExpiredAccounts = Search-ADAccount -AccountExpired | Format-Table Name,LastLogonDate,AccountExpirationDate -AutoSize | Out-String


#Task three show expired only
$ExpiringAccounts = Search-ADAccount -AccountExpiring | Format-Table Name -AutoSize | Out-String


#Task four show expired and expiring
if ($ExpiredAccounts -eq $null){
Write-Host "No accounts have expired" -ForegroundColor Green
}
else
{
Write-Host "The below accounts have expired" -ForegroundColor Magenta
Write-Host "$ExpiredAccounts"
}


if ($ExpiredAccounts -eq $null)
{
Write-Host "No accounts are going to expire within $ExpiringAccountDaysRequested" day/s -ForegroundColor Green}
else
{
Write-Host "The below accounts are expiring soon" -ForegroundColor Magenta
Write-Host "$ExpiringAccounts"
}