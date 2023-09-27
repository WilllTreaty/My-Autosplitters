/*
 *	Autosplitter and Loadless Remover done by Failracer and WillTreaty
 */

state("SpaceMarine")
{
	int loadingScreen : "SpaceMarine.exe", 0x018548D8;
	bool loading : "SpaceMarine.exe", 0x018BD1BC;
	int checkpoint : "SpaceMarine.exe", 0x01894D44, 0x58;
	int chapter : "SpaceMarine.exe", 0x01894D44, 0x1D0;
	int finalSplit: "SpaceMarine.exe", 0x01859874, 0xC, 0x30, 0x0, 0x10, 0x4;
}

startup
{
	vars.notSplitCheckpoints = new List<int>{-1, 0, 260};
	vars.chapterStarts = new List<int>{65653, 918178, 1314850, 95, 461870, 1769871, 2490574, 47, 853497, 2229614, 3211544, 4063348, 4718762, 1564, 329029, 1311610};

	settings.Add("onlychaptersplit", false, "Only Chapter Splits");
	settings.SetToolTip("onlychaptersplit", "Autosplitter only splits at start of each new chapter instead of doing at every new checkpoint as well.");
	
	settings.Add("ilmode", false, "IL Mode");
	settings.SetToolTip("ilmode", "This option shouldn't be activated unless attempting IL runs.");
}

split 
{
	if (settings["ilmode"]) {
		if (old.checkpoint != -1 && old.checkpoint != current.checkpoint && !vars.notSplitCheckpoints.Contains(current.checkpoint) && !settings["onlychaptersplit"]) {
			return true;
		} else if (old.checkpoint != -1 && old.checkpoint != current.checkpoint && vars.chapterStarts.Contains(current.checkpoint) && !vars.notSplitCheckpoints.Contains(current.checkpoint) && settings["onlychaptersplit"]) {
			return true;
		} else if (current.checkpoint == 1314234 && current.finalSplit == 3 && old.finalSplit != current.finalSplit) {
			return true;
		} else {
			return false;
		}
	}
	
	if (!settings["ilmode"]) {
		if (old.checkpoint != current.checkpoint && !vars.notSplitCheckpoints.Contains(current.checkpoint) && !settings["onlychaptersplit"]) {
			return true;
		} else if (old.checkpoint != current.checkpoint && vars.chapterStarts.Contains(current.checkpoint) && !vars.notSplitCheckpoints.Contains(current.checkpoint) && settings["onlychaptersplit"]) {
			return true;
		} else if (current.checkpoint == 1314234 && current.finalSplit == 3 && old.finalSplit != current.finalSplit) {
			return true;
		} else {
			return false;
		}
	}
}

start 
{
	if (old.chapter == 0 && current.chapter != old.chapter) {
		return true;
	} else {
		return false;
	}
}

reset
{
	if (current.chapter == 0 && current.chapter != old.chapter) {
		return true;
	} else {
		return false;
	}
}

isLoading 
{
	if (current.loading || current.loadingScreen == 2) {
		return true;
	} else {
		return false;
	}
}