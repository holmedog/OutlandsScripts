#doubloons for sinking a ship
#Crew Contracts added to pending salvage
#1 Ship Upgrades added to pending salvage


$boats = 0
$small = 0
$med = 0
$large = 0
$carr = 0
$gally = 0
$folders = Get-ChildItem -Path 'C:\Program Files (x86)\Ultima Online Outlands\ClassicUO\Data\Client\JournalLogs' -Name
foreach($item in $folders) 
{
    $files = 'C:\Program Files (x86)\Ultima Online Outlands\ClassicUO\Data\Client\JournalLogs\' + $item
    foreach($file in $files)
	{
		foreach($line in Get-Content $file) 
		{
			#System: Welcome Syal!
			if ($line -like "*System: Welcome Syal!*" )
			{
				break
			}
			if ($line -like "*doubloons for sinking a ship*" )
			{
				$out_line = $line.substring(42)
				$out_line = $out_line -replace " doubloons for sinking a ship! They have been placed in the ship's hold."
				#echo "$out_line"
				$boat_size = [Math]::Floor([decimal]($out_line.trim() / 2000)) + 1
				
				if($boat_size -eq 1)
				{
					$small++
				}
				if($boat_size -eq 2)
				{
					$med++
				}
				if($boat_size -eq 3)
				{
					$large++
				}
				if($boat_size -eq 4)
				{
					$carr++
				}
				if($boat_size -ge 5)
				{
					$gally++
				}				
				
				$boats++				
				$dubs = ($dubs + [int]$out_line)
				#echo "Boats: [$boats] Dubs: [$dubs] BoatSize: [$boat_size] small: [$small] med: [$med] large: [$large] carr: [$carr] gally: [$gally]"
			}		
        }
    }
}

echo "Boats: [$boats] Dubs: [$dubs] small: [$small] med: [$med] large: [$large] carr: [$carr] gally: [$gally]"