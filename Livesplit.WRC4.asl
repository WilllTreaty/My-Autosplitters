/*
 *	Autosplitter and IGT done by WillTreaty
 */

state("WRC4")
{
	float igt : 0xC96EE4;
	int start : 0xC968D8;
}

init
{
	vars.timeTotal = 0;
}

startup
{
	vars.timerModel = new TimerModel { CurrentState = timer };
	
    if (timer.CurrentTimingMethod == TimingMethod.RealTime) {
        var timingMessage = MessageBox.Show(
            "This game uses In-Game Time (IGT) as the primary timing method.\n"
			+ "LiveSplit is currently displaying Real Time (RTA).\n"
			+ "In-Game Time updates automatically at the end of each track.\n"
			+ "Would you like to switch the timing method to Game Time?",
            "WRC 4 | LiveSplit",
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
	if ((old.start == 13 && current.start == 9) || ((old.start == 10 || old.start == 11) && current.start == 13)) {
		return true;
	} else {
		return false;
	}
}

split
{
	if (old.igt == 0 && old.igt != current.igt) {
		if (timer.CurrentSplitIndex == 0) {
			float milliseconds = current.igt * 1000f;
			int trimmedMilliseconds = ((int)milliseconds / 10) * 10;
			vars.timeTotal = new TimeSpan(0, 0, 0, 0, trimmedMilliseconds);
			timer.SetGameTime(vars.timeTotal);
			return true;
		} else {
			float milliseconds = current.igt * 1000f;
			int trimmedMilliseconds = ((int)milliseconds / 10) * 10;
			vars.timeTotal += new TimeSpan(0, 0, 0, 0, trimmedMilliseconds);
			timer.SetGameTime(vars.timeTotal);
			return true;
		}
	} else {
		return false;
	}
}

isLoading
{
	return true;
}