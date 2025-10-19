/*
 *	Autosplitter and Load Remover by TDOG20, Jigsaw, Balathruin and WillTreaty
 */

state("speed", "v1.2") 
{
	//ID of current race
	string30 trackID : "speed.exe", 0x51CFCC, 0x44, 0x4, 0x0;
	
	//Used for autostart
	int selectedMenu : "speed.exe", 0x51BF84;
	float start : "speed.exe", 0x51BA9C, 0x0, 0x18C;
	
	//Used for Game Over Split
	int gameover : "speed.exe", 0x5C1220, 0x490;

	//Name of current FMV and NIS
	string14 fmvName : "speed.exe", 0x51C228, 0x18, 0x68, 0x40, 0x0;
	string11 nisName : "speed.exe", 0x50CA88, 0xC, 0x10, 0x4;
	
	//Describes the loading screen state
	int loadingScreen1 : "speed.exe", 0x510ED0;
	int loadingScreen2 : "speed.exe", 0x5112D0;
	bool restartLoad : "speed.exe", 0x51BEE8;

	//Displays the current state of the game and also helps with the loadless timer
	int gamestateID : "speed.exe", 0x51CCB4;
	
	//Used for deciding if a race is finished or not
	int raceState : "speed.exe", 0x50F764;
	
	//Used for determining if player is in a chase or race
	int onChase : "speed.exe", 0x51C398;
	int onRace : "speed.exe", 0x5B27E8;
	
	//Used for determining if player has exited shop or carlot/has started a nmg run
	int inShop: "speed.exe", 0x51B120, 0x118;
	
	//Used for Quick Race Mode stuff
	int raceStart : "speed.exe", 0x510EB0;
	int raceCP : "speed.exe", 0x51CFC0, 0x44;
	float completion : "speed.exe", 0x52ED58, 0x2F8, 0x50;
}

state("speed", "v1.3") 
{
	//ID of current race
	string30 trackID : "speed.exe", 0x51E00C, 0x48, 0x1C;
	
	//Used for autostart
	int selectedMenu : "speed.exe", 0x51CFC4;
	
	//Used for Game Over Split
	int gameover : "speed.exe", 0x5C2270, 0x490;
	
	//Name of current FMV and NIS
	string14 fmvName : "speed.exe", 0x51D268, 0x18, 0x68, 0x40, 0x0;
	string11 nisName : "speed.exe", 0x50DAC8, 0xC, 0x10, 0x4;
	
	//Describes the loading screen state
	int loadingScreen1 : "speed.exe", 0x511F10;
	int loadingScreen2 : "speed.exe", 0x512310;
	bool restartLoad : "speed.exe", 0x51CF28;
	
	//Displays the current state of the game and also helps with the loadless timer
	int gamestateID : "speed.exe", 0x51DCF4;
	
	//Used for deciding if a race is finished or not
	int raceState : "speed.exe", 0x5107A4;
	
	//Used for determining if player is in a chase or race
	int onChase : "speed.exe", 0x51D3D8;
	int onRace : "speed.exe", 0x5B3828;

	//Used for determining if player has exited shop or carlot/has started a nmg run
	int inShop : "speed.exe", 0x51C160, 0x118;
	
	//Used for Quick Race Mode stuff
	int raceStart : "speed.exe", 0x511EF0;
	int raceCP : "speed.exe", 0x51E000, 0x44;
	float completion : "speed.exe", 0x52FD98, 0x2F8, 0x50;
}

init
{
	//Original 1.2 speed.exe
	if (modules.First().ModuleMemorySize == 0x67F000) {
		version = "v1.2";
	}
	//Original 1.3 speed.exe
	else if (modules.First().ModuleMemorySize == 0x680000) {
		version = "v1.3";
	}
	//Cracked 1.3 speed.exe (RELOADED)
	else if (modules.First().ModuleMemorySize == 0x678E4E) {
		version = "v1.3";
	}
}

startup
{
	//Used for checking current split index and handling quick race mode resets
	vars.timerModel = new TimerModel { CurrentState = timer };
	
	//Contains bool values for controlling quick race mode interval splits
	vars.percentages = new List<bool> { false, false, false, false, false };

	//Contains last race for every boss in 15 -> 1 order, used for boss split option
	vars.lastBossRaces = new List<string>{
		"15_1_1_circuit_reversed",
		"15_2_1_sprint_reverse",
		"14_2_2_r_sprint",
		"12_1_2_circuit",
		"12_1_2_r_circuit",
		"10_7_3_drag",
		"9_2_1_sprint",
		"8_7_5_drag",
		"7_2_3_p2p",
		"6_5_2_speedtraprace",
		"5_2_1_r_sprint",
		"4_5_1_r_speedtrap",
		"3_1_2_circuit",
		"2_2_1_sprint",
		"1_2_3_sprint"
	};
	
	settings.Add("quickracemode", false, "Quick Race Mode");
	settings.SetToolTip("quickracemode", "Handles starts, splits and resets for quick race (IL) conditions.");
	
	settings.Add("racecpsplit", false, "Race Checkpoint Splits", "quickracemode");
	settings.SetToolTip("racecpsplit", "Split when you go through in race checkpoints.");
	
	settings.Add("raceintervalsplit", true, "Race Interval Splits", "quickracemode");
	settings.SetToolTip("raceintervalsplit", "Split at every 20 percent interval of race completion.");

	settings.Add("12specific", true, "1.2 Specific Settings");
	settings.Add("commonsettings", true, "Common Settings");
	
	settings.Add("lapglitchsplit", true, "First Lap Glitches Split", "12specific");
	settings.SetToolTip("lapglitchsplit", "Split when you start career after first lap glitches.");
	
	settings.Add("resumecareersplit", true, "Mid Run Lap Glitches Split", "12specific");
	settings.SetToolTip("resumecareersplit", "Split when you resume career after doing lap glitches mid run.");
	
	settings.Add("introsplit", true, "Intro Split", "commonsettings");
	settings.SetToolTip("introsplit", "Split after the partial race with the intro cutscene.");
	
	settings.Add("prologuesplit", true, "Prologue Split", "commonsettings");
	settings.SetToolTip("prologuesplit", "Split after the last prologue race with Razor.");
	
	settings.Add("safehousesplit", true, "Safe House Split", "commonsettings");
	settings.SetToolTip("safehousesplit", "Split when you enter safe house for the first time after buying your starter car.");
	
	settings.Add("shopsplit", true, "Shop Split", "commonsettings");
	settings.SetToolTip("shopsplit", "Split when you exit a car lot or an upgrade shop.");
	
	settings.Add("racesplit", true, "Race Split", "commonsettings");
	settings.SetToolTip("racesplit", "Split when you win a race.");
	
	settings.Add("camerasplit", true, "Camera Split", "commonsettings");
	settings.SetToolTip("camerasplit", "Split when completing a Speedtrap Milestone in free roam.");

	settings.Add("bosssplit", false, "Boss Split", "commonsettings");
	settings.SetToolTip("bosssplit", "Split when defeating a boss by winning the last boss race. Does nothing if Race Split setting is also activated.");

	settings.Add("markersplit", true, "Marker Split", "commonsettings");
	settings.SetToolTip("markersplit", "Split on the first loading screen after choosing markers.");

	settings.Add("copchasesplit", true, "Police Chase Split", "commonsettings");
	settings.SetToolTip("copchasesplit", "Split when you escape a police chase.");
	
	settings.Add("bustedsplit", false, "Busted Split", "commonsettings");
	settings.SetToolTip("bustedsplit", "Split after getting busted.");
	
	settings.Add("gameoversplit", false, "Game Over Split", "commonsettings");
	settings.SetToolTip("gameoversplit", "Split when the game over screen appears. Intended to be used for Career Bad Ending category.");
	
	settings.Add("bridgejumpsplit", true, "Bridge Jump Split", "commonsettings");
	settings.SetToolTip("bridgejumpsplit", "Split when you trigger the bridge jump cutscene.");
	
    if (timer.CurrentTimingMethod == TimingMethod.RealTime) {
        var timingMessage = MessageBox.Show(
            "This game uses Time without Loads (Game Time) as the main timing method.\n"
            + "LiveSplit is currently set to show Real Time (RTA).\n"
            + "Would you like to set the timing method to Game Time?",
            "Need for Speed: Most Wanted | LiveSplit",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }	
}

update 
{
	//Not allowing time controls if game version is not detected
	if (version == "") {
		return false;
	}
	
	//Used with quick race mode for resetting time interval splits and for the timer itself while saving golds/pb
	if ((timer.CurrentPhase == TimerPhase.Ended || timer.CurrentPhase == TimerPhase.NotRunning) && settings["quickracemode"] && old.raceStart != current.raceStart && current.raceStart == 32767) {
		vars.percentages = new List<bool> { false, false, false, false, false };
		vars.timerModel.Reset();
	}
}

start 
{
	//Quick race menu start
	if (!settings["quickracemode"] && version == "v1.2" && ((current.selectedMenu == 3 && current.start == 60 && old.start != current.start) || (current.selectedMenu == 3 && old.selectedMenu != current.selectedMenu))) {
		return true;
	} 
	//Direct career or challenge series start
	else if (!settings["quickracemode"] && (current.selectedMenu == 1 && old.inShop == 88 && current.inShop == 21) || (current.selectedMenu == 2 && current.loadingScreen2 == 24)) {
		return true;
	//Start on racestart at "go" for quick race mode
	} else if (settings["quickracemode"] && old.raceStart == 32767 && current.raceStart == 0 && current.onRace == 257) {
		return true;
	} else {
		return false;
	}
}

split
{
	//Differentiating normal splits and quick race mode splits
	if (!settings["quickracemode"]) {
		//Split after first lap glitches
		if (version == "v1.2" && settings["lapglitchsplit"] && timer.CurrentSplitIndex == 0 && ((old.fmvName != current.fmvName && current.fmvName == "storyfmv_rac01") || (old.inShop == 88 && current.inShop == 84))) {
			return true;
		}
		//Split when resuming career
		else if (version == "v1.2" && timer.CurrentSplitIndex > 0 && old.selectedMenu != current.selectedMenu && current.selectedMenu == 1 && settings["resumecareersplit"]) {
			return true;
		}
		//Split before Ronnie prologue race
		else if (old.fmvName != current.fmvName && current.fmvName == "storyfmv_cro06" && settings["introsplit"]) {
			return true;
		}
		//Split after Razor prologue race
		else if (old.fmvName != current.fmvName && current.fmvName == "storyfmv_bus12" && settings["prologuesplit"]) {
			return true;
		}
		//Split after entering Safe House for the first time
		else if (old.fmvName != current.fmvName && current.fmvName == "storyfmv_saf25" && settings["safehousesplit"]) {
			return true;
		}
		//Split when exiting car lot or upgrade shop
		else if ((old.inShop == 111 || old.inShop == 72) && old.inShop != current.inShop && settings["shopsplit"]) {
			return true;
		}
		//Split after winning any race
		else if (current.raceState == 256 && old.raceState == 0 && current.onRace == 257 && settings["racesplit"]) {
			return true;
		}
		//Split after triggering a free roam camera
		else if (current.raceState == 256 && old.raceState == 0 && current.onRace != 257 && settings["camerasplit"]) {
			return true;
		}
		//Split after winning the last boss race
		else if (current.raceState == 256 && old.raceState == 0 && current.onRace == 257 && (vars.lastBossRaces.Contains(current.trackID) || vars.lastBossRaces.Contains(current.trackID.Substring(0, current.trackID.Length - 4))) && !settings["racesplit"] && settings["bosssplit"]) {
			return true;
		}
		//Split after choosing markers
		else if (!string.IsNullOrEmpty(old.fmvName) && !old.fmvName.Contains("blacklist_15") && old.fmvName.Contains("blacklist_") && old.fmvName != current.fmvName && settings["markersplit"]) {
			return true;
		}
		//Split after escaping Police Chases
		else if (old.onChase == 1 && current.onChase == 0 && current.onRace != 257 && (old.loadingScreen1 != 32767 && old.loadingScreen2 != 24 && old.loadingScreen2 != 0 && old.gamestateID != 16) && (current.trackID != "epic_pursuit" && current.trackID != "epic_pursuit.vlt") && settings["copchasesplit"]) {
			return true;
		}
		//Split after getting busted
		else if (current.onChase == 1 && current.loadingScreen1 == 32767 && old.loadingScreen1 != current.loadingScreen1 && settings["bustedsplit"]) {
			return true;
		}
		//Split when game over screen appears
		else if (current.gameover == 10 && old.gameover != current.gameover && current.inShop == 84 && settings["gameoversplit"]) {
			return true;
		}
		//Split when final bridge jump NIS plays
		else if (old.nisName != current.nisName && current.nisName == "EndingNis04" && settings["bridgejumpsplit"]) {
			return true;
		} else {
			return false;
		}
	} else if (settings["quickracemode"]) {
		//Split after each 20% interval in the race besides finish line/100%
		if (settings["raceintervalsplit"] && (int)current.completion >= 20 && (int)current.completion < 40 && !vars.percentages[0]) {
			vars.percentages[0] = true;
			return true;
		} else if (settings["raceintervalsplit"] && (int)current.completion >= 40 && (int)current.completion < 60 && !vars.percentages[1]) {
			vars.percentages[1] = true;
			return true;
		} else if (settings["raceintervalsplit"] && (int)current.completion >= 60 && (int)current.completion < 80 && !vars.percentages[2]) {
			vars.percentages[2] = true;
			return true;
		} else if (settings["raceintervalsplit"] && (int)current.completion >= 80 && (int)current.completion < 100 && !vars.percentages[3]) {
			vars.percentages[3] = true;
			return true;
		//Split after every new checkpoint in the race besides finish line
		} else if (settings["racecpsplit"] && current.raceCP != old.raceCP && !((int)current.completion >= 97 && current.raceCP == 0)) {
			return true;
		//Split after crossing finish line
		} else if ((int)current.completion >= 100 && current.onRace == 257 && !vars.percentages[4]) {
			vars.percentages[4] = true;
			return true;
		} else {
			return false;
		}
	}
}

isLoading
{
	//Every normal loading screen
	if (current.loadingScreen1 == 32767 || current.loadingScreen2 == 24 || current.loadingScreen2 == 0 || current.gamestateID == 16) {
		return true;
	}
	//Special loading screen being: entering the safe house for the first time and entering free roam for the first time
	//Still needs fixing timer being paused until player continues even though loading has been completed
	else if (current.gamestateID == 32) {
		//Exclude FMVs from being counted to loadless
		if (current.loadingScreen2 == 34) {
			return false;
		} else {
			return true;
		}
	//Loading screens for mid race restarts	
	} else if (current.onRace == 257 && current.restartLoad) {
		return true;
	} else {
		return false;
	}
}

reset 
{
	//Reset function is only used for quick race mode, handles resetting race interval splits
	if (settings["quickracemode"] && old.raceStart != current.raceStart && current.raceStart == 32767) {
		vars.percentages = new List<bool> { false, false, false, false, false };
		return true;
	} else {
		return false;
	}
}

exit
{
	timer.IsGameTimePaused = false;
}