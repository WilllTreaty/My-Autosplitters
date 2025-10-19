/*  Original Load Remover done by Mr.Mary and now added Autosplitter
    by TDOG20 and WillTreaty. At the current state this only works for 
	version 1.4, because its also the most stable version. */

state("NFSC")
{
    //Displays the current state in which the game is in
    int menuShit : 0x6980B8;
	
	//Changes when race starts at "go"
	int raceStart : 0x68B970;
	
	//Keeps track of race completion percentage
	float completion : 0x698284, 0x54;
	
	//Keeps track of completed race laps
	int raceLap : 0x6A256C, 0x64;
    
    //Displays the current fmv that is played
    string16 fmv : 0x697A88;

    //Displays the current NIS ID that is played
    string20 nisCutsceneID: 0x697AD0;

    //Displays if a race is finished (prevents splits when falling off the canyon)
    bool isFinished: 0x68A284;
	
	int loading: "NFSC.exe", 0x69970C, 0x0;
}

startup
{
    vars.loadValues = new List<int>{0, 34, 40, 33, 5, 3, 4, 35};
	
	vars.timerModel = new TimerModel { CurrentState = timer };
	
	settings.Add("quickracemode", false, "Quick Race Mode");
	settings.SetToolTip("quickracemode", "Handles starts, splits (in 20 intervals) and resets for quick race (IL) conditions.");
	
	settings.Add("circuitmode", false, "Circuit Mode", "quickracemode");
	settings.SetToolTip("circuitmode", "Handles IL splitter for circuit race type.");
	
    if (timer.CurrentTimingMethod == TimingMethod.RealTime) {
        var timingMessage = MessageBox.Show(
            "This game uses Time without Loads (Game Time) as the main timing method.\n"
            + "LiveSplit is currently set to show Real Time (RTA).\n"
            + "Would you like to set the timing method to Game Time?",
            "Need for Speed: Carbon | LiveSplit",
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
	if ((timer.CurrentPhase == TimerPhase.Ended || timer.CurrentPhase == TimerPhase.NotRunning) && settings["quickracemode"] && old.raceStart != current.raceStart && current.raceStart == 32767) {
		vars.timerModel.Reset();
	}
}

start
{
    //only works if its a savefile with no progress
    if(!settings["quickracemode"] && old.menuShit == 11 && current.menuShit == 0) {
        return true;
    } else if (settings["quickracemode"] && old.raceStart == 32767 && current.raceStart == 0) {
		return true;
	} else {
        return false;
    }
}

split
{
	if (!settings["quickracemode"]) {
		//Split for a finished race
		if(!old.isFinished && current.isFinished) {
			return true;
		}
		//Split for escaping Cross
		else if(current.nisCutsceneID == "ENDINGCAREER22" && old.nisCutsceneID != current.nisCutsceneID) {
			return true;
		}
		//Split for finishing the escape scene in the beginning of the game
		else if(current.nisCutsceneID == "ENDINGCAREER23NG" && old.nisCutsceneID != current.nisCutsceneID) {
			return true;
		}
		//Split for meeting Samson
		else if(current.fmv == "Seq06_SamsonFlas" && old.fmv != current.fmv) {
			return true;
		}
		//Split for meeting Yumi
		else if(current.fmv == "Seq08_YumiFlashb" && old.fmv != current.fmv) {
			return true;
		}
		//Split for meeting Colin
		else if(current.fmv == "Seq10_ColinFlash" && old.fmv != current.fmv) {
			return true;
		}
		//Split for meeting Darius
		else if(current.fmv == "Seq11_Reversal" && old.fmv != current.fmv) {
			return true;
		}
		else {
			return false;
		}
	} else if (settings["quickracemode"]) {
		if (!settings["circuitmode"] && (int)current.completion != (int)old.completion && (int)current.completion % 20 == 0 && (int)current.completion != 0) {
			return true;
		} else if (settings["circuitmode"] && current.raceLap != old.raceLap && current.raceLap == old.raceLap+1) {
			return true;
		} else {
			return false;
		}
	}
}

isLoading
{
    return vars.loadValues.Contains(current.menuShit) || current.loading != 0;
}

reset 
{
	if (settings["quickracemode"] && old.raceStart != current.raceStart && current.raceStart == 32767) {
		return true;
	} else {
		return false;
	}
}

exit
{
    timer.IsGameTimePaused = false;
}