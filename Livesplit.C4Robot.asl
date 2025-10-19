/*
 *	Autosplitter done by WillTreaty
 */

state("C4")
{
	int checkpoint : "acknex.dll", 0x201644, 0xB44, 0x0, 0x10, 0x4, 0x10;
	int raceState : "acknex.dll", 0x218DEC, 0x490, 0x10;
}

start 
{
	if (current.raceState == 1024 && current.raceState != old.raceState) {
		return true;
	} else {
		return false;
	}
}

split
{
	if (old.checkpoint != current.checkpoint) {
		return true;
	} else { 
		return false;
	}
}

reset 
{
	if (current.raceState == 0 && current.raceState != old.raceState) {
		return true;
	} else {
		return false;
	}
}