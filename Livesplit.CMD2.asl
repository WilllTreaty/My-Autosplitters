/*
 *	Autosplitter and Load Remover done by WillTreaty
 */

state("dirt2_game") 
{
	int start : "dirt2_game.exe", 0x107DF10, 0xB0, 0x108;
	int raceComplete : "dirt2_game.exe", 0x107DF10, 0xCC, 0x5C;
	int Loading : "dirt2_game.exe", 0x1115A4C, 0x800;
}

startup
{
    if (timer.CurrentTimingMethod == TimingMethod.RealTime) {
        var timingMessage = MessageBox.Show(
            "This game uses Time without Loads (Game Time) as the main timing method.\n"
            + "LiveSplit is currently set to show Real Time (RTA).\n"
            + "Would you like to set the timing method to Game Time?",
            "Dirt 2 | LiveSplit",
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
	if (current.start == 0 && old.start != current.start) {
		return true;
	} else {
		return false;
	}
}

split 
{
	if (current.raceComplete == 0 && old.raceComplete != current.raceComplete) {
		return true;
	} else {
		return false;
	}
}

isLoading 
{
	if (current.Loading == 0) {
		return true;
	} else {
		return false;
	}
}