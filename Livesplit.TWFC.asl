/*	Loadless Remover done by KC and now added Autosplitter by WillTreaty 
        and tested by F.F.R. Currently works for all known versions of the game.	*/

state("TWFC")
{
	int state : "TWFC.exe", 0x021108C4, 0x5D4;
	bool Loading : "TWFC.exe", 0x0226F3FC, 0x3c, 0x1B4, 0x28, 0x130, 0x770;
	int loadId: "TWFC.exe", 0x02210968, 0x538, 0x88;
	int map: "TWFC.exe", 0x02246BEC, 0x8;
	int checkpoint: "TWFC.exe", 0x02246BEC, 0x48;
	int cutscene : "TWFC.exe", 0x02210A78, 0x8, 0x0, 0x4, 0x20;
	int omegasupreme: "TWFC.exe", 0x02242A4C, 0x54, 0x2C, 0x68, 0x974;
	int trypticon: "TWFC.exe", 0x02242A4C, 0x20, 0x2C, 0x3DC, 0x7C, 0x94, 0x8BC; 
}

startup
{
	vars.notSplitCheckpoints = new List<int>{1882469686, 1342190386, 1882535992, 3289654, 960049713, 875575352, 892548153, 842281267, 1882732341, 892614708, 943272500, 55, 1882470450, 1882470457, 1882207284, 1882338353, 1882338096};

	settings.Add("onlychaptersplit", false, "Only Chapter Splits");
	settings.SetToolTip("onlychaptersplit", "Autosplitter only splits at end of each chapter instead of doing at every new checkpoint as well.");

	settings.Add("undosplit", false, "Undo Split");
	settings.SetToolTip("undosplit", "Autosplitter undo's a split once if runner dies after finishing either Omega Supreme boss fight at Ch5 or Trypticon boss fight at Ch10.");
 	vars.TimerModel = new TimerModel { CurrentState = timer };
}

update
{
	if (settings["undosplit"] && current.state == 622 && old.state != current.state) {
		if (current.map == 1597334542 && current.omegasupreme == 3) {
			vars.TimerModel.UndoSplit();
		} else if (current.map == 1597333774 && current.trypticon == 0) {
			vars.TimerModel.UndoSplit();
		}
	}
}

split
{
	if (!settings["onlychaptersplit"]) {
		if (timer.CurrentTime.GameTime.Value.TotalSeconds > 1 && current.cutscene == 0 && old.checkpoint != current.checkpoint && !vars.notSplitCheckpoints.Contains(current.checkpoint)) {
			return true;
		}
	}

	if (current.state == 628 && old.map != 1597334542 && old.map != 1597333774 && current.cutscene != 0 && old.state != current.state && !vars.notSplitCheckpoints.Contains(current.checkpoint)) {
		return true;
	} else if (current.map == 1597334542 && old.omegasupreme != current.omegasupreme && current.state == 632 && current.omegasupreme == 3) {
		return true;
	} else if (current.map == 1597333774 && old.trypticon != current.trypticon && current.state == 632 && current.trypticon == 0) {
		return true;
	} else {
		return false;
	}
}

start 
{
	if ((old.loadId == 16 || old.loadId == 15) && current.loadId == 0) {
		return true;
	} else {
		return false;
	}
}

reset
{
	if (current.loadId == 16 || current.loadId == 2) {
		return true;
	} else {
		return false;
	}
}

isLoading
{
	return current.Loading;
}