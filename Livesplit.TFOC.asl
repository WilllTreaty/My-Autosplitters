/*	Loadless Remover and Autosplitter done by WillTreaty and tested 
        by Breadn11. Currently works for all known versions of the game.	*/

state("TFOC")
{
	int Loading: "TFOC.exe", 0x0160F728, 0x3C, 0x4;
	int loadId: "TFOC.exe", 0x015D1FDC, 0x69C, 0x7C;
	int mapLoad: "TFOC.exe", 0x015D1FDC, 0x69C, 0xC, 0x0;
	string100 checkpoint: "TFOC.exe", 0x015D1FDC, 0x1AC, 0x38, 0x68;
	float megatron: "TFOC.exe", 0x01611D0C, 0x3C, 0x430, 0x370, 0x30, 0x350;
}

startup
{
	vars.notSplitCheckpoints = new List<string>{"Checkpoint_9936", "Checkpoint_14598", "istentLevel.Checkpoint_6518", "istentLevel.Checkpoint_658", "istentLevel.Checkpoint_4219", "m.TheWorld:PersistentLevel.Checkpoint_4757", "m.TheWorld:PersistentLevel.Checkpoint_3334", "ersistentLevel.Checkpoint_11363", "el.Checkpoint_6625", "ersistentLevel.Checkpoint_10515", "ersistentLevel.Checkpoint_2840", "heWorld:PersistentLevel.Checkpoint_1946", "d:PersistentLevel.Checkpoint_13220", "Checkpoint_6819", "Checkpoint_5739", "ckpoint_14654", "Level.Checkpoint_2735", "ersistentLevel.Checkpoint_11210", "ersistentLevel.Checkpoint_4833", "el.Checkpoint_11567"};
	vars.counter = 0;
	vars.stopTimer = false;
	vars.startFlag = false;

	settings.Add("onlychaptersplit", false, "Only Chapter Splits");
	settings.SetToolTip("onlychaptersplit", "Autosplitter only splits at end of each chapter instead of doing at every new checkpoint as well.");
}

update
{
	if (current.loadId == 8 || current.loadId == 9) {
		vars.startFlag = true;
	}

	if (!string.IsNullOrEmpty(current.checkpoint)) {
		vars.stopTimer = false;
	}

	if (current.checkpoint == "el.Checkpoint_1523" && current.megatron > old.megatron && vars.counter<4) {
		vars.counter++;
	}
}

split
{
	if (!settings["onlychaptersplit"]) {
		if (timer.CurrentTime.GameTime.Value.TotalSeconds > 1 && old.checkpoint != current.checkpoint && !vars.notSplitCheckpoints.Contains(current.checkpoint) && !string.IsNullOrEmpty(old.checkpoint) && !string.IsNullOrEmpty(current.checkpoint)) {
			return true;
		}
	} 

	if (current.Loading == 2 && (current.loadId == 11 || current.loadId == 12) && old.Loading != current.Loading && !string.IsNullOrEmpty(current.checkpoint) && !string.IsNullOrEmpty(old.checkpoint))  {
		return true;
	} else if (current.checkpoint == "el.Checkpoint_1523" && vars.counter == 4) {
		vars.counter = 0;
		return true;
	} else {
		return false;
	}
}

start 
{
	if (current.loadId == 0 && current.Loading == 1 && vars.startFlag) {
		vars.startFlag = false;
		return true;
	} else {
		return false;
	}
}

reset
{
	if ((current.loadId == 9 || current.loadId == 2) && !string.IsNullOrEmpty(current.checkpoint)) {
		return true;
	} else {
		return false;
	}
}

isLoading
{
	if (current.Loading == 2 || vars.stopTimer) {	
		vars.counter = 0;
   		return current.Loading == 2 || vars.stopTimer;
	} else {
		return false;
	}
}

exit
{
	vars.stopTimer = true;
	timer.IsGameTimePaused = true;
}