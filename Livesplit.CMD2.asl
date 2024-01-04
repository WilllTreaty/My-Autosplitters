state("dirt2_game") 
{
	int start : "dirt2_game.exe", 0x107DF10, 0xB0, 0x108;
	int raceComplete : "dirt2_game.exe", 0x107DF10, 0xCC, 0x5C;
	int Loading : "dirt2_game.exe", 0x1115A4C, 0x800;
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