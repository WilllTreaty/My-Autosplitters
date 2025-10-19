/*
 *	Autosplitter and Load Remover done by Balathruin and WillTreaty
 */
 
state("SHIFT")
{
	int loading : 0x008CA2D0, 0xD04, 0x2C;
	int State : 0x5F05C0, 0x0;
	int Finish : 0x2A6020, 0xD3C;
	string25 DriftMode : 0x324EBC, 0x27C;
}

startup
{
	settings.Add("finishsplit", true, "Finish Split");
	settings.SetToolTip("finishsplit", "Split when crossing the finish line. Last round only for drifts, but each round for car battles.");
	
	settings.Add("mycarssplit", false, "My Cars Split");
	settings.SetToolTip("mycarssplit", "Split when leaving My Cars.");
	
	settings.Add("carlotsplit", false, "Car Lot Split");
	settings.SetToolTip("carlotsplit", "Split when leaving the Car Lot menu mid run.");
	
	settings.Add("upgradesplit", true, "Upgrade Split");
	settings.SetToolTip("upgradesplit", "Split when leaving the Upgrades menu.");
	
	settings.Add("tuningsplit", true, "Tuning Split");
	settings.SetToolTip("tuningsplit", "Split when leaving the Tuning menu or switching between quick and advanced.");
	
	settings.Add("quitdriftsplit", true, "Quit Drift Split");
	settings.SetToolTip("quitdriftsplit", "Split when quitting a drift event.");
	
    if (timer.CurrentTimingMethod == TimingMethod.RealTime) {
        var timingMessage = MessageBox.Show(
            "This game uses Time without Loads (Game Time) as the main timing method.\n"
            + "LiveSplit is currently set to show Real Time (RTA).\n"
            + "Would you like to set the timing method to Game Time?",
            "Shift 2: Unleashed | LiveSplit",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

start
{
	if(old.State == 73 && current.State == 74) {
		return true;
	} else {
		return false;
	}
}

split
{
	if(current.Finish > old.Finish && current.loading != 34078832 && settings["finishsplit"]) {
		return true;
	}
	else if(old.State == 124 && current.State == 73 && settings["mycarssplit"]) {
		return true;
	}
	else if(old.State == 110 && current.State == 73 && settings["carlotsplit"]) {
		return true;
	}
	else if(old.State == 118 && current.State == 73 && settings["upgradesplit"]) {
		return true;
	}
	else if((old.State == 131 || old.State == 114) && current.State == 73 && settings["tuningsplit"]) {
		return true;
	}
	else if(current.DriftMode == "Drift Mode:ON" && old.State == 63 && current.State == 65 && settings["quitdriftsplit"]) {
		return true;
	} else {
		return false;
	}
}

isLoading
{
	if(current.loading == 34078832) {
		return true;
	} else {
		return false;
	}
}

exit
{
	timer.IsGameTimePaused = false;
}