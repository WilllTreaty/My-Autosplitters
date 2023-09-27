/*
 *	Autosplitter and Loadless Remover done by WillTreaty
 */

state("TransformersDevastation")
{
	int missionComplete : 0xA6A684;
	int loading : 0xB74EB8;
	int start : 0xA04F14, 0x72C, 0x130;
}

split
{
	if (current.missionComplete == 1 && old.missionComplete != current.missionComplete) {
		return true;
	} else { 
		return false;
	}
}

start 
{
	if (current.start == 2 && current.start != old.start) {
		return true;
	} else {
		return false;
	}
}

isLoading 
{
	if (current.loading == 1) {
		return true;
	} else {
		return false;
	}
}