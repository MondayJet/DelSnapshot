try
{
    "Logging in to Azure..."
    Connect-AzAccount -Identity
}
catch {
    Write-Error -Message $_.Exception
    throw $_.Exception
}


if($err) {

throw $err

}


# Get snapshot with assigned tag
$tagResList = Get-AzResource -TagName "<Name>" -TagValue "<TagValue>" -ResourceType Microsoft.Compute/snapshots

foreach($tagRes in $tagResList) {

# Create variable
$SnapshotList = Get-AzSnapshot -SnapshotName $tagRes.Name | Where-Object {$_.TimeCreated.Date -lt ([datetime]::UtcNow.AddDays(-7))}

# Delete Snapshots older than x days
$SnapshotList | Remove-AzSnapshot -Force

}