$report=@()
$servers=@()
$servers = Get-QADComputer -SizeLimit 0 -OSName 'Windows Server*' | where {($_.Name -like "AL*")} | select Name,OSName,OSServicePack
	foreach ($server in $servers)
		{
		$ip=""
		$ip = [System.Net.Dns]::GetHostAddresses($server.Name) | select ipaddresstostring
		$rep = "" | select "Server Name", "OS Name", "Service Pack", "IP Address"
		$rep."Server Name" = $server.Name
		$rep."OS Name" = $server.OSName
		$rep."Service Pack" = $server.OSServicePack
		$rep."IP Address" = $ip.IPAddressToString
		
		$report += $rep
		}





$rep = "" | select "Server Name", "Drive Letter", "Disk Space", "Used Space", "Free Space", "DeviceID", "Type"
								$Rep."Server Name" = $server
								$Rep."Drive Letter" = $disk."driveletter"
								$Rep."Disk Space" = $disk | %{$_.Capacity}
								$Rep."Free Space" = $disk | %{$_.Freespace}
								$Rep."Used Space" = $Rep."Disk Space" - $Rep."Free Space"
									If ($disk.deviceid -notmatch "806e6f6e6963"){$rep.Type = "SAN"}
									Else
										{
										$Rep.Type = "Local"
										}
								$Rep."DeviceID" = $disk | %{$_.deviceID}
								Write-Host $rep
								$MyObj += $Rep
								$rep = $null