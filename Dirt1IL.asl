state("dirt") {
	int checkpoint : "dirt.exe", 0x79E07C, 0xF0, 0x2CC;
	int racestart : "dirt.exe", 0x813780, 0x30, 0x1C8;
	string2 firstName : "dirt.exe", 0x38672550;
	string2 secondName : "dirt.exe", 0x386725B0;
	string2 thirdName : "dirt.exe", 0x38672610;
	string8 firstTime : "dirt.exe", 0x38672530;
	string8 secondTime : "dirt.exe", 0x38672591;
	string8 thirdTime : "dirt.exe", 0x386725F1;
}

start {
	if (current.racestart != old.racestart && current.racestart == 1) {
		return true;
	}
}

split {
	if (current.firstTime != old.firstTime && current.firstTime != "") {
		if (current.firstName == "PL") {
			timer.SetGameTime(TimeSpan.FromMilliseconds((Int32.Parse(current.firstTime.Substring(0, 2))*60000)+(Int32.Parse(current.firstTime.Substring(3, 2))*1000)+(Int32.Parse(current.firstTime.Substring(5, 3).Substring(1, 2))*10)));
		} else if (current.firstName == "WR" && current.secondName == "PL") {
			timer.SetGameTime(TimeSpan.FromMilliseconds(((Int32.Parse(current.firstTime.Substring(0, 2))*60000)+(Int32.Parse(current.secondTime.Substring(0, 2))*60000))+((Int32.Parse(current.firstTime.Substring(3, 2))*1000)+(Int32.Parse(current.secondTime.Substring(3, 2))*1000))+((Int32.Parse(current.firstTime.Substring(5, 3).Substring(1, 2))*10)+(Int32.Parse(current.secondTime.Substring(5, 3).Substring(1, 2))*10))));
		} else if (current.firstName == "WR" && current.thirdName == "PL") {
			timer.SetGameTime(TimeSpan.FromMilliseconds(((Int32.Parse(current.firstTime.Substring(0, 2))*60000)+(Int32.Parse(current.thirdTime.Substring(0, 2))*60000))+((Int32.Parse(current.firstTime.Substring(3, 2))*1000)+(Int32.Parse(current.thirdTime.Substring(3, 2))*1000))+((Int32.Parse(current.firstTime.Substring(5, 3).Substring(1, 2))*10)+(Int32.Parse(current.thirdTime.Substring(5, 3).Substring(1, 2))*10))));
		}
		
		return true;
	}
}

reset {
	if (current.racestart != old.racestart && current.racestart == 0 && current.checkpoint == 0) {
		return true;
	}
}

isLoading {
	return true;
}