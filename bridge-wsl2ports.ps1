#### ------------ Set WSL 2 Machine IP ------------ ####

$wsl_ip = (ubuntu.exe -c "ifconfig eth0 | grep 'inet '").trim().split()| where {$_}
$regex = [regex] "\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"

$ip_array = $regex.Matches($wsl_ip) | %{ $_.value }

$wsl_ip = $ip_array[0]

Write-Host "WSL Machine IP: ""$wsl_ip"""

#### ------------ Delete PortProxy rules ------------ ####

netsh int portproxy reset all

#### ------------ Rule: SSH - Port 2222 ------------ ####

netsh interface portproxy add v4tov4 listenport=2222 listenaddress=0.0.0.0 connectport=2222 connectaddress=$wsl_ip