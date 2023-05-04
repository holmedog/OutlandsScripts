#change this to your output file
$outfile = "C:\Program Files (x86)\Ultima Online Outlands\ClassicUO\Data\Plugins\Assistant\Scripts\MIBLOCS.txt"

$dir = "C:\Program Files (x86)\Ultima Online Outlands\ClassicUO\Data\Client\JournalLogs"
$latest = Get-ChildItem -Path $dir | Sort-Object LastAccessTime -Descending | Select-Object -First 1

$file = $latest.name
$cord_array =  @()
Set-Content $outfile "+`tM`t1`t1`t0`tfalse"
$output_string = ""
foreach($line in Get-Content $dir\$file) {
	if ($line -like "*a waterstained SOS message*" )
	{
		$dump_item_string = $line -replace '.*\(' -replace '\).*'
		$dump_item_string = $dump_item_string -replace "located at "
		echo $dump_item_string
		$coords = $dump_item_string.split(",")
		$x_cord = $coords[0]
		$y_cord = $coords[1]
		#$output_string =  $output_string + $x_cord + "," + $y_cord		
		Add-Content $outfile  "+`tM`t$x_cord`t$y_cord`t0`tfalse"
	}
}
 