$resourceGroupName = "learn-2c540f33-35fc-43bc-b186-0f40d3353bee"
$resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like $resourceGroupName
$location = $resourceGroup.Location
$uniqueID = Get-Random -Minimum 100000 -Maximum 1000000
$storageAccountName = $("storageaccount$($uniqueID)")
$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName -AccountName $storageAccountName  $location -SkuName Standard_GRS

$resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like $resourceGroupName
$location = $resourceGroup.Location
# Azure function name
$azureFunctionName = $("azfunc$($uniqueID)")
# Get storage account name
$storageAccountName = (Get-AzStorageAccount -ResourceGroup $resourceGroupName).StorageAccountName
$storageAccountName

$functionApp = New-AzFunctionApp -Name $azureFunctionName `
    -ResourceGroupName $resourceGroupName -StorageAccount $storageAccountName `
    -FunctionsVersion 3 -RuntimeVersion 3 -Runtime dotnet -Location $location