/*
 *	Autosplitter and Loadless done by coyotl, Failracer and WillTreaty
 */

state("dirt")
{
	int eventComplete : "dirt.exe", 0x3017E4, 0x10, 0x124, 0x40, 0x44, 0x14, 0x270;
	float raceComplete : "dirt.exe", 0x811080, 0x30, 0x4, 0x244;
	string13 raceName : "dirt.exe", 0x79F3AC, 0x30, 0x18, 0x58, 0x34, 0x4, 0x8;
	int start : "dirt.exe", 0x627450, 0x86C;
	int raceStart : "dirt.exe", 0x813780, 0x30, 0x1C8;
	int raceLaps : "dirt.exe", 0x811080, 0x30, 0x4, 0x230;
	int completedLaps : "dirt.exe", 0x3017E4, 0x10, 0x3A4, 0x13C;
	string2 min : "dirt.exe", 0x27E27C, 0x2F8, 0x40, 0x8F4;
	string2 sec : "dirt.exe", 0x27E27C, 0x2F8, 0x40, 0x8FC;
	string2 msec : "dirt.exe", 0x27E27C, 0x2F8, 0x40, 0x904;
	string2 firstName : "dirt.exe", 0x38672550;
	string2 secondName : "dirt.exe", 0x386725B0;
	string2 thirdName : "dirt.exe", 0x38672610;
	string8 firstTime : "dirt.exe", 0x38672530;
	string8 secondTime : "dirt.exe", 0x38672591;
	string8 thirdTime : "dirt.exe", 0x386725F1;
	bool loading : "dirt.exe", 0x331DE0, 0xB38, 0x180, 0x0, 0x28, 0x70;
}

init
{
	vars.finalSplit = false;
}

startup
{
	vars.splitTimeStopwatch = new Stopwatch();

	settings.Add("onlyeventsplit", false, "Only Event Split");
	settings.SetToolTip("onlyeventsplit", "Split only when player finishes an event, final split is still automatic and at finish line.");

	settings.Add("ilmode", false, "IL Mode");
	settings.SetToolTip("ilmode", "Split, reset, autostart behaviors all changes to work with time trial race mode (in rally world menu) specifically. Splits when in-race checkpoints reached and game time comparison should be used. Should be activated ONLY during IL attempts.");
}

update
{
	if (old.raceName == "pikes_peak_bc" && current.raceName == "chula") {
		vars.finalSplit = true;
	}
}

start
{
	if (current.start == 1 && old.start != current.start) {
		return true;
	} else if (settings["ilmode"] && old.raceStart != current.raceStart && current.raceStart == 1) {
		return true;
	} else {
		return false;
	}
}

split
{
	if (settings["onlyeventsplit"]) {
		if (current.eventComplete == 0 && old.eventComplete != current.eventComplete && current.raceComplete == 30) {
			if (vars.finalSplit) {
				vars.finalSplit = false;
				return false;
			} else {
				return true;
			}
		} else if (vars.finalSplit && current.raceComplete == 30 && old.raceComplete != current.raceComplete) {
			return true;
		} else {
			return false;
		}
	} else if (settings["ilmode"]) {
		if (current.completedLaps < current.raceLaps && old.firstTime != current.firstTime && current.firstTime != "") {
			vars.splitTimeOffset = 0.31f;
			vars.splitTimeStopwatch.Restart();
		}

		if (current.completedLaps == current.raceLaps && old.completedLaps != current.completedLaps && current.completedLaps != 0) {
			timer.SetGameTime(TimeSpan.FromMilliseconds((Int32.Parse(current.min)*60000)+(Int32.Parse(current.sec)*1000)+(Int32.Parse(current.msec)*10)));
			return true;
		} else if (vars.splitTimeStopwatch.IsRunning && vars.splitTimeStopwatch.Elapsed.TotalSeconds >= vars.splitTimeOffset && current.firstName == "PL") {
			vars.splitTimeStopwatch.Reset();
			timer.SetGameTime(TimeSpan.FromMilliseconds((Int32.Parse(current.firstTime.Substring(0, 2))*60000)+(Int32.Parse(current.firstTime.Substring(3, 2))*1000)+(Int32.Parse(current.firstTime.Substring(5, 3).Substring(1, 2))*10)));
			return true;
		} else if (vars.splitTimeStopwatch.IsRunning && vars.splitTimeStopwatch.Elapsed.TotalSeconds >= vars.splitTimeOffset && current.firstName == "WR" && current.secondName == "PL") {
			vars.splitTimeStopwatch.Reset();
			timer.SetGameTime(TimeSpan.FromMilliseconds(((Int32.Parse(current.firstTime.Substring(0, 2))*60000)+(Int32.Parse(current.secondTime.Substring(0, 2))*60000))+((Int32.Parse(current.firstTime.Substring(3, 2))*1000)+(Int32.Parse(current.secondTime.Substring(3, 2))*1000))+((Int32.Parse(current.firstTime.Substring(5, 3).Substring(1, 2))*10)+(Int32.Parse(current.secondTime.Substring(5, 3).Substring(1, 2))*10))));
			return true;
		} else if (vars.splitTimeStopwatch.IsRunning && vars.splitTimeStopwatch.Elapsed.TotalSeconds >= vars.splitTimeOffset && current.firstName == "WR" && current.thirdName == "PL") {
			vars.splitTimeStopwatch.Reset();
			timer.SetGameTime(TimeSpan.FromMilliseconds(((Int32.Parse(current.firstTime.Substring(0, 2))*60000)+(Int32.Parse(current.thirdTime.Substring(0, 2))*60000))+((Int32.Parse(current.firstTime.Substring(3, 2))*1000)+(Int32.Parse(current.thirdTime.Substring(3, 2))*1000))+((Int32.Parse(current.firstTime.Substring(5, 3).Substring(1, 2))*10)+(Int32.Parse(current.thirdTime.Substring(5, 3).Substring(1, 2))*10))));
			return true;
		} else if (vars.splitTimeStopwatch.IsRunning && vars.splitTimeStopwatch.Elapsed.TotalSeconds >= vars.splitTimeOffset && current.firstName == "PB" && current.secondName == "PL") {
			vars.splitTimeStopwatch.Reset();
			timer.SetGameTime(TimeSpan.FromMilliseconds(((Int32.Parse(current.firstTime.Substring(0, 2))*60000)+(Int32.Parse(current.secondTime.Substring(0, 2))*60000))+((Int32.Parse(current.firstTime.Substring(3, 2))*1000)+(Int32.Parse(current.secondTime.Substring(3, 2))*1000))+((Int32.Parse(current.firstTime.Substring(5, 3).Substring(1, 2))*10)+(Int32.Parse(current.secondTime.Substring(5, 3).Substring(1, 2))*10))));
			return true;
		} else if (vars.splitTimeStopwatch.IsRunning && vars.splitTimeStopwatch.Elapsed.TotalSeconds >= vars.splitTimeOffset && current.firstName == "PB" && current.thirdName == "PL") {
			vars.splitTimeStopwatch.Reset();
			timer.SetGameTime(TimeSpan.FromMilliseconds(((Int32.Parse(current.firstTime.Substring(0, 2))*60000)+(Int32.Parse(current.thirdTime.Substring(0, 2))*60000))+((Int32.Parse(current.firstTime.Substring(3, 2))*1000)+(Int32.Parse(current.thirdTime.Substring(3, 2))*1000))+((Int32.Parse(current.firstTime.Substring(5, 3).Substring(1, 2))*10)+(Int32.Parse(current.thirdTime.Substring(5, 3).Substring(1, 2))*10))));
			return true;
		}
	} else {
		if (current.raceComplete == 30 && old.raceComplete != current.raceComplete) {
			return true;
		} else {
			return false;
		}
	}
}

reset
{
	if (settings["ilmode"] && old.raceStart != current.raceStart && current.raceStart == 0) {
		return true;
	}
}

isLoading
{
	if (settings["ilmode"]) {
		return true;
	} else {
		return current.loading;
	}
}