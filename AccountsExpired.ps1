#Task one Variables


#Task one.a ask for variables
$ExpiringAccountDaysRequested = Read-Host -Prompt "Please tell me how many days until the account expires you would like to see"


#Task one.b menu


#Task two, ask for expired only
$ExpiredAccounts = Search-ADAccount -AccountExpired | Format-Table Name,LastLogonDate,AccountExpirationDate -AutoSize | Out-String


#Task three show expired only
$ExpiringAccounts = Search-ADAccount -AccountExpiring | Format-Table Name -AutoSize | Out-String


#Task four show expired and expiring
Write-Host "The below accounts have expired" -ForegroundColor Magenta
Write-Host "$ExpiredAccounts.Name $ExpiredAccounts.LastLogonDate"
Write-Host "The below accounts are expiring soon" -ForegroundColor Magenta
Write-Host "$ExpiringAccounts"