/*
 *	Autosplitter and Load Remover done by WillTreaty
 */

state("witch")
{
	string4 stage : 0x71B27C;
	bool chapterLoad : 0x945E94;
	float normalLoad : 0x92DBF0;
}

start 
{
	if (current.stage == "st01" && current.stage != old.stage) {
		return true;
	} else {
		return false;
	}
}

split
{
	if (current.stage != old.stage && current.stage != "" && current.stage != "st01") {
		return true;
	} else { 
		return false;
	}
}

isLoading
{
	if (current.chapterLoad || current.normalLoad == 1) {
		return true;
	} else {
		return false;
	}
}