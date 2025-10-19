/*
 *	Autosplitter and Load Remover done by WillTreaty
 */

state("GridLegends")
{
	int loading : 0x232EC94;
	int start : 0x193BA58, 0x8A4;
	int onRace : 0x1922548, 0x9AC;
}

start 
{
	if (current.onRace == 1 && current.start == 1 && old.start != current.start) {
		return true;
	} else {
		return false;
	}
}

split
{
	if (current.onRace == 2 && old.onRace != current.onRace) {
		return true;
	} else { 
		return false;
	}
}

isLoading 
{
	if (current.loading == 0) {
		return true;
	} else {
		return false;
	}
}