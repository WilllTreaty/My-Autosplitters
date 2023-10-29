/*
 *	Autosplitter and Loadless done by WillTreaty
 */

state("dirt")
{
	int eventComplete : "dirt.exe", 0x003017E4, 0x10, 0x124, 0x40, 0x44, 0x14, 0x270;
	float raceCompelete : "dirt.exe", 0x00811080, 0x30, 0x4, 0x244;
	string13 raceName : "dirt.exe", 0x0079F3AC, 0x30, 0x18, 0x58, 0x34, 0x4, 0x8;
	int start : "dirt.exe", 0x00627450, 0x86C;
	bool loading : "dirt.exe", 0x00331DE0, 0xB38, 0x180, 0x0, 0x28, 0x70;
}

init
{
	vars.finalSplit = false;
}

startup
{
	settings.Add("onlyeventsplit", false, "Only Event Split");
	settings.SetToolTip("onlyeventsplit", "Split when only player finishes an event, final split is still automatic");
}

update
{
	if (old.raceName == "pikes_peak_bc" && current.raceName == "chula") {
		vars.finalSplit = true;
	}
}

split
{
	if (settings["onlyeventsplit"]) {
		if (current.eventComplete == 0 && old.eventComplete != current.eventComplete && current.raceCompelete == 30) {
			if (vars.finalSplit) {
				vars.finalSplit = false;
				return false;
			} else {
				return true;
			}
		} else if (vars.finalSplit && current.raceCompelete == 30 && old.raceCompelete != current.raceCompelete) {
			return true;
		} else { 
			return false;	
		}
	} else {
		if (current.raceCompelete == 30 && old.raceCompelete != current.raceCompelete) {
			return true;
		} else {
			return false;
		}
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

isLoading
{
	return current.loading;
}