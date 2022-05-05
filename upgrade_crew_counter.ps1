#Text looks like this in logs:
	#doubloons for sinking a ship
	#Crew Contracts added to pending salvage
	#1 Ship Upgrades added to pending salvage

$outfile = "C:\users\oreos\desktop\test.csv"
Set-Content $outfile ''

$boat_type = 'failure'
$grab_next = 0
$boatArray = @()
$folders = Get-ChildItem -Path 'C:\Program Files (x86)\Ultima Online Outlands\ClassicUO\Data\Client\JournalLogs' -Name
foreach($logName in $folders) 
{
    $files = 'C:\Program Files (x86)\Ultima Online Outlands\ClassicUO\Data\Client\JournalLogs\' + $logName
    foreach($file in $files)
	{
		foreach($line in Get-Content $file) 
		{
			$humanoid_mod = 0
			#System: Welcome Syal!
			if ($line -like "*System: Welcome Syal!*" )
			{
				break
			}
			if ($line -like "*ghostly crewman*" )
			{
				$boat_type = 'Ghost'
				$humanoid_mod = 800
			}
			if ($line -like "*a raider*" )
			{
				$boat_type = 'Raider'
				$humanoid_mod = 800
			}
			if ($line -like "*lizardman*" )
			{
				$boat_type = 'Lizard'
			}
			if ($line -like "*pedagogue*" )
			{
				$boat_type = 'Vile'
			}
			if ($line -like "*tradesman*" )
			{
				$boat_type = 'Trade'
				$humanoid_mod = 800
			}
			if ($line -like "*tidecaller*" )
			{
				$boat_type = 'Tidecaller'
			}
			if ($line -like "*sunken sorcerer*" )
			{
				$boat_type = 'Submerged'
			}
			if ($line -like "*ossuarian*" )
			{
				$boat_type = 'Ossuarian'
			}
			if ($line -like "*druidic voyager*" )
			{
				$boat_type = 'Druidic'
			}
			if ($line -like "*blood daemon*" )
			{
				$boat_type = 'Daemon'
			}
			if ($line -like "*fisherman captain*" )
			{
				$boat_type = 'Fisherman'
				$humanoid_mod = 1000
			}
			if ($line -like "*explorer captain*" )
			{
				$boat_type = 'Explorer'
				$humanoid_mod = 800
			}
			if ($line -like "*a pirate captain*" )
			{
				$boat_type = 'Pirate'
				$humanoid_mod = 800
			}
			if ($line -like "*a merchant captain*" )
			{
				$boat_type = 'Merchant'
				$humanoid_mod = 800
			}
			if ($line -like "*Fury: Ocean*" )
			{
				$boat_type = 'Boss'
			}
			if ($line -like "*The Insatiable Maw*" )
			{
				$boat_type = 'Mini'
			}
			if ($line -like "*doubloons for sinking a ship*" )
			{
				$out_line = $line.substring(42)
				$out_line = $out_line -replace " doubloons for sinking a ship! They have been placed in the ship's hold."
				
				$boat_size = [Math]::Floor([decimal](($humanoid_mod + $out_line.trim()) / 2000))	+ 1
				$dub_value = $out_line.trim() 
				$boat_size_type = 'broken'
				if ($boat_size -eq 1)
				{					
					$boat_size_type = 'Small'
				}
				if ($boat_size -eq 2)
				{
					$boat_size_type = 'Medium'
					
				}
				if ($boat_size -eq 3)
				{
					$boat_size_type = 'Large'					
				}
				if ($boat_size -eq 4)
				{
					$boat_size_type = 'Carrack'
					
				}
				if ($boat_size -ge 5)
				{
					$boat_size_type = 'Galleon'		
				}
				
				
				if ($grab_next -eq 1)
				{				
					Add-Content $outfile "$dub_value,$boat_size_type,$out_drop,$boat_type,$logName"	
				}	
				else
				{					
					Add-Content $outfile "$dub_value,$boat_size_type,NONE,$boat_type,$logName"	
				}
				$grab_next = 0		
			}
			if ($line -like "*added to pending salvage*" )
			{		
				if ($line -like "*Upgrade*" )
				{
					$out_drop = "Upgrade" 
				}
				else
				{
					$out_drop = "Crew_Contract"
				}				
				$grab_next = 1
			}			
        }
    }
}

