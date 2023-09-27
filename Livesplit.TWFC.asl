/*
 *	Autosplitter and Loadless Remover done by Failracer, KC and WillTreaty
 */

state("TWFC")
{
	int state : "TWFC.exe", 0x021108C4, 0x5D4;
	bool Loading : "TWFC.exe", 0x0226F3FC, 0x3c, 0x1B4, 0x28, 0x130, 0x770;
	int loadId: "TWFC.exe", 0x02210968, 0x538, 0x88;
	string14 map: "TWFC.exe", 0x02246BEC, 0x9;
	int checkpoint: "TWFC.exe", 0x02246BEC, 0x48;
	int cutscene : "TWFC.exe", 0x02210A78, 0x8, 0x0, 0x4, 0x20;
	int omegasupreme: "TWFC.exe", 0x02242A4C, 0x54, 0x2C, 0x68, 0x974;
	int trypticon: "TWFC.exe", 0x02242A4C, 0x20, 0x2C, 0x3DC, 0x7C, 0x94, 0x8BC; 
}

startup
{
	vars.notSplitCheckpoints = new List<int>{1882469686, 1342190386, 1882535992, 3289654, 960049713, 875575352, 892548153, 842281267, 1882732341, 892614708, 943272500, 55, 1882470450, 1882470457, 1882207284, 1882338353, 1882338096};
	vars.stopTimer = false;

	settings.Add("onlychaptersplit", false, "Only Chapter Splits");
	settings.SetToolTip("onlychaptersplit", "Autosplitter only splits at end of each chapter instead of doing at every new checkpoint as well.");

	settings.Add("undosplit", false, "Undo Split if aftertime death happens");
	settings.SetToolTip("undosplit", "Autosplitter undo's a split once if runner dies after finishing either Omega Supreme boss fight at Ch5 or Trypticon boss fight at Ch10.");
	vars.TimerModel = new TimerModel { CurrentState = timer };
	
	vars.splitsCheckpointId = new Dictionary<int, string>();
	vars.splitsMapName = new Dictionary<string, string>();

	Action<string, string, string, int, string> AddSplit = (chapter, splitId, splitDescription, checkpoint, mapName) => {
		splitId = chapter + "." + splitId;
		
		vars.splitsCheckpointId.Add(checkpoint, splitId);
		vars.splitsMapName.Add(splitId, mapName);

		settings.Add(splitId, true, splitDescription, chapter);	
	};
	
	settings.Add("splits", true, "Checkpoint Splits");
	
	settings.Add("chapter1", true, "Chapter 1 Splits", "splits");
	AddSplit("chapter1", "strongsurvive", "The strong survive. The weak perish", 1882272563, "d1_orb_base_mA");
	AddSplit("chapter1", "barrelrolls", "Barrel Rolls", 926168626, "d1_orb_base_mA");
	AddSplit("chapter1", "prelab", "Pre-Lab", 876032309, "d1_orb_base_mA");
	AddSplit("chapter1", "labskip", "Lab Skip", 1882533940, "d1_orb_base_mA");
	AddSplit("chapter1", "postlab", "Post-Lab", 926038066, "d1_orb_base_mA");
	AddSplit("chapter1", "stophim", "Stop him!", 1342191412, "d1_orb_base_mA");
	AddSplit("chapter1", "toolate", "You're too late!", 1882666034, "d1_orb_base_mA");
	settings.Add("chapter1.dealingwithstarscream", true, "I shall deal with starscream", "chapter1");
	
	settings.Add("chapter2", true, "Chapter 2 Splits", "splits");
	AddSplit("chapter2", "boringthundercracker", "Boring Thundercracker", 1882337584, "d2_cor_base_mA");
	AddSplit("chapter2", "stupidautobots", "Stupid Autobots", 858927157, "d2_cor_base_mA");
	AddSplit("chapter2", "stupidtricks", "And their stupid tricks", 1882797364, "d2_cor_base_mA");
	AddSplit("chapter2", "murderspreeskip", "Murder Spree Skip", 1882470198, "d2_cor_base_mA");
	AddSplit("chapter2", "ship", "Ship", 909324592, "d2_cor_base_mA");
	AddSplit("chapter2", "oobcp1", "OOB CP1", 1882796595, "d2_cor_base_mA");
	AddSplit("chapter2", "oobcp2", "OOB CP2", 1882798387, "d2_cor_base_mA");
	AddSplit("chapter2", "tururu", "Tururu", 943271988, "d2_cor_base_mA");
	AddSplit("chapter2", "cloakers", "Cloakers", 1882207798, "d2_cor_base_mA");
	AddSplit("chapter2", "snipertunnel", "Sniper Tunnel", 959461169, "d2_cor_base_mA");
	AddSplit("chapter2", "button", "Button", 1882404404, "d2_cor_base_mA");
	AddSplit("chapter2", "oobrr", "OOBrr", 875574579, "d2_cor_base_mA");
	AddSplit("chapter2", "detpack", "Detpack", 1882666549, "d2_cor_base_mA");
	settings.Add("chapter2.energonbridgeconnected", true, "Energon Bridge Connected", "chapter2");
	
	settings.Add("chapter3", true, "Chapter 3 Splits", "splits");
	AddSplit("chapter3", "fight", "Fight", 3552819, "d3a_iac_base_m");
	AddSplit("chapter3", "loadzone", "Load Zone", 926430002, "d3a_iac_base_m");
	AddSplit("chapter3", "sg", "SG", 942749749, "d3a_iac_base_m");
	AddSplit("chapter3", "galleriesskip", "Galleries Skip", 876098865, "d3a_iac_base_m");
	AddSplit("chapter3", "subwayentrance", "Subway Entrance", 808596280, "d3a_iac_base_m");
	AddSplit("chapter3", "subwayskip", "Subway Skip", 808529969, "d3a_iac_base_m");
	AddSplit("chapter3", "aerialbotsfight", "Aerialbots Fight", 942880049, "d3a_iac_base_m");
	AddSplit("chapter3", "warcrimesskip", "War Crimes Skip", 892612665, "d3a_iac_base_m");
	AddSplit("chapter3", "guncontrols", "Gun Controls", 926233649, "d3a_iac_base_m");
	AddSplit("chapter3", "request", "Request", 892547633, "d3a_iac_base_m");
	AddSplit("chapter3", "snipers", "Snipers", 842478641, "d3a_iac_base_m");
	AddSplit("chapter3", "roof", "Roof", 909260593, "d3a_iac_base_m");
	AddSplit("chapter3", "unskippablewarcrimes", "Unskippable War Crimes", 875575352, "d3a_iac_base_m");
	AddSplit("chapter3", "stomp", "Stomp", 959919409, "d3a_iac_base_m");
	AddSplit("chapter3", "megsskip", "Megs Skip", 943207729, "d3a_iac_base_m");
	AddSplit("chapter3", "zeta1", "Zeta 1", 909718577, "d3a_iac_base_m");
	AddSplit("chapter3", "zeta2", "Zeta 2", 892481585, "d3a_iac_base_m");
	settings.Add("chapter3.zeta3", true, "Zeta 3", "chapter3");
	
	settings.Add("chapter4", true, "Chapter 4 Splits", "splits");
	AddSplit("chapter4", "omegakey", "Here goes your Omega key", 926233906, "d3b_iac_base_m");
	AddSplit("chapter4", "tooquiet", "Too quiet", 875575090, "d3b_iac_base_m");
	AddSplit("chapter4", "starscreamtalks", "Starscream talks", 926364977, "d3b_iac_base_m");
	AddSplit("chapter4", "cargoelevator", "Cargo Elevator", 808857905, "d3b_iac_base_m");
	AddSplit("chapter4", "withrespect", "With all due respect", 808858161, "d3b_iac_base_m");
	AddSplit("chapter4", "entercontroldome", "Enter Control Dome", 858929459, "d3b_iac_base_m");
	AddSplit("chapter4", "controldome1", "Control Dome 1", 892614450, "d3b_iac_base_m");
	AddSplit("chapter4", "controldome2", "Control Dome 2", 842610227, "d3b_iac_base_m");
	AddSplit("chapter4", "mineride", "Mine Ride", 959460913, "d3b_iac_base_m");
	AddSplit("chapter4", "heavyresistance", "Heavy Resistance", 909588275, "d3b_iac_base_m");
	AddSplit("chapter4", "hr2", "HR 2", 859254833, "d3b_iac_base_m");
	AddSplit("chapter4", "intomaintenancetunnels", "Into Maintenance Tunnels", 943076145, "d3b_iac_base_m");
	AddSplit("chapter4", "driveharder", "Drive harder", 842347825, "d3b_iac_base_m");
	AddSplit("chapter4", "maintenancetunnels", "Maintenance Tunnels", 959656241, "d3b_iac_base_m");
	AddSplit("chapter4", "cloakersskip", "Cloakers Skip", 825637172, "d3b_iac_base_m");
	AddSplit("chapter4", "gasgasgas", "Gas Gas Gas", 825570353, "d3b_iac_base_m");
	AddSplit("chapter4", "ohlook", "Oh look", 3618871, "d3b_iac_base_m");
	AddSplit("chapter4", "elevatorride", "Elevator Ride", 825700657, "d3b_iac_base_m");
	AddSplit("chapter4", "mantheturrets", "Man the turrets", 825570609, "d3b_iac_base_m");
	AddSplit("chapter4", "omegasupreme1", "Omega Supreme 1", 892876594, "d3b_iac_base_m");
	settings.Add("chapter4.omegasupreme2", true, "Omega Supreme 2", "chapter4");
	
	settings.Add("chapter5", true, "Chapter 5 Splits", "splits");
	AddSplit("chapter5", "omegasupreme1", "Omega Supreme 1", 925972784, "d5_ome_base_mA");
	settings.Add("chapter5.omegasupreme2", true, "Omega Supreme 2", "chapter5");
	
	settings.Add("chapter6", true, "Chapter 6 Splits", "splits");
	AddSplit("chapter6", "ship", "Ship", 1342190903, "a1_iac_base_mA");
	AddSplit("chapter6", "door", "Door", 1882338866, "a1_iac_base_mA");
	AddSplit("chapter6", "speedwayskip1", "Speedway Skip 1", 1882404920, "a1_iac_base_mA");
	AddSplit("chapter6", "falsepropagand1", "False Propaganda 1", 909326642, "a1_iac_base_mA");
	AddSplit("chapter6", "falsepropagand2", "False Propaganda 2", 1882272048, "a1_iac_base_mA");
	AddSplit("chapter6", "corruptedhallways", "Corrupted Hallways", 1882534457, "a1_iac_base_mA");
	AddSplit("chapter6", "crawler1skip", "Crawler 1 Skip", 1882468406, "a1_iac_base_mA");
	AddSplit("chapter6", "speedway2", "Speedway 2", 825440562, "a1_iac_base_mA");
	AddSplit("chapter6", "crawler2", "Crawler 2", 892483893, "a1_iac_base_mA");
	AddSplit("chapter6", "cvs1", "Central Ventilation System 1", 1882601011, "a1_iac_base_mA");
	AddSplit("chapter6", "cvs2", "Central Ventilation System 2", 1882534450, "a1_iac_base_mA");
	AddSplit("chapter6", "decagonapproach", "Decagon Approach", 825307952, "a1_iac_base_mA");
	AddSplit("chapter6", "decagonskip1", "Decagon Skip 1", 809054257, "a1_iac_base_mA");
	AddSplit("chapter6", "ctf1", "Comm Tower Floor 2", 1342190128, "a1_iac_base_mA");
	AddSplit("chapter6", "starscreamstart", "Starscream Fight Start", 1882469429, "a1_iac_base_mA");
	settings.Add("chapter6.starscreamend", true, "Starscream Fight End", "chapter6");
	
	settings.Add("chapter7", true, "Chapter 7 Splits", "splits");
	AddSplit("chapter7", "cutscene", "Cutscene", 926431028, "a2_kon_base_mA");
	AddSplit("chapter7", "fight1", "Fight 1", 809055538, "a2_kon_base_mA");
	AddSplit("chapter7", "fight2", "Fight 2", 825634864, "a2_kon_base_mA");
	AddSplit("chapter7", "courtyardbutton", "Courtyard Button", 1342189619, "a2_kon_base_mA");
	AddSplit("chapter7", "courtyardcrawler", "Courtyard Crawler", 909128502, "a2_kon_base_mA");
	AddSplit("chapter7", "courtyardcrawlerskip", "Courtyard Crawler Skip", 1882797369, "a2_kon_base_mA");
	AddSplit("chapter7", "wave1", "Wave 1", 1882535473, "a2_kon_base_mA");
	AddSplit("chapter7", "wave2", "Wave 2", 825767730, "a2_kon_base_mA");
	AddSplit("chapter7", "captured", "Captured", 1882535222, "a2_kon_base_mA");
	AddSplit("chapter7", "getout", "Get out", 926169140, "a2_kon_base_mA");
	AddSplit("chapter7", "dungeons3", "Dungeons 3", 1882470199, "a2_kon_base_mA");
	AddSplit("chapter7", "hole", "Hole", 909718068, "a2_kon_base_mA");
	AddSplit("chapter7", "sewer", "Sewer", 1882206775, "a2_kon_base_mA");
	AddSplit("chapter7", "airraidandcontrolroom", "Airraid+Control Room", 875967794, "a2_kon_base_mA");
	AddSplit("chapter7", "hangarsandcrawler2", "Hangars+Crawler 2 Skip", 959788851, "a2_kon_base_mA");
	AddSplit("chapter7", "finalapproach1", "Final Approach 1", 892351796, "a2_kon_base_mA");
	AddSplit("chapter7", "finalapproach2", "Final Approach 2", 892875062, "a2_kon_base_mA");
	AddSplit("chapter7", "finalapproach3", "Final Approach 3", 1882470713, "a2_kon_base_mA");
	AddSplit("chapter7", "soundwave", "Soundwave", 892483379, "a2_kon_base_mA");
	AddSplit("chapter7", "frenzy", "Frenzy", 1882796343, "a2_kon_base_mA");
	AddSplit("chapter7", "rumble", "Rumble", 1882208053, "a2_kon_base_mA");
	settings.Add("chapter7.laserbeak", true, "Laserbeak", "chapter7");
	
	settings.Add("chapter8", true, "Chapter 8 Splits", "splits");
	AddSplit("chapter8", "powercores", "Power Cores", 943143219, "a3_cor_base_mA");
	AddSplit("chapter8", "cloakersfight", "Cloakers Fight", 808924724, "a3_cor_base_mA");
	AddSplit("chapter8", "omegarestaints", "Omega Restaints", 1882796344, "a3_cor_base_mA");
	AddSplit("chapter8", "omegasupremeskip", "Omega Supreme Defense Skip", 875704885, "a3_cor_base_mA");
	AddSplit("chapter8", "preslug", "Pre-slug", 1342190905, "a3_cor_base_mA");
	AddSplit("chapter8", "preslugskip", "Pre-slug Skip", 1882339129, "a3_cor_base_mA");
	AddSplit("chapter8", "slugs1", "Slugs 1", 875770931, "a3_cor_base_mA");
	AddSplit("chapter8", "slugs2", "Slugs 2", 943141682, "a3_cor_base_mA");
	AddSplit("chapter8", "slugs3", "Slugs 3", 1882667059, "a3_cor_base_mA");
	AddSplit("chapter8", "slugs4", "Slugs 4", 1882470710, "a3_cor_base_mA");
	AddSplit("chapter8", "floodgatesskip", "Floodgates Skip", 859060274, "a3_cor_base_mA");
	AddSplit("chapter8", "seaofcorruption", "Sea Of Corruption", 1882337329, "a3_cor_base_mA");
	AddSplit("chapter8", "bossfight1", "Bossfight 1", 859256369, "a3_cor_base_mA");
	settings.Add("chapter8.bossfight2", true, "Bossfight 2", "chapter8");
	
	settings.Add("chapter9", true, "Chapter 9 Splits", "splits");
	AddSplit("chapter9", "stationapproach", "Station Approach", 959526964, "a4_orb_base_mA");
	AddSplit("chapter9", "reliablebarriers", "Reliable Barriers", 943141169, "a4_orb_base_mA");
	AddSplit("chapter9", "coolantcontrolroom", "Coolant Control Room", 1882666802, "a4_orb_base_mA");
	AddSplit("chapter9", "controlroomwave2", "Control Room Wave 2", 1882534968, "a4_orb_base_mA");
	AddSplit("chapter9", "coolanttunnels", "Coolant Tunnels", 808530996, "a4_orb_base_mA");
	AddSplit("chapter9", "button", "Button", 926363701, "a4_orb_base_mA");
	AddSplit("chapter9", "destroyerskip", "Destroyer Skip", 1882470457, "a4_orb_base_mA");
	AddSplit("chapter9", "damageplasmacore", "Damage Plasma Core", 1882272053, "a4_orb_base_mA");
	AddSplit("chapter9", "90", "90%", 1882600497, "a4_orb_base_mA");
	AddSplit("chapter9", "starttrypticonapproach", "Start Trypticon Approach", 909129522, "a4_orb_base_mA");
	AddSplit("chapter9", "finishtrypticonapproach", "Finish Trypticon Approach", 1882470197, "a4_orb_base_mA");
	AddSplit("chapter9", "destroyer1", "Destroyer 1", 1882533938, "a4_orb_base_mA");
	AddSplit("chapter9", "destroyer2", "Destroyer 2", 1882797362, "a4_orb_base_mA");
	AddSplit("chapter9", "conversioncogskip", "Conversion Cog Skip", 926167091, "a4_orb_base_mA");
	settings.Add("chapter9.trypticon", true, "Trypticon", "chapter9");
	
	settings.Add("chapter10", true, "Chapter 10 Splits", "splits");
	AddSplit("chapter10", "trypticon1and2", "Trypticon 1+2", 1882206769, "a5_try_base_mA");
	settings.Add("chapter10.trypticon3", true, "Trypticon 3", "chapter10");
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

	if ((old.loadId == 16 || old.loadId == 15) && current.loadId == 0) {
		vars.stopTimer = false;
	}
}

split
{
	if (!settings["onlychaptersplit"]) {
		//omega
		if (settings["chapter5.omegasupreme2"] && current.map == "d5_ome_base_mA" && current.omegasupreme == 3 && old.omegasupreme != current.omegasupreme && current.state == 632) {
			return true;
		}
		//trypticon
		else if (settings["chapter10.trypticon3"] && current.map == "a5_try_base_mA" && current.trypticon == 0 && old.trypticon != current.trypticon && current.state == 632) {
			return true;
		}
		//chapter endings
		else if (settings["chapter1.dealingwithstarscream"] && old.map == "d1_orb_base_mA" && old.map != current.map) {
			return true;
		} else if (settings["chapter2.energonbridgeconnected"] && old.map == "d2_cor_base_mA" && old.map != current.map) {
			return true;
		} else if (settings["chapter3.zeta3"] && old.map == "d3a_iac_base_m" && old.map != current.map) {
			return true;
		} else if (settings["chapter4.omegasupreme2"] && old.map == "d3b_iac_base_m" && old.map != current.map) {
			return true;
		} else if (settings["chapter6.starscreamend"] && old.map == "a1_iac_base_mA" && old.map != current.map) {
			return true;
		} else if (settings["chapter7.laserbeak"] && old.map == "a2_kon_base_mA" && old.map != current.map) {
			return true;
		} else if (settings["chapter8.bossfight2"] && old.map == "a3_cor_base_mA" && old.map != current.map) {
			return true;
		} else if (settings["chapter9.trypticon"] && old.map == "a4_orb_base_mA" && old.map != current.map) {
			return true;
		}
		//normal
		else if (timer.CurrentTime.GameTime.Value.TotalSeconds >= 1 && settings[vars.splitsCheckpointId[current.checkpoint]] && vars.splitsMapName[vars.splitsCheckpointId[current.checkpoint]] == current.map && current.cutscene == 0 && old.checkpoint != current.checkpoint && old.checkpoint != 0) {
			return true;
		} else {
			return false;
		}
	} else if (settings["onlychaptersplit"]) {
		//chapter ending
		if (current.state == 628 && old.map != 1597334542 && old.map != 1597333774 && current.cutscene != 0 && old.state != current.state && !vars.notSplitCheckpoints.Contains(current.checkpoint)) {
			return true;
		//omega
		} else if (current.map == 1597334542 && old.omegasupreme != current.omegasupreme && current.state == 632 && current.omegasupreme == 3) {
			return true;
		//trypticon
		} else if (current.map == 1597333774 && old.trypticon != current.trypticon && current.state == 632 && current.trypticon == 0) {
			return true;
		} else {
			return false;
		}
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
	if ((current.loadId == 16 || current.loadId == 2) && old.state == 530) {
		return true;
	} else {
		return false;
	}
}

isLoading
{
	return current.Loading || vars.stopTimer;
}

exit
{
	vars.stopTimer = true;
	timer.IsGameTimePaused = true;
}