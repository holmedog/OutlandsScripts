#change this to your output file
$outfile = "C:\Program Files (x86)\Ultima Online Outlands\ClassicUO\Data\Plugins\Assistant\Scripts\mib_sorter_dynamic.razor"

$dir = "C:\Program Files (x86)\Ultima Online Outlands\ClassicUO\Data\Client\JournalLogs"
$latest = Get-ChildItem -Path $dir | Sort-Object LastAccessTime -Descending | Select-Object -First 1

$file = $latest.name
$cord_array =  @()
Set-Content $outfile ''
$output_string = ""
foreach($line in Get-Content $dir\$file) {
	if ($line -like "*The SOS appears to be located at*" )
	{
		$dump_item_string = $line -replace '.*\(' -replace '\).*'
		$coords = $dump_item_string.split(",")
		$x_cord = [Math]::Floor([decimal]($coords[0].trim() / 755))
		$y_cord = [Math]::Floor([decimal]($coords[1].trim() / 810))+ 1
		#$output_string =  $output_string + $x_cord + "," + $y_cord
	}
	if ($line -like "*MIB variable: *" )
	{
		$dump_item_string = $line -replace '.*\(' -replace '\).*'
		#    lift found 9999
		#drop noidBag -1 -1 0 
		$bag_var = $y_cord * 6
		$bag_var = $bag_var + $x_cord
		$cord_array += $bag_var + "`n"
		$output_string = $output_string  + "lift $dump_item_string 1`ndrop dropBag$bag_var -1 -1 0 `n"
		
		$output_string =  $output_string  + "`n"
	}
}


Add-Content $outfile "#copy this to a new script"

$cord_array = $cord_array | select -Unique
$cord_array = $cord_array | sort

	foreach ($coord in $cord_array)
	{
		Add-Content $outfile "overhead 'Select drop bag $coord' 23"
		Add-Content $outfile "@setvar dropBag$coord"
	}



	Add-Content $outfile " " 
	Add-Content $outfile " " 	
	Add-Content $outfile $output_string
	Add-Content $outfile "stop"
	Add-Content $outfile $master_list_string_output	