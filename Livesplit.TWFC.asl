/*
 *	Autosplitter and Loadless Remover done by Failracer, KC and WillTreaty
 */

state("TWFC")
{
	int state : "TWFC.exe", 0x021108C4, 0x5D4;
	bool Loading : "TWFC.exe", 0x0226F3FC, 0x3C, 0x1B4, 0x28, 0x130, 0x770;
	int loadId: "TWFC.exe", 0x02210968, 0x538, 0x88;
	string14 map: "TWFC.exe", 0x02246BEC, 0x9;
	string60 checkpoint: "TWFC.exe", 0x02210968, 0x18C, 0x38, 0x2D;
	int cutscene : "TWFC.exe", 0x02210A78, 0x8, 0x0, 0x4, 0x20;
	int omegasupreme: "TWFC.exe", 0x02242A4C, 0x54, 0x2C, 0x68, 0x974;
	int trypticon: "TWFC.exe", 0x02242A4C, 0x20, 0x2C, 0x3DC, 0x7C, 0x94, 0x8BC; 
}

startup
{
	vars.Maps = new List<string>{"d1_orb_base_mA", "d2_cor_base_mA", "d3a_iac_base_m", "d3b_iac_base_m", "d5_ome_base_mA", "a1_iac_base_mA", "a2_kon_base_mA", "a3_cor_base_mA", "a4_orb_base_mA", "a5_try_base_mA"};
	
	settings.Add("ch7cutsceneskip", true, "Chapter 7 Cutscene Skip");
	settings.SetToolTip("ch7cutsceneskip", "Autosplitter allows you to skip in-game cutscene by reloading last checkpoint after you get past 2 previous movie ones and adds default time for the skipped cutscene and split if checkpoint splits are allowed.");

	settings.Add("onlychaptersplit", false, "Only Chapter Splits");
	settings.SetToolTip("onlychaptersplit", "Autosplitter only splits at end of each chapter instead of doing at every new checkpoint as well.");
	
	settings.Add("switchcampaignsplit", false, "Switch Between Campaigns Split");
	settings.SetToolTip("switchcampaignsplit", "Autosplitter will split when runner starts ch6, should be activated only for full campaign runs.");

	settings.Add("undosplit", false, "Undo Split if aftertime death happens");
	settings.SetToolTip("undosplit", "Autosplitter undo's a split once if runner dies after finishing either Omega Supreme boss fight at Ch5 or Trypticon boss fight at Ch10.");
	vars.TimerModel = new TimerModel { CurrentState = timer };
	
	vars.splitsCheckpointName = new Dictionary<string, string>();

	Action<string, string, string, string> AddSplit = (chapter, splitId, splitDescription, checkpoint) => {
		splitId = chapter + "." + splitId;
		
		vars.splitsCheckpointName.Add(checkpoint, splitId);

		settings.Add(splitId, true, splitDescription, chapter);	
	};
	
	settings.Add("splits", true, "Checkpoint Splits");
	
	settings.Add("chapter1", true, "Chapter 1 Splits", "splits");
	AddSplit("chapter1", "strongsurvive", "The strong survive. The weak perish", "1_orb_base_m.TheWorld:PersistentLevel.Checkpoint_7331");
	AddSplit("chapter1", "barrelrolls", "Barrel Rolls", "1_orb_base_m.TheWorld:PersistentLevel.Checkpoint_12647");
	AddSplit("chapter1", "prelab", "Pre-Lab", "1_orb_base_m.TheWorld:PersistentLevel.Checkpoint_15174");
	AddSplit("chapter1", "postlab", "Post-Lab", "1_orb_base_m.TheWorld:PersistentLevel.Checkpoint_12827");
	AddSplit("chapter1", "stophim", "Stop him!", "1_orb_base_m.TheWorld:PersistentLevel.Checkpoint_847");
	AddSplit("chapter1", "toolate", "You're too late!", "1_orb_base_m.TheWorld:PersistentLevel.Checkpoint_3247");
	settings.Add("chapter1.dealingwithstarscream", true, "I shall deal with starscream", "chapter1");
	
	settings.Add("chapter2", true, "Chapter 2 Splits", "splits");
	AddSplit("chapter2", "boringthundercracker", "Boring Thundercracker", "2_cor_base_m.TheWorld:PersistentLevel.Checkpoint_2012");
	AddSplit("chapter2", "stupidautobots", "Stupid Autobots", "2_cor_base_m.TheWorld:PersistentLevel.Checkpoint_15023");
	AddSplit("chapter2", "stupidtricks", "And their stupid tricks", "2_cor_base_m.TheWorld:PersistentLevel.Checkpoint_2459");
	AddSplit("chapter2", "ship", "Ship", "2_cor_base_m.TheWorld:PersistentLevel.Checkpoint_10136");
	AddSplit("chapter2", "oobcp1", "OOB CP1", "2_cor_base_m.TheWorld:PersistentLevel.Checkpoint_3329");
	AddSplit("chapter2", "tururu", "Tururu", "2_cor_base_m.TheWorld:PersistentLevel.Checkpoint_14098");
	AddSplit("chapter2", "cloakers", "Cloakers", "2_cor_base_m.TheWorld:PersistentLevel.Checkpoint_5660");
	AddSplit("chapter2", "snipertunnel", "Sniper Tunnel", "2_cor_base_m.TheWorld:PersistentLevel.Checkpoint_11709");
	AddSplit("chapter2", "button", "Button", "2_cor_base_m.TheWorld:PersistentLevel.Checkpoint_6463");
	AddSplit("chapter2", "detpack", "Detpack", "2_cor_base_m.TheWorld:PersistentLevel.Checkpoint_8567");
	settings.Add("chapter2.energonbridgeconnected", true, "Energon Bridge Connected", "chapter2");
	
	settings.Add("chapter3", true, "Chapter 3 Splits", "splits");
	AddSplit("chapter3", "fight", "Fight", "7d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_366");
	AddSplit("chapter3", "loadzone", "Load Zone", "8d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_2387");
	AddSplit("chapter3", "sg", "SG", "8d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_5818");
	AddSplit("chapter3", "galleriesskip", "Galleries Skip", "9d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_15843");
	AddSplit("chapter3", "subwayentrance", "Subway Entrance", "8d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_8320");
	AddSplit("chapter3", "subwayskip", "Subway Skip", "8d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_1010");
	AddSplit("chapter3", "warcrimesskip", "War Crimes Skip", "8d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_9045");
	AddSplit("chapter3", "guncontrols", "Gun Controls", "9d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_14579");
	AddSplit("chapter3", "request", "Request", "9d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_12356");
	AddSplit("chapter3", "snipers", "Snipers", "9d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_14728");
	AddSplit("chapter3", "roof", "Roof", "8d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_1726");
	AddSplit("chapter3", "unskippablewarcrimes", "Unskippable War Crimes", "8d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_8804");
	AddSplit("chapter3", "megsskip", "Megs Skip", "8d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_1588");
	AddSplit("chapter3", "zeta1", "Zeta 1", "9d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_14964");
	AddSplit("chapter3", "zeta2", "Zeta 2", "9d3a_iac_base_m.TheWorld:PersistentLevel.Checkpoint_10254");
	settings.Add("chapter3.zeta3", true, "Zeta 3", "chapter3");
	
	settings.Add("chapter4", true, "Chapter 4 Splits", "splits");
	AddSplit("chapter4", "omegakey", "Here goes your Omega key", "8d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_2557");
	AddSplit("chapter4", "tooquiet", "Too quiet", "8d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_2704");
	AddSplit("chapter4", "cargoelevator", "Cargo Elevator", "9d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_11601");
	AddSplit("chapter4", "withrespect", "With all due respect", "9d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_12608");
	AddSplit("chapter4", "entercontroldome", "Enter Control Dome", "8d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_3923");
	AddSplit("chapter4", "controldome1", "Control Dome 1", "8d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_2745");
	AddSplit("chapter4", "controldome2", "Control Dome 2", "8d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_3692");
	AddSplit("chapter4", "mineride", "Mine Ride", "9d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_16096");
	AddSplit("chapter4", "heavyresistance", "Heavy Resistance", "9d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_10731");
	AddSplit("chapter4", "intomaintenancetunnels", "Into Maintenance Tunnels", "9d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_13683");
	AddSplit("chapter4", "maintenancetunnels", "Maintenance Tunnels", "9d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_11398");
	AddSplit("chapter4", "cloakersskip", "Cloakers Skip", "8d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_4961");
	AddSplit("chapter4", "gasgasgas", "Gas Gas Gas", "9d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_14518");
	AddSplit("chapter4", "ohlook", "Oh look", "7d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_787");
	AddSplit("chapter4", "mantheturrets", "Man the turrets", "9d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_15514");
	AddSplit("chapter4", "omegasupreme1", "Omega Supreme 1", "8d3b_iac_base_m.TheWorld:PersistentLevel.Checkpoint_2785");
	settings.Add("chapter4.omegasupreme2", true, "Omega Supreme 2", "chapter4");
	
	settings.Add("chapter5", true, "Chapter 5 Splits", "splits");
	AddSplit("chapter5", "omegasupreme1", "Omega Supreme 1", "5_ome_base_m.TheWorld:PersistentLevel.Checkpoint_10917");
	settings.Add("chapter5.omegasupreme2", true, "Omega Supreme 2", "chapter5");
	
	settings.Add("chapter6", true, "Chapter 6 Splits", "splits");
	AddSplit("chapter6", "ship", "Ship", "1_iac_base_m.TheWorld:PersistentLevel.Checkpoint_275");
	AddSplit("chapter6", "door", "Door", "1_iac_base_m.TheWorld:PersistentLevel.Checkpoint_6262");
	AddSplit("chapter6", "speedwayskip1", "Speedway Skip 1", "1_iac_base_m.TheWorld:PersistentLevel.Checkpoint_4883");
	AddSplit("chapter6", "speedwayskip2", "Speedway Skip 2", "1_iac_base_m.TheWorld:PersistentLevel.Checkpoint_12931");
	AddSplit("chapter6", "crawler2", "Crawler 2", "1_iac_base_m.TheWorld:PersistentLevel.Checkpoint_15925");
	AddSplit("chapter6", "cvs2", "Central Ventilation System 2", "1_iac_base_m.TheWorld:PersistentLevel.Checkpoint_9225");
	AddSplit("chapter6", "decagonapproach", "Decagon Approach", "1_iac_base_m.TheWorld:PersistentLevel.Checkpoint_10311");
	AddSplit("chapter6", "decagonskip1", "Decagon Skip 1", "1_iac_base_m.TheWorld:PersistentLevel.Checkpoint_11090");
	AddSplit("chapter6", "ctf2", "Comm Tower Floor 2", "1_iac_base_m.TheWorld:PersistentLevel.Checkpoint_502");
	AddSplit("chapter6", "starscreamstart", "Starscream Fight Start", "1_iac_base_m.TheWorld:PersistentLevel.Checkpoint_3544");
	settings.Add("chapter6.starscreamend", true, "Starscream Fight End", "chapter6");
	
	settings.Add("chapter7", true, "Chapter 7 Splits", "splits");
	AddSplit("chapter7", "cutscene", "Cutscene", "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_14787");
	AddSplit("chapter7", "fight1", "Fight 1", "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_12590");
	AddSplit("chapter7", "courtyardbutton", "Courtyard Button", "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_630");
	AddSplit("chapter7", "courtyardcrawlerskip", "Courtyard Crawler Skip", "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_6959");
	AddSplit("chapter7", "wave1", "Wave 1", "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_4165");
	AddSplit("chapter7", "wave2", "Wave 2", "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_12781");
	AddSplit("chapter7", "captured", "Captured", "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_3655");
	AddSplit("chapter7", "getout", "Get out", "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_14847");
	AddSplit("chapter7", "hole", "Hole", "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_14296");
	AddSplit("chapter7", "airraidandcontrolroom", "Airraid+Control Room", "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_12564");
	AddSplit("chapter7", "hangarsandcrawler2", "Hangars+Crawler 2 Skip", "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_13759");
	AddSplit("chapter7", "soundwave", "Soundwave", "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_13725");
	AddSplit("chapter7", "frenzy", "Frenzy", "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_3719");
	AddSplit("chapter7", "rumble", "Rumble", "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_7570");
	settings.Add("chapter7.laserbeak", true, "Laserbeak", "chapter7");
	
	settings.Add("chapter8", true, "Chapter 8 Splits", "splits");
	AddSplit("chapter8", "powercores", "Power Cores", "3_cor_base_m.TheWorld:PersistentLevel.Checkpoint_13978");
	AddSplit("chapter8", "cloakersfight", "Cloakers Fight", "3_cor_base_m.TheWorld:PersistentLevel.Checkpoint_14670");
	AddSplit("chapter8", "omegarestraints", "Omega Restraints", "3_cor_base_m.TheWorld:PersistentLevel.Checkpoint_8819");
	AddSplit("chapter8", "omegasupremeskip", "Omega Supreme Defense Skip", "3_cor_base_m.TheWorld:PersistentLevel.Checkpoint_15224");
	AddSplit("chapter8", "preslug", "Pre-slug", "3_cor_base_m.TheWorld:PersistentLevel.Checkpoint_595");
	AddSplit("chapter8", "preslugskip", "Pre-slug Skip", "3_cor_base_m.TheWorld:PersistentLevel.Checkpoint_5972");
	AddSplit("chapter8", "autoscroller", "Autoscroller", "3_cor_base_m.TheWorld:PersistentLevel.Checkpoint_6694");
	AddSplit("chapter8", "floodgatesskip", "Floodgates Skip", "3_cor_base_m.TheWorld:PersistentLevel.Checkpoint_12843");
	AddSplit("chapter8", "seaofcorruption", "Sea Of Corruption", "3_cor_base_m.TheWorld:PersistentLevel.Checkpoint_2102");
	AddSplit("chapter8", "bossfight1", "Bossfight 1", "3_cor_base_m.TheWorld:PersistentLevel.Checkpoint_11673");
	settings.Add("chapter8.bossfight2", true, "Bossfight 2", "chapter8");
	
	settings.Add("chapter9", true, "Chapter 9 Splits", "splits");
	AddSplit("chapter9", "stationapproach", "Station Approach", "4_orb_base_m.TheWorld:PersistentLevel.Checkpoint_14819");
	AddSplit("chapter9", "reliablebarriers", "Reliable Barriers", "4_orb_base_m.TheWorld:PersistentLevel.Checkpoint_11178");
	AddSplit("chapter9", "coolantcontrolroom", "Coolant Control Room", "4_orb_base_m.TheWorld:PersistentLevel.Checkpoint_6277");
	AddSplit("chapter9", "controlroomwave2", "Control Room Wave 2", "4_orb_base_m.TheWorld:PersistentLevel.Checkpoint_7845");
	AddSplit("chapter9", "coolanttunnels", "Coolant Tunnels", "4_orb_base_m.TheWorld:PersistentLevel.Checkpoint_14410");
	AddSplit("chapter9", "button", "Button", "4_orb_base_m.TheWorld:PersistentLevel.Checkpoint_15077");
	AddSplit("chapter9", "90", "90%", "4_orb_base_m.TheWorld:PersistentLevel.Checkpoint_2146");
	AddSplit("chapter9", "starttrypticonapproach", "Start Trypticon Approach", "4_orb_base_m.TheWorld:PersistentLevel.Checkpoint_12706");
	AddSplit("chapter9", "finishtrypticonapproach", "Finish Trypticon Approach", "4_orb_base_m.TheWorld:PersistentLevel.Checkpoint_7574");
	AddSplit("chapter9", "destroyerfightcomplete", "Destroyer Fight Complete", "4_orb_base_m.TheWorld:PersistentLevel.Checkpoint_5259");
	AddSplit("chapter9", "conversioncogskip", "Conversion Cog Skip", "4_orb_base_m.TheWorld:PersistentLevel.Checkpoint_13047");
	settings.Add("chapter9.trypticon", true, "Trypticon", "chapter9");
	
	settings.Add("chapter10", true, "Chapter 10 Splits", "splits");
	AddSplit("chapter10", "trypticon1", "Trypticon 1", "5_try_base_m.TheWorld:PersistentLevel.Checkpoint_3120");
	settings.Add("chapter10.trypticon2", true, "Trypticon 2", "chapter10");
	
    if (timer.CurrentTimingMethod == TimingMethod.RealTime) {
        var timingMessage = MessageBox.Show(
            "This game uses Load Removed Time (Game Time) as the main timing method.\n"
            + "LiveSplit is currently set to show Real Time (RTA).\n"
            + "Would you like to set the timing method to Game Time?",
            "Transformers: War for Cybertron | LiveSplit",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }	
}

init
{
	vars.doneCheckpointSplits = new List<string>{};
	vars.stopTimer = false;
	vars.loadedTime = 0;
	vars.ch7cutscenepause = false;
}

update
{	
	if (settings["undosplit"] && current.state == 622 && old.state != current.state) {
		if (current.map == "d5_ome_base_mA" && current.omegasupreme == 3) {
			vars.TimerModel.UndoSplit();
		} else if (current.map == "a5_try_base_mA" && current.trypticon == 0) {
			vars.TimerModel.UndoSplit();
		}
	}

	if ((old.loadId == 16 || old.loadId == 15) && current.loadId == 0) {
		vars.stopTimer = false;
	}
	
	if (settings["ch7cutsceneskip"]) {
		IntPtr temp;
		new DeepPointer("TWFC.exe", 0x02210968, 0x18C, 0x38, 0x2D).DerefOffsets(game, out temp);
		vars.cpPtr = temp;
		
		if (timer.CurrentPhase == TimerPhase.Running && current.map == "a2_kon_base_mA" && current.checkpoint == "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_14298" && !current.Loading) {
			vars.ch7cutscenepause = true;
			if (timer.CurrentSplitIndex > 0) {
				vars.loadedTime = timer.CurrentTime.GameTime;
			} else {
				vars.loadedTime = TimeSpan.Zero;
			}
			game.WriteBytes((IntPtr)vars.cpPtr, Encoding.ASCII.GetBytes("2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_14787"));
		}
	}
}

gameTime
{
    if (vars.ch7cutscenepause) {
		timer.IsGameTimePaused = true;
		return vars.loadedTime;
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
		else if (settings["chapter10.trypticon2"] && current.map == "a5_try_base_mA" && current.trypticon == 0 && old.trypticon != current.trypticon && current.state == 632) {
			return true;
		}
		//chapter endings
		else if (settings["chapter1.dealingwithstarscream"] && old.map == "d1_orb_base_mA" && old.map != current.map && !vars.Maps.Contains(current.map) && current.cutscene != 0) {
			return true;
		} else if (settings["chapter2.energonbridgeconnected"] && old.map == "d2_cor_base_mA" && old.map != current.map && !vars.Maps.Contains(current.map) && current.cutscene != 0) {
			return true;
		} else if (settings["chapter3.zeta3"] && old.map == "d3a_iac_base_m" && old.map != current.map && !vars.Maps.Contains(current.map) && current.cutscene != 0) {
			return true;
		} else if (settings["chapter4.omegasupreme2"] && old.map == "d3b_iac_base_m" && old.map != current.map && !vars.Maps.Contains(current.map) && current.cutscene != 0) {
			return true;
		} else if (settings["chapter6.starscreamend"] && old.map == "a1_iac_base_mA" && old.map != current.map && !vars.Maps.Contains(current.map) && current.cutscene != 0) {
			return true;
		} else if (settings["chapter7.laserbeak"] && old.map == "a2_kon_base_mA" && old.map != current.map && !vars.Maps.Contains(current.map) && current.cutscene != 0) {
			return true;
		} else if (settings["chapter8.bossfight2"] && old.map == "a3_cor_base_mA" && old.map != current.map && !vars.Maps.Contains(current.map) && current.cutscene != 0) {
			return true;
		} else if (settings["chapter9.trypticon"] && old.map == "a4_orb_base_mA" && old.map != current.map && !vars.Maps.Contains(current.map) && current.cutscene != 0) {
			return true;
		}
		//switch between campaigns
		else if (timer.CurrentSplitIndex > 0 && settings["switchcampaignsplit"] && old.map != current.map && current.map == "a1_iac_base_mA") {
			return true;
		}
		//ch7 cutscene skip
		else if (settings["ch7cutsceneskip"] && current.map == "a2_kon_base_mA" && current.checkpoint == "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_14787" && current.cutscene == 0 && old.cutscene != current.cutscene && !vars.doneCheckpointSplits.Contains("2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_14787")) {
			timer.SetGameTime(timer.CurrentTime.GameTime + new TimeSpan(0, 0, 2, 57, 229));
			vars.ch7cutscenepause = false;
			vars.doneCheckpointSplits.Add("2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_14787");
			return true;
		}
		//normal
		else if (timer.CurrentTime.GameTime.Value.TotalSeconds >= 3 && settings[vars.splitsCheckpointName[current.checkpoint]] && current.cutscene == 0 && old.checkpoint != current.checkpoint && !vars.doneCheckpointSplits.Contains(current.checkpoint)) {
			vars.doneCheckpointSplits.Add(current.checkpoint);
			return true;
		} else {
			return false;
		}
	} else if (settings["onlychaptersplit"]) {
		//chapter ending
		if (old.map != "d5_ome_base_mA" && old.map != "a5_try_base_mA" && old.map != current.map && vars.Maps.Contains(old.map) && current.cutscene != 0) {
			return true;
		//omega
		} else if (current.map == "d5_ome_base_mA" && old.omegasupreme != current.omegasupreme && current.state == 632 && current.omegasupreme == 3) {
			return true;
		//trypticon
		} else if (current.map == "a5_try_base_mA" && old.trypticon != current.trypticon && current.state == 632 && current.trypticon == 0) {
			return true;
		} 
		//switch between campaigns
		else if (timer.CurrentSplitIndex > 0 && settings["switchcampaignsplit"] && old.map != current.map && current.map == "a1_iac_base_mA") {
			return true;
		}
		//ch7 cutscene skip
		else if (settings["ch7cutsceneskip"] && current.map == "a2_kon_base_mA" && current.checkpoint == "2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_14787" && current.cutscene == 0 && old.cutscene != current.cutscene && !vars.doneCheckpointSplits.Contains("2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_14787")) {
			timer.SetGameTime(timer.CurrentTime.GameTime + new TimeSpan(0, 0, 2, 57, 229));
			vars.ch7cutscenepause = false;
			vars.doneCheckpointSplits.Add("2_kon_base_m.TheWorld:PersistentLevel.Checkpoint_14787");
			return false;
		} else {
			return false;
		}
	}
}

start 
{
	if ((old.loadId == 16 || old.loadId == 15) && current.loadId == 0) {
		vars.doneCheckpointSplits = new List<string>{};
		vars.loadedTime = 0;
		vars.ch7cutscenepause = false;
		return true;
	} else {
		return false;
	}
}

reset
{
	if ((current.loadId == 16 || current.loadId == 2) && (old.state == 530 || old.state == 622)) {
		vars.doneCheckpointSplits = new List<string>{};
		vars.loadedTime = 0;
		vars.ch7cutscenepause = false;
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