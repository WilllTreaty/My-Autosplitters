/*
 *	Autosplitter and Load Remover done by Balathruin and WillTreaty
 */

state("shift2u", "Small Exe")
{
	int loading : 0x17714, 0x400;
	bool Movie : 0xAB70A0, 0x19C;
	int Finish : 0x60D7DC, 0x450;
}

state("shift2u", "Big Exe")
{
	int loading : 0x17654, 0x400;
	bool Movie : 0xAB40A0, 0x19C;
	int Finish : 0x4787AC, 0x3A0;
}

init 
{
	//Small Exe
	if (modules.First().ModuleMemorySize == 0xBF0000) {
		version = "Small Exe";
	}
	//Big Exe
	else if (modules.First().ModuleMemorySize == 0x1E13000) {
		version = "Big Exe";
	}
}

startup
{
	settings.Add("finishsplit", true, "Finish Split");
	settings.SetToolTip("finishsplit", "Split when crossing the finish line.");
}

update 
{
	if (version == "") {
		return false;
	}
}

start
{
	if(current.Movie && old.Movie != current.Movie) {
		return true;
	} else {
		return false;
	}
}

split
{
	if(current.Finish == 3 && old.Finish == 2 && settings["finishsplit"]) {
		return true;
	} else {
		return false;
	}
}

isLoading
{
	if(current.loading != 0 && !current.Movie) {
		return true;
	} else {
		return false;
	}
}

exit
{
	timer.IsGameTimePaused = false;
}