/*
 *	Autosplitter and Loadless Remover done by Failracer, TDOG20 and WillTreaty
 */

state("nfs") 
{
    int loading: "nfs.exe", 0xF33FEC, 0x4C0;
    byte loadingEverything: "nfs.exe", 0x9A530C;
	int completed: "nfs.exe", 0x1F7D078;
	string9 movie: "nfs.exe", 0xF78168, 0x114, 0x40F;
	string4 raceName: "nfs.exe", 0x9AF5A0;
	string12 raceNameButCooler: "nfs.exe", 0x9AF564, 0x18, 0x3C;
}  

startup
{
	settings.Add("splits", true, "Event Splits");
	
	settings.Add("prologue", true, "Prologue", "splits");
	settings.SetToolTip("prologue", "Split after starting first career race (after cutscene and call)");
	
	settings.Add("sp_c_12.vlt", true, "Cross Slope & Ocean", "splits");
	settings.Add("hb_c_01.vlt", true, "East I-20", "splits");
	settings.Add("sp_c_21.vlt", true, "Aubrey Street", "splits");
	settings.Add("or_c_03.vlt", true, "West Ocean Express", "splits");
	settings.Add("sp_c_20.vlt", true, "Palm Harbor Rally", "splits");
	settings.Add("cr_c_03.vlt", true, "Ocean & Wilson", "splits");
	settings.Add("hb_c_04.vlt", true, "West I-20", "splits");
	settings.Add("or_c_07.vlt", true, "South Lawrence", "splits");
	settings.Add("cr_c_04.vlt", true, "Jackson & Veteran", "splits");
	settings.Add("cts_c_02.vlt", true, "West Water Street", "splits");
	settings.Add("es_c_02.vlt", true, "West Alena", "splits");
	settings.Add("cts_c_01.vlt", true, "East Konopa", "splits");
	settings.Add("hb_c_03.vlt", true, "Rush Hour", "splits");
	settings.Add("cts_c_03.vlt", true, "West Lydian", "splits");
	settings.Add("es_c_01.vlt", true, "North Sutton", "splits");
	settings.Add("E047.vlt", true, "Training Wheels", "splits");
	settings.Add("or_c_01.vlt", true, "The Game", "splits");
	settings.Add("E069.vlt", true, "Eyes In The Sky", "splits");
	settings.Add("E071.vlt", true, "Nick of Time", "splits");
	settings.Add("es_c_03.vlt", true, "East Sutton", "splits");
	settings.Add("cts_c_04.vlt", true, "Aubrey & Wilson", "splits");
	settings.Add("E120.vlt", true, "Mystery Job", "splits");
	settings.Add("es_c_04.vlt", true, "South Ocean Express", "splits");
	settings.Add("cts_c_06.vlt", true, "East Stadium", "splits");
	settings.Add("or_c_04.vlt", true, "West Stadium", "splits");
	settings.Add("cts_c_05.vlt", true, "South Harbor", "splits");
	settings.Add("E085.vlt", true, "Versus", "splits");
	settings.Add("or_c_02.vlt", true, "Jackson & Ocean", "splits");
	settings.Add("hb_c_02.vlt", true, "Southeast I-20", "splits");
	settings.Add("E096.vlt", true, "The Trap", "splits");
	settings.Add("E098.vlt", true, "The Kingpin", "splits");
	settings.Add("E115.vlt", true, "Grease Monkey", "splits");
	settings.Add("E116.vlt", true, "Loco", "splits");
	
	settings.Add("hb_a_04.vlt", true, "Road Rage and/or I-10 North", "splits");
	settings.SetToolTip("hb_a_04.vlt", "Both events shares the same ingame name.");
	
	settings.Add("E076.vlt", true, "Transporter", "splits");
	settings.Add("cts_a_01.vlt", true, "South Pine Creek", "splits");
	settings.Add("cto_a_02.vlt", true, "Morin & Douglas", "splits");
	settings.Add("cr_a_15.vlt", true, "Tri-City Race", "splits");
	settings.Add("cts_a_02.vlt", true, "Eastside To Sheridan", "splits");
	settings.Add("es_a_01.vlt", true, "South Palm", "splits");
	settings.Add("E145.vlt", true, "Rematch", "splits");
	settings.Add("es_a_05.vlt", true, "South Trevino Ave", "splits");
	settings.Add("cto_a_08.vlt", true, "South Gold Coast Hwy", "splits");
	settings.Add("cto_a_06.vlt", true, "Eastside & Gord", "splits");
	settings.Add("cto_a_01.vlt", true, "Gord & Eastside", "splits");
	settings.Add("cto_a_05.vlt", true, "Southbridge & Eastside", "splits");
	settings.Add("es_a_03.vlt", true, "Valencia & Peak Ridge", "splits");
	settings.Add("cts_a_03.vlt", true, "West Southbridge", "splits");
	settings.Add("es_a_04.vlt", true, "Mountain & Gold Coast", "splits");
	settings.Add("es_a_02.vlt", true, "North Gold Coast", "splits");
	settings.Add("cto_a_03.vlt", true, "Hillside & Sheridan", "splits");
	settings.Add("E186.vlt", true, "Grand Theft 5-0", "splits");
	settings.Add("cto_a_04.vlt", true, "Southeast Valencia", "splits");
	settings.Add("cto_c_01.vlt", true, "Alena & Harbor", "splits");
	settings.Add("E193.vlt", true, "Hot Item", "splits");
	settings.Add("E195.vlt", true, "Special Delivery", "splits");
	settings.Add("hb_a_03.vlt", true, "I-10 to I-5", "splits");
	settings.Add("es_b_01.vlt", true, "I-10 Onramp", "splits");
	settings.Add("hb_a_08.vlt", true, "I-5 to I-85", "splits");
	settings.Add("E215.vlt", true, "Duel", "splits");
	settings.Add("E217.vlt", true, "Rocket Ride", "splits");
	settings.Add("E219.vlt", true, "Lightspeed", "splits");
	settings.Add("E223.vlt", true, "Hunted", "splits");
	settings.Add("cts_b_01.vlt", true, "East Prime Ave", "splits");
	settings.Add("sp_a_29.vlt", true, "Rollercoaster", "splits");
	settings.Add("sp_a_13.vlt", true, "South Canyon Hwy", "splits");
	settings.Add("cp_a_22.vlt", true, "Tri-City Run", "splits");
	settings.Add("cto_b_02.vlt", true, "Maureen & Powell", "splits");
	settings.Add("cts_b_04.vlt", true, "South Naval Access", "splits");
	settings.Add("cts_b_02.vlt", true, "North Victory", "splits");
	settings.Add("hb_b_05.vlt", true, "I-85 to I-5", "splits");
	settings.Add("cto_b_04.vlt", true, "South Industry Lane", "splits");
	settings.Add("hb_b_01.vlt", true, "North I-85", "splits");
	settings.Add("E277.vlt", true, "Hornet's Nest", "splits");
	settings.Add("E279.vlt", true, "The Feds", "splits");
	settings.Add("es_b_03.vlt", true, "I-85 Offramp", "splits");
	settings.Add("hb_b_04.vlt", true, "West I-85", "splits");
	settings.Add("E283.vlt", true, "Payback", "splits");
	settings.Add("hb_a_06.vlt", true, "West I-5", "splits");
	settings.Add("hb_a_01.vlt", true, "I-5 North", "splits");
	settings.Add("E286.vlt", true, "Double Trouble", "splits");
	settings.Add("es_b_04.vlt", true, "West Maureen", "splits");
	settings.Add("E313.vlt", true, "Betrayed", "splits");
	
	settings.Add("showdown", true, "Showdown (experimental)", "splits");
	settings.SetToolTip("showdown", "Split after pressing continue button in final event as it's determined on src page.");
}

start
{
    return current.loadingEverything == 96;
}

split
{
	if (settings[current.raceNameButCooler] && current.completed == 14260760 && current.completed != old.completed && old.completed != 1) {
		return true;
	} else if (settings["showdown"] && current.raceNameButCooler.Equals("E315.vlt") && current.movie.Equals("Storey_35") && current.movie != old.movie) {
		return true;
	} else if (settings["prologue"] && old.raceNameButCooler.Equals("E002.vlt") && current.raceNameButCooler.Equals("sp_c_12.vlt")) {
		return true;
	} else {
		return false;
	}
}

isLoading 
{
    return current.loadingEverything != 0;
}

exit
{
    timer.IsGameTimePaused = false;
}