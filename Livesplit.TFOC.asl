/*  Loadless Remover and Autosplitter done by WillTreaty and tested 
    by Breadn11. Currently works for all known versions of the game.  */

state("TFOC")
{
	string100 checkpoint: "TFOC.exe", 0x015D1FDC, 0x1AC, 0x38, 0x68;
	int mapLoad: "TFOC.exe", 0x015D1FDC, 0x69C, 0xC, 0x0;
	bool loadless: "TFOC.exe", 0x015D28BC, 0x14, 0x60;
	float megatron: "TFOC.exe", 0x01611D0C, 0x3C, 0x430, 0x370, 0x30, 0x350;
	int loadId: "TFOC.exe", 0x015D1FDC, 0x69C, 0x7C;
}

startup
{
	vars.firstCheckpoints = new List<string>{"Checkpoint_9936", "Checkpoint_14598", "istentLevel.Checkpoint_6518", "istentLevel.Checkpoint_658", "m.TheWorld:PersistentLevel.Checkpoint_4757", "ersistentLevel.Checkpoint_11363", "el.Checkpoint_6625", "ersistentLevel.Checkpoint_10515", "ersistentLevel.Checkpoint_2840", "heWorld:PersistentLevel.Checkpoint_1946", "d:PersistentLevel.Checkpoint_13220", "Checkpoint_6819", "Checkpoint_5739", "ckpoint_14654", "Level.Checkpoint_2735", "ersistentLevel.Checkpoint_11210", "el.Checkpoint_11567"};
	vars.counter = 0;

	settings.Add("onlychaptersplit", false, "Only Chapter Splits");
	settings.SetToolTip("onlychaptersplit", "Autosplitter only splits at end of each chapter instead of doing at every new checkpoint as well.");
}

update
{
	if (current.checkpoint == "el.Checkpoint_1523" && current.megatron > old.megatron && vars.counter<4) {
		vars.counter++;
	}
}

split
{
	if (!settings["onlychaptersplit"]) {
		if (old.checkpoint != current.checkpoint && !vars.firstCheckpoints.Contains(current.checkpoint)) {
			return true;
		}
	} 

	if (current.loadless && current.mapLoad == 1 && old.mapLoad != current.mapLoad)  {
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
	if ((old.loadId == 8 || old.loadId == 9) && current.loadId == 0) {
		return true;
	} else {
		return false;
	}
}

reset
{
	if (current.loadId == 9 || current.loadId == 2) {
		return true;
	} else {
		return false;
	}
}

isLoading
{
	if (current.loadless) {	
		vars.counter = 0;
   		return current.loadless;
	} else {
		return false;
	}
}
