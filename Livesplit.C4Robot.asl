/*
 *	Autosplitter done by WillTreaty
 */

state("C4")
{
	int checkpoint : "acknex.dll", 0x201644, 0xB44, 0x0, 0x10, 0x4, 0x10;
	int raceState : "acknex.dll", 0x218DEC, 0x490, 0x10;
}

startup
{
	//Used for checking current split index and handling quick race mode resets
	vars.timerModel = new TimerModel { CurrentState = timer };
}

split
{
	if (old.checkpoint != current.checkpoint) {
		return true;
	} else { 
		return false;
	}
}

update 
{
	//Used for resetting time interval splits and for the timer itself while saving golds/pb
	if ((timer.CurrentPhase == TimerPhase.Ended || timer.CurrentPhase == TimerPhase.NotRunning) && old.raceState != current.raceState && current.raceState == 0) {
		vars.timerModel.Reset();
	}
}

start 
{
	if (current.raceState == 1024 && current.raceState != old.raceState) {
		return true;
	} else {
		return false;
	}
}

reset 
{
	if (current.raceState == 0 && current.raceState != old.raceState) {
		return true;
	} else {
		return false;
	}
}