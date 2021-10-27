$dir = "C:\Program Files (x86)\Ultima Online Outlands\ClassicUO\Data\Client\JournalLogs"
$latest = Get-ChildItem -Path $dir | Sort-Object LastAccessTime -Descending | Select-Object -First 1

$file = $latest.name

#Remember this is hardcoded for testing!
#$file = "2021_10_27_07_53_08_journal.txt"

$outfile = "C:\users\oreos\desktop\test.txt"

Set-Content $outfile '*** GUILD VENDORS'

$new_vendor = 0
$line_count = 0
$item_count = 1
$item_string = ''
$last_item_string = ''
$last_item_count = 1
foreach($line in Get-Content $dir\$file) {
	$line_count = $line_count + 1
	if ($line -like "*New Vendor*" -and $line -notlike "*New target*" )
	{
		#Found new vendor - grab next line
		$new_vendor = 1
		$line_count = 0
	}
	if ($new_vendor -eq 1 -and $line_count -eq 1 -and $line -notlike "*That is not accessible*"  -and $line -notlike "*used to increase*"  -and $line -notlike "*WorldMap*" -and $line -notlike "*completed the achievement*" -and $line -like "*System*" -and $line -notlike "*.xml*" -and $line -notlike "*New target*" )
	{
		#This is our vendor name
		
		
		#Output last build item
		if($item_string -ne $last_item_string)
		{
			#new item - output
			if($last_item_count -gt 1)
			{
				#Previous item had multiples
				$dup_out_string = "        >> [" +  $last_item_count + "] AVAILABLE!"						
				Add-Content $outfile $dup_out_string
			}
			Add-Content $outfile $item_string
			$last_item_count = 1
		}
		else
		{
			#repeat item
			$last_item_count = $last_item_count + 1			
			#Add-Content $outfile $last_item_count
		}	
		
		
		#build vendor name
		$line = $line -replace '\[.*\].*System: ', '**Vendor Name: '
		$line = $line + "**"
		Add-Content $outfile $line
		$new_vendor = 0
		$item_string = ''
	}
	if ($new_vendor -ne 1 -and $line_count -gt 1 -and $line -notlike "*That is not accessible*"  -and $line -notlike "*used to increase*"  -and $line -notlike "*Ignore List cleared*"  -and $line -notlike "*completed the achievement*" -and $line -notlike "*Welcome Syal*"  -and $line -notlike "*WorldMap*"   -and $line -notlike "*.xml*" -and $line -notlike "*Not for sale*" -and $line -like "*System*" -and $line -notlike "*New target*" )
	{
		#First  line of new item; generally the price, grab and append next lines
		
		#Output last build item
		if($item_string -ne $last_item_string)
		{
			#new item - output
			if($last_item_count -gt 1)
			{
				#Previous item had multiples
				$dup_out_string = "        >> [" +  $last_item_count + "] AVAILABLE!"						
				Add-Content $outfile $dup_out_string
			}
			Add-Content $outfile $item_string
			$last_item_count = 1
		}
		else
		{
			#repeat item
			$last_item_count = $last_item_count + 1			
			#Add-Content $outfile $last_item_count
		}
		
		
		#build new string
		$line = $line -replace '\[.*\].*System: ', '   - '
		$last_item_string = $item_string
		$item_string = $line 
	}
	if ($new_vendor -ne 1 -and $line_count -gt 1 -and $line -notlike "*Description*"  -and $line -ne "bag"  -and $line -ne "backpack"  -and $line -ne "wooden box"  -and $line -ne "pouch"  -and $line -notlike "*That is not accessible*"  -and $line -notlike "*used to increase*"   -and $line -notlike "*Price*"  -and $line -notlike "*completed the achievement*"  -and $line -notlike "*New target*" -and $line -notlike  '*`[*`]*')
	{
		#Lines to be appended to item
		$line =  " " + $line 
		$item_string = $item_string + $line
	}
	if ($new_vendor -ne 1 -and $line_count -gt 1 -and $line -like "*Description*"  -and $line -notlike "*That is not accessible*"  -and $line -ne "backpack"  -and $line -ne "wooden box"  -and $line -ne "pouch"  -and $line -notlike "*used to increase*"  -and $line -notlike "*New target*" -and $line -notlike "*completed the achievement*"  -and $line -notlike  '*`[*`]*')
	{
		#Lines to be appended to item - Description line
		$line =  " " + $line + " -- "  
		$item_string = $item_string + $line
	}
}


#Output last build item
if($item_string -ne $last_item_string)
{
	#new item - output
	if($last_item_count -gt 1)
	{
		#Previous item had multiples
		$dup_out_string = "        >> [" +  $last_item_count + "] AVAILABLE!"				
		Add-Content $outfile $dup_out_string
	}
	Add-Content $outfile $item_string
	$last_item_count = 1
}
else
{
	#repeat item
	$last_item_count = $last_item_count + 1			
	Add-Content $outfile $item_string
 
	#Previous item had multiples
	$dup_out_string = "        >> [" +  $last_item_count + "] AVAILABLE!"					
	Add-Content $outfile $dup_out_string	
}
