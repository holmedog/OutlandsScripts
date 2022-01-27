#change this to your output file
$outfile = "C:\Program Files (x86)\Ultima Online Outlands\ClassicUO\Data\Plugins\Assistant\Scripts\mib_sorter_dynamic.razor"

$dir = "C:\Program Files (x86)\Ultima Online Outlands\ClassicUO\Data\Client\JournalLogs"
$latest = Get-ChildItem -Path $dir | Sort-Object LastAccessTime -Descending | Select-Object -First 1

$file = $latest.name

Set-Content $outfile ''

Add-Content $outfile "#copy this to a new script"
Add-Content $outfile "overhead 'Select drop bag 1' 23"
Add-Content $outfile "@setvar dropBag1"
Add-Content $outfile "overhead 'Select drop bag 2' 23"
Add-Content $outfile "@setvar dropBag2"
Add-Content $outfile "overhead 'Select drop bag 3' 23"
Add-Content $outfile "@setvar dropBag3"
Add-Content $outfile "overhead 'Select drop bag 4' 23"
Add-Content $outfile "@setvar dropBag4"
Add-Content $outfile "overhead 'Select drop bag 5' 23"
Add-Content $outfile "@setvar dropBag5"
Add-Content $outfile "overhead 'Select drop bag 6' 23"
Add-Content $outfile "@setvar dropBag6"
Add-Content $outfile "overhead 'Select drop bag 7' 23"
Add-Content $outfile "@setvar dropBag7"
Add-Content $outfile "overhead 'Select drop bag 8' 23"
Add-Content $outfile "@setvar dropBag8"
Add-Content $outfile "overhead 'Select drop bag 9' 23"
Add-Content $outfile "@setvar dropBag9"
Add-Content $outfile "overhead 'Select drop bag 10' 23"
Add-Content $outfile "@setvar dropBag10"
Add-Content $outfile "overhead 'Select drop bag 11' 23"
Add-Content $outfile "@setvar dropBag11"
Add-Content $outfile "overhead 'Select drop bag 12' 23"
Add-Content $outfile "@setvar dropBag12"
Add-Content $outfile "overhead 'Select drop bag 13' 23"
Add-Content $outfile "@setvar dropBag13"
Add-Content $outfile "overhead 'Select drop bag 14' 23"
Add-Content $outfile "@setvar dropBag14"
Add-Content $outfile "overhead 'Select drop bag 15' 23"
Add-Content $outfile "@setvar dropBag15"
Add-Content $outfile " " 
Add-Content $outfile " " 	

$output_string = ""
foreach($line in Get-Content $dir\$file) {
	if ($line -like "*The SOS appears to be located at*" )
	{
		$dump_item_string = $line -replace '.*\(' -replace '\).*'
		$coords = $dump_item_string.split(",")
		$x_cord = [Math]::Floor([decimal]($coords[0].trim() / 1500)) + 1
		$y_cord = [Math]::Floor([decimal]($coords[1].trim() / 800))+ 1
		#$output_string =  $output_string + $x_cord + "," + $y_cord
	}
	if ($line -like "*MIB variable: *" )
	{
		$dump_item_string = $line -replace '.*\(' -replace '\).*'
		#    lift found 9999
		#drop noidBag -1 -1 0 
		$bag_var = $x_cord * $y_cord
		$output_string = $output_string  + "lift $dump_item_string 1`ndrop dropBag$bag_var -1 -1 0 `n"
		
		$output_string =  $output_string  + "`n"
	}
}


#$output_string = ($output_string -split ',' | Sort-Object) -join ','

Add-Content $outfile $output_string
Add-Content $outfile "stop"
Add-Content $outfile $master_list_string_output	