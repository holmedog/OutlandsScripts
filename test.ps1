$dir = "C:\Program Files (x86)\Ultima Online Outlands\ClassicUO\Data\Client\JournalLogs"
$latest = Get-ChildItem -Path $dir | Sort-Object LastAccessTime -Descending | Select-Object -First 1

$file = $latest.name

#Remember this is hardcoded for testing!
#$file = "2021_10_27_11_12_55_journal.txt"

$outfile = "C:\users\oreos\desktop\test.txt"

Set-Content $outfile '*** and VILE Guild Vendors!'

$new_vendor = 0
$line_count = 0
$write_check = 1
$item_count = 1
$last_item_count = 1
$master_list_count = 0
$item_string = ''
$last_item_string = 'a'
$master_list_string_output = 'Master List of Items ['
foreach($line in Get-Content $dir\$file) {
	$line_count = $line_count + 1
	if ($line -like "*START CATALOGUE*"  )
	{
		#Start Block
		$write_check = 0		
	}
	if ($line -like "*DONE CATALOGUE*"  )
	{
		#Start Block
		$write_check = 1		
	}
	if ($write_check -eq 0 -and $line -like "*New Vendor*" -and $line -notlike "*New target*" )
	{
		#Found new vendor - grab next line
		$new_vendor = 1
		$line_count = 0
	}
	if ($write_check -eq 0 -and $new_vendor -eq 1 -and $line_count -eq 1  -and $line -notlike "*When used, it will*"  -and $line -notlike "*That is not accessible*"  -and $line -notlike "*used to increase*"  -and $line -notlike "*WorldMap*" -and $line -notlike "*completed the achievement*" -and $line -like "*System*" -and $line -notlike "*.xml*" -and $line -notlike "*New target*" )
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
			
			#Add item to master list if it's not on the list	
			if($item_string -notlike '*carpet dye*' -and $item_string -notlike '*queued actions*'  -and $item_string -notlike '*martial manual*'  -and $item_string -notlike '*gorget*'  -and $item_string -notlike '*Queuing action*' -and $item_string -notlike '*exceptional*' -and $item_string -notlike '*viking sword*' -and $item_string -notlike '*two-handed axe*' -and $item_string -notlike '*select an item*' -and $item_string -notlike '*crossbow*' -and $item_string -notlike '*CATALOGUE*'  -and $item_string -notlike '*black staff*'   -and $item_string -notlike '*battleaxe*'  -and $item_string -notlike '*prestige has*'  -and $item_string -notlike '*melodious*'  -and $item_string -notlike '*spellbook*' -and $item_string -notlike '*container identification wand*'  -and $item_string -notlike '*dullhide*'  -and $item_string -notlike '*copperhide*'  -and $item_string  -notlike '*goldenwood*'  -and $item_string -notlike '*dullwood*'  -and $item_string -notlike '*verewood*'  -and $item_string -notlike '*valewood*' )
			{
				$master_list_string = $master_list_string + $item_string + ";"
				#echo $item_string
			}
			$master_list_count = $master_list_count + 1 
			$last_item_count = 1
		}
		else
		{
			#repeat item
			$last_item_count = 1	
		
			#Previous item had multiples
			$dup_out_string = "        >> [" +  $last_item_count + "] AVAILABLE!"					
			Add-Content $outfile $dup_out_string	
		}

		
		
		#build vendor name
		$line = $line -replace '\[.*\].*System: ', '**Vendor Name: '
		$line = $line + "**"
		Add-Content $outfile " "
		Add-Content $outfile $line
		$new_vendor = 0
		$item_string = ''
	}
	if ($write_check -eq 0 -and $new_vendor -ne 1 -and $line_count -gt 1  -and $line -notlike "*When used, it will*" -and $line -notlike "*That is not accessible*"  -and $line -notlike "*used to increase*"  -and $line -notlike "*Ignore List cleared*"  -and $line -notlike "*completed the achievement*" -and $line -notlike "*Welcome Syal*"  -and $line -notlike "*WorldMap*"   -and $line -notlike "*.xml*" -and $line -notlike "*Not for sale*" -and $line -like "*System*" -and $line -notlike "*New target*" )
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
			
			#Add item to master list if it's not on the list	queued actions 		
			if($item_string -notlike '*carpet dye*' -and $item_string -notlike '*queued actions*'  -and $item_string -notlike '*martial manual*'  -and $item_string -notlike '*gorget*'  -and $item_string -notlike '*Queuing action*' -and $item_string -notlike '*exceptional*' -and $item_string -notlike '*viking sword*' -and $item_string -notlike '*two-handed axe*' -and $item_string -notlike '*select an item*' -and $item_string -notlike '*crossbow*' -and $item_string -notlike '*CATALOGUE*'  -and $item_string -notlike '*black staff*'   -and $item_string -notlike '*battleaxe*'  -and $item_string -notlike '*prestige has*'  -and $item_string -notlike '*melodious*'  -and $item_string -notlike '*spellbook*' -and $item_string -notlike '*container identification wand*'  -and $item_string -notlike '*dullhide*'  -and $item_string -notlike '*copperhide*'  -and $item_string  -notlike '*goldenwood*'  -and $item_string -notlike '*dullwood*'  -and $item_string -notlike '*verewood*'  -and $item_string -notlike '*valewood*' )
			{
				$master_list_string = $master_list_string + $item_string + ";"
				#echo $item_string
			}
			$master_list_count = $master_list_count + 1 
		}
		else
		{
			#repeat item
			$last_item_count = $last_item_count + 1	
		}
		
		
		#build new string
		$line = $line -replace '\[.*\].*System: ', '   - '
		$last_item_string = $item_string
		$item_string = $line 
	}
	if ($write_check -eq 0 -and $new_vendor -ne 1 -and $line_count -gt 1 -and $line -notlike "*Description*"  -and $line -notlike "*When used, it will*"  -and $line -ne "bag"  -and $line -ne "backpack"  -and $line -ne "wooden box"  -and $line -ne "pouch"  -and $line -notlike "*That is not accessible*"  -and $line -notlike "*used to increase*"   -and $line -notlike "*Price*"  -and $line -notlike "*completed the achievement*"  -and $line -notlike "*New target*" -and $line -notlike  '*`[*`]*')
	{
		#Lines to be appended to item
		$line =  " " + $line 
		$item_string = $item_string + $line
		
	}
	if ($write_check -eq 0 -and $new_vendor -ne 1 -and $line_count -gt 1 -and $line -like "*Description*"  -and $line -notlike "*When used, it will*"  -and $line -notlike "*That is not accessible*"  -and $line -ne "backpack"  -and $line -ne "wooden box"  -and $line -ne "pouch"  -and $line -notlike "*used to increase*"  -and $line -notlike "*New target*" -and $line -notlike "*completed the achievement*"  -and $line -notlike  '*`[*`]*')
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

#format master list
$master_list_string = $master_list_string -replace 'Price: \d+ ', ''
$master_list_string = $master_list_string -replace '; ;', ';'
$master_list_string = $master_list_string -replace ' ; ', '; '
$master_list_string = $master_list_string -replace ' - ', ' '
$master_list_string = $master_list_string -replace 'When used, it will unlock this spell hue for a randomized spell you do not currently have in this hue.;', ''
$master_list_string = $master_list_string -replace 'skill mastery scroll', 'SS'
$master_list_string = $master_list_string -replace 'When used, it will unlock this spell hue for a randomized spell you do not currently have in this hue.;', ''
$master_list_string = $master_list_string -replace ' ;', ';'
$master_list_string = $master_list_string -replace 'Aspect', ' '
$master_list_string = $master_list_string -replace 'Tierra', ''
$master_list_string = $master_list_string -replace '\s+', ' '
$master_list_string = $master_list_string -replace '\s+;\s+', ';'
$master_list_string = $master_list_string -replace ';\s+', ';'
$master_list_string = $master_list_string -replace ' ;', ';'
$master_list_string = $master_list_string -replace '\s+;\s+', ';'
$master_list_string = $master_list_string -replace 'Tierra', ''
$master_list_string = $master_list_string -replace '\(.*?\)', ''
$master_list_string = $master_list_string -replace ':.*?;', ';'
$master_list_string = $master_list_string -replace '\s+', ' '
$master_list_string = $master_list_string -replace '\s+;\s+', ';'
$master_list_string = $master_list_string -replace ';\s+', ';'
$master_list_string = $master_list_string -replace ' ;', ';'
#echo $master_list_string

#push some stuff we had to cut
$master_list_string = $master_list_string + "carpet dyes galore;magic spellbooks;container identification wands;"



$master_list_string = $master_list_string -replace '\s+', ' '

#dedupe and sort list
$master_list_string = ($master_list_string -split ';' | Sort-Object | Select -Unique) -join ';'


$master_list_string_output = $master_list_string_output + $master_list_count + " Unique Items!] Available on \*\*\* Guild Vendor House`r`n``" + $master_list_string + "``"

$master_list_string_output = $master_list_string_output -replace '\`;', '`'
				
Add-Content $outfile " "
Add-Content $outfile " "
Add-Content $outfile $master_list_string_output	












