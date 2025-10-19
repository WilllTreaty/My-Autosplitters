/*
 *	Autosplitter and Load Remover done by Failracer and WillTreaty
 */

state("SpaceMarine")
{
	int loadingScreen : "SpaceMarine.exe", 0x018548D8;
	bool loading : "SpaceMarine.exe", 0x018BD1BC;
	int checkpoint : "SpaceMarine.exe", 0x01894D44, 0x58;
	int chapter : "SpaceMarine.exe", 0x01894D44, 0x1D0;
	int finalSplit: "SpaceMarine.exe", 0x0194E648, 0xC, 0x10, 0x72C;
}

startup
{
	vars.notSplitCheckpoints = new List<int>{-1, 0, 260};
	vars.chapterStarts = new List<int>{65653, 918178, 1313668, 95, 461870, 1769871, 2490574, 47, 853497, 2229614, 3211544, 4063348, 4787830, 1564, 329029, 1311610};

	settings.Add("onlychaptersplit", false, "Only Chapter Splits");
	settings.SetToolTip("onlychaptersplit", "Autosplitter only splits at start of each new chapter instead of doing at every new checkpoint as well.");
}

update
{
	if (timer.CurrentSplitIndex == 0) {
		vars.notSplitCheckpoints = new List<int>{-1, 0, 260};
	}
}

start 
{
	if (old.chapter == 0 && current.chapter == 1) {
		return true;
	} else {
		return false;
	}
}

split 
{
	if (old.checkpoint != current.checkpoint && !vars.notSplitCheckpoints.Contains(current.checkpoint) && !settings["onlychaptersplit"]) {
		vars.notSplitCheckpoints.Add(current.checkpoint);
		return true;
	} else if (old.checkpoint != current.checkpoint && vars.chapterStarts.Contains(current.checkpoint) && !vars.notSplitCheckpoints.Contains(current.checkpoint) && settings["onlychaptersplit"]) {
		vars.notSplitCheckpoints.Add(current.checkpoint);
		return true;
	} else if (current.checkpoint == 1314234 && current.finalSplit == 2 && old.finalSplit != current.finalSplit) {
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

reset
{
	if (current.chapter == 1 && old.chapter == 0) {
		return true;
	} else {
		return false;
	}
}