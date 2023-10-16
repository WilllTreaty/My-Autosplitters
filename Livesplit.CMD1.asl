/*
 *	Autosplitter done by WillTreaty
 */

state("dirt")
{
	int eventComplete : "dirt.exe", 0x3B4BA08C;
	int raceCompelete : "dirt.exe", 0x008137B0, 0x30, 0x1C8;
	string13 raceName : "dirt.exe", 0x0079F3AC, 0x30, 0x18, 0x58, 0x58;
	int start : "dirt.exe", 0x00627450, 0x86C;
}

init
{
	vars.finalSplit = false;
}

update
{
	if (old.raceName == "pikes_peak_bc" && current.raceName == "chula") {
		vars.finalSplit = true;
	}
}

split
{
	if (current.eventComplete == 1 && old.eventComplete != current.eventComplete) {
		if (vars.finalSplit) {
			vars.finalSplit = false;
		} else {
			return true;
		}
	} else if (vars.finalSplit && current.raceCompelete == 1 && old.raceCompelete != current.raceCompelete) {
		return true;
	} else { 
		return false;	
	}
}

start 
{
	if (current.start == 1 && current.start != old.start) {
		return true;
	} else {
		return false;
	}
}