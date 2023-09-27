/*
 *	Autosplitter and Loadless Remover done by TDOG20, Jigsaw, Balathruin & WillTreaty (1.9 version)
 */

state("speed", "v1.2") 
{
	//ID of current race
	string30 trackID : 0x51CFCC, 0x44, 0x4, 0x0;
	
	//Used for autostart
	int selectedMenu : 0x51BF84;
	float start : 0x51BA9C, 0x0, 0x18C;
	
	//Used for Game Over Split
	int gameover : 0x5C1220, 0x490;

	//Name of current FMV and NIS
	string14 fmvName : 0x51C228, 0x18, 0x68, 0x40, 0x0;
	string11 nisName : 0x50CA88, 0xC, 0x10, 0x4;
	
	//Describes the loading screen state
	int loadingScreen1 : "speed.exe", 0x510ED0;
	int loadingScreen2 : "speed.exe", 0x5112D0;

	//Displays the current state of the game and also helps with the loadless timer
	int gamestateID : "speed.exe" , 0x51CCB4;
	
	//Race state
	int raceState : "speed.exe", 0x50F764;
	
	//Used for determining if player is in a chase or race
	int onChase : 0x51C398;
	int onRace : 0x5B27E8;
	
	//Used for determining if player has exited shop or carlot/has started a nmg run
	int inShop: 0x51B120, 0x118;
}

state("speed", "v1.3") 
{
	//ID of current race
	string30 trackID : 0x51E00C, 0x48, 0x1C;
	
	//Used for autostart
	int selectedMenu : 0x51CFC4;
	
	//Used for Game Over Split
	int gameover : 0x5C2270, 0x490;
	
	//Name of current FMV and NIS
	string14 fmvName : 0x51D268, 0x18, 0x68, 0x40, 0x0;
	string11 nisName : 0x50DAC8, 0xC, 0x10, 0x4;
	
	//Describes the loading screen state
	int loadingScreen1 : "speed.exe", 0x511F10;
	int loadingScreen2 : "speed.exe", 0x512310;
	
	//Displays the current state of the game and also helps with the loadless timer
	int gamestateID : "speed.exe", 0x51DCF4;
	
	//Race state
	int raceState : "speed.exe", 0x5107A4;
	
	//Used for determining if player is in a chase or race
	int onChase : 0x51D3D8;
	int onRace : 0x5B3828;

	//Used for determining if player has exited shop or carlot/has started a nmg run
	int inShop : 0x51C160, 0x118;
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

	settings.Add("lapglitchsplit", true, "First Lap Glitches Split");
	settings.SetToolTip("lapglitchsplit", "Split when you start career after first lap glitches.");
	
	settings.Add("resumecareersplit", false, "Mid Run Lap Glitches Split");
	settings.SetToolTip("resumecareersplit", "Split when you resume career after doing lap glitches mid run.");
	
	settings.Add("introsplit", true, "Intro Split");
	settings.SetToolTip("introsplit", "Split after the partial race with the intro cutscene.");
	
	settings.Add("prologuesplit", true, "Prologue Split");
	settings.SetToolTip("prologuesplit", "Split after the last prologue race with Razor.");
	
	settings.Add("safehousesplit", true, "Safe House Split");
	settings.SetToolTip("safehousesplit", "Split when you enter safe house for the first time after buying your starter car.");
	
	settings.Add("shopsplit", false, "Shop Split");
	settings.SetToolTip("shopsplit", "Split when you exit a car lot or an upgrade shop.");
	
	settings.Add("racesplit", true, "Race Split");
	settings.SetToolTip("racesplit", "Split when you win a race.");
	
	settings.Add("camerasplit", true, "Camera Split");
	settings.SetToolTip("camerasplit", "Split when completing a Speedtrap Milestone in free roam.");

	settings.Add("bosssplit", false, "Boss Split");
	settings.SetToolTip("bosssplit", "Split when defeating a boss by winning the last boss race. Does nothing if Race Split setting is also activated.");

	settings.Add("markersplit", false, "Marker Split");
	settings.SetToolTip("markersplit", "Split on the first loading screen after choosing markers.");

	settings.Add("copchasesplit", true, "Police Chase Split");
	settings.SetToolTip("copchasesplit", "Split when you escape a police chase.");
	
	settings.Add("bustedsplit", false, "Busted Split");
	settings.SetToolTip("bustedsplit", "Split after getting busted.");
	
	settings.Add("gameoversplit", false, "Game Over Split");
	settings.SetToolTip("gameoversplit", "Split when the game over screen appears. Intended to be used for Career Bad Ending category.");
	
	settings.Add("bridgejumpsplit", true, "Bridge Jump Split");
	settings.SetToolTip("bridgejumpsplit", "Split when you trigger the bridge jump cutscene.");
}

update 
{
	if (version == "") {
		return false;
	}
}

isLoading
{
	//Every normal loading screen
	if (current.loadingScreen1 == 32767 || current.loadingScreen2 == 24 || current.loadingScreen2 == 0 || current.gamestateID == 16) {
		return true;
	}
	//Special loading screen being: entering the safe house for the first time and entering free roam for the first time
	else if (current.gamestateID == 32) {
		//Exclude FMVs from being counted to loadless
		if (current.loadingScreen2 == 34) {
			return false;
		} else {
			return true;
		}
	} else {
		return false;
	}
}

start 
{
	//Quick race menu start
	if (version == "v1.2" && ((current.selectedMenu == 3 && current.start == 60 && old.start != current.start) || (current.selectedMenu == 3 && old.selectedMenu != current.selectedMenu))) {
		return true;
	} 
	//Direct career or challenege series start
	else if ((current.selectedMenu == 1 && old.inShop == 88 && current.inShop == 21) || (current.selectedMenu == 2 && current.loadingScreen2 == 24)) {
		return true;
	} else {
		return false;
	}
}

split
{
	//Split after first lap glitches
	if (version == "v1.2" && old.fmvName != current.fmvName && current.fmvName == "storyfmv_rac01" && settings["lapglitchsplit"]) {
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
	//Split when winning a race
	else if (current.raceState == 256 && old.raceState == 0 && current.onRace == 257 && settings["racesplit"]) {
		return true;
	}
	//Split when triggering a free roam camera
	else if (current.raceState == 256 && old.raceState == 0 && current.onRace != 257 && settings["camerasplit"]) {
		return true;
	}
	//Split when winning the last boss race
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
	else if (current.gameover == 10 && old.gameover != current.gameover && settings["gameoversplit"]) {
		return true;
	}
	//new split on final bridge jump NIS
	else if (old.nisName != current.nisName && current.nisName == "EndingNis04" && settings["bridgejumpsplit"]) {
		return true;
	} else {
		return false;
	}
}

exit
{
	timer.IsGameTimePaused = false;
}