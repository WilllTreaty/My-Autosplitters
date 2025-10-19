state("NeedForSpeedPayback", "Standard Origin Version")
{
    bool loading: 0x037DF618, 0x80, 0xB0, 0x10, 0x28, 0x68, 0x188, 0x128; //248813B0 better
}

init
{
    if(modules.First().ModuleMemorySize == 0xB09C000) {
		version = "Standard Origin Version";
	}
    else {
        MessageBox.Show("Version not supported!");
    }
}

startup
{
    if(timer.CurrentTimingMethod == TimingMethod.RealTime) { //stolen from RICO, basically asks the runner to set their livesplit to game time
        var message = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main\ntiming method. "+
            "Livesplit is currently set to show Real Time (RTA). Would you like to set "+
            "the timing method to Game\nTime, so the loadless timer works?",
            "Livesplit | NFS Payback",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );

        if(message == DialogResult.Yes) {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

start
{
    if(!old.loading && current.loading) {
        return true;
    }
}

split
{

}

isLoading
{
    return current.loading;
}

exit
{
    timer.IsGameTimePaused = false;
}