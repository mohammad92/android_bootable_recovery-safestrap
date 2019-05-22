// action_safestrap.cpp - GUIAction extension

int createImagePartition(string slotName, string imageName, int imageSize, string mountName,
		int loopNum __unused, int progressBase1, int progressBase2, int progressBase3) {
	char cmd[255];
	string result;
	string seconds;
	int currentSize = 0;
	int blockSizeMax = 100; // 100mb
	int blockSize = 1;

	DataManager::GetValue("tw_screen_timeout_secs", seconds);
#ifndef TW_NO_SCREEN_TIMEOUT
	blankTimer.setTime(0);
#endif

	DataManager::SetValue("tw_operation", "Clearing old " + imageName + ".img...");
	PartitionManager.UnMount_By_Path("/" + mountName, true);
	sprintf(cmd, "rm -rf /ss/safestrap/%s/%s.img", slotName.c_str(), imageName.c_str());
	fprintf(stderr, "createImagePartition::%s\n", cmd);
	TWFunc::Exec_Cmd(cmd, result);

	sprintf(cmd, "losetup -d /dev/block/loop-%s", imageName.c_str());
	fprintf(stderr, "createImagePartition::%s\n", cmd);
	usleep(100000);
	TWFunc::Exec_Cmd(cmd, result);
	DataManager::SetValue("ui_progress", progressBase1);

	DataManager::SetValue("tw_operation", "Creating " + imageName + ".img...");
	gui_print("Creating %s.img...\n", imageName.c_str());

	sprintf(cmd, "sync; echo 3 > /proc/sys/vm/drop_caches");
	fprintf(stderr, "createImagePartition::%s\n", cmd);
	usleep(100000);
	TWFunc::Exec_Cmd(cmd, result);
	if (result != "")
		goto error_out;

	// loop here doing 100mb at a time (or the remainder)
	// currentSize == mb written so far
	// blockSize == mb to write (or 100mb max)
	while ((blockSize > 0) && (currentSize < imageSize)) {
		blockSize = imageSize - currentSize;
		if (blockSize > 0) {
			if (blockSize > blockSizeMax) blockSize = blockSizeMax;

			sprintf(cmd, "/sbin/lfs dd if=/dev/zero of=/ss/safestrap/%s/%s.img bs=1M seek=%d count=%d conv=notrunc", slotName.c_str(), imageName.c_str(), currentSize, blockSize);
			fprintf(stderr, "createImagePartition::%s\n", cmd);
			usleep(100000);
			TWFunc::Exec_Cmd(cmd, result);
			if (result != "")
				goto error_out;

			sprintf(cmd, "sync; echo 3 > /proc/sys/vm/drop_caches");
			fprintf(stderr, "createImagePartition::%s\n", cmd);
			usleep(100000);
			TWFunc::Exec_Cmd(cmd, result);
			if (result != "")
				goto error_out;

			currentSize += blockSize;
		}
	}

	DataManager::SetValue("ui_progress", progressBase2);

	DataManager::SetValue("tw_operation", "Writing filesystem on " + imageName + "...");
	gui_print("Writing filesystem on %s...\n", imageName.c_str());
	sprintf(cmd, "losetup /dev/block/loop-%s /ss/safestrap/%s/%s.img", imageName.c_str(), slotName.c_str(), imageName.c_str());
	fprintf(stderr, "createImagePartition::%s\n", cmd);
	usleep(100000);
	TWFunc::Exec_Cmd(cmd, result);
	if (result != "")
		goto error_out;

	sprintf(cmd, "/sbin/build-fs.sh %s -%s %s", imageName.c_str(), imageName.c_str(), slotName.c_str());
	fprintf(stderr, "createImagePartition::%s\n", cmd);
	usleep(100000);
	TWFunc::Exec_Cmd(cmd, result);
// HASH: This is currently always erroring out.
//	if (result != "")
//		goto error_out;

	DataManager::SetValue("ui_progress", progressBase3);
#ifndef TW_NO_SCREEN_TIMEOUT
	blankTimer.resetTimerAndUnblank();
	blankTimer.setTime(atoi(seconds.c_str()));
#endif

	return 0;

error_out:
#ifndef TW_NO_SCREEN_TIMEOUT
	blankTimer.resetTimerAndUnblank();
	blankTimer.setTime(atoi(seconds.c_str()));
#endif
	gui_print("ERROR=%s\n", result.c_str());
	fprintf(stderr, "createImagePartition::ERROR=%s\n", result.c_str());
	return 1;
}

int checkRomSlot(string loopName, bool remount) {
	char cmd[255];
	TWPartition* Part = PartitionManager.Find_Partition_By_Path("/" + loopName);
	string result;
	if (Part) {
		if (Part->Is_Mounted())
			Part->UnMount(true);
		DataManager::SetValue("tw_operation", "Checking/Fixing filesystem on " + Part->Display_Name + "...");
		gui_print("Checking/Fixing filesystem on %s...\n", Part->Display_Name.c_str());

		sprintf(cmd, "/sbin/check-fs.sh -%s", loopName.c_str());
		fprintf(stderr, "checkRomSlot::%s\n", cmd);
		usleep(100000);
		TWFunc::Exec_Cmd(cmd, result);
		if (remount)
			Part->Mount(true);
	}
	return 0;
}

int GUIAction::refreshsizesnt(std::string arg __unused)
{
	if (simulate) {
		simulate_progress_bar();
	} else {
		PartitionManager.Update_System_Details();
	}
	return 0;
}

int GUIAction::loadsizes(std::string arg __unused)
{
	if (simulate) {
		simulate_progress_bar();
	} else {
		unsigned long long mb = 1048576;
		TWPartition* Part;

		// Fill the following vars:
		//tw_slot_system_size / tw_slot_system_free
		//tw_slot_data_size / tw_slot_data_free
		//tw_slot_cache_size / tw_slot_cache_free
		Part = PartitionManager.Find_Partition_By_Path("/system");
		if (Part) {
			DataManager::SetValue("tw_slot_system_size", (int)(Part->Size / mb));
			DataManager::SetValue("tw_slot_system_free", (int)(Part->Free / mb));
		}
		Part = PartitionManager.Find_Partition_By_Path("/data");
		if (Part) {
			DataManager::SetValue("tw_slot_data_size", (int)(Part->Size / mb));
			DataManager::SetValue("tw_slot_data_free", (int)(Part->Free / mb));
		}
		Part = PartitionManager.Find_Partition_By_Path("/cache");
		if (Part) {
			DataManager::SetValue("tw_slot_cache_size", (int)(Part->Size / mb));
			DataManager::SetValue("tw_slot_cache_free", (int)(Part->Free / mb));
		}
	}
	return 0;
}

int GUIAction::changeslot(std::string arg)
{
        string result;
	PartitionManager.UnMount_By_Path("/system", true);
	PartitionManager.UnMount_By_Path("/data", true);

	// CACHE COPY
	PartitionManager.Mount_By_Path("/cache", true);
	TWFunc::Exec_Cmd("rm -rf /tmp/recovery", result);
	TWFunc::Exec_Cmd("cp -R /cache/recovery /tmp", result);
	TWFunc::Exec_Cmd("rm -rf /cache/recovery", result);
	PartitionManager.UnMount_By_Path("/cache", true);

	TWFunc::Exec_Cmd("/sbin/changeslot.sh " + arg, result);
	std::string fstab_filename = "/etc/twrp.fstab";
	if (!TWFunc::Path_Exists(fstab_filename)) {
		fstab_filename = "/etc/recovery.fstab";
	}
	printf("=> Processing %s\n", fstab_filename.c_str());
	if (!PartitionManager.Process_Fstab(fstab_filename, true, true)) {
		LOGERR("Failing out of recovery due to problem with fstab.\n");
		return -1;
	}
	PartitionManager.Update_System_Details();

	PartitionManager.Mount_By_Path("/cache", true);
	TWFunc::Exec_Cmd("rm -rf /cache/recovery", result);
	TWFunc::Exec_Cmd("cp -R /tmp/recovery /cache", result);
	TWFunc::Exec_Cmd("rm -rf /tmp/recovery", result);

	return 0;
}

int GUIAction::checkslotnames(std::string arg __unused)
{
	char array[512];
	string str = "Undefined";
	string var = "";

	for (int i = 1; i < 5; i++) {
		sprintf(array, "rom-slot%d", i);
		var = array;
		DataManager::GetValue("tw_" + var + "_name", str);
		fprintf(stderr, "checkslotnames: tw_%s_name=%s\n", var.c_str(), str.c_str());
	}
	return 0;	
}

int GUIAction::readslotnames(std::string arg __unused)
{
	char array[512];
	char filename[512];
	long lSize;
	size_t result;
	string str = "Undefined";
	string var = "";

	DataManager::SetValue("tw_rom-slot1_name", "ROM-Slot-1");
	DataManager::SetValue("tw_rom-slot2_name", "ROM-Slot-2");
	DataManager::SetValue("tw_rom-slot3_name", "ROM-Slot-3");
	DataManager::SetValue("tw_rom-slot4_name", "ROM-Slot-4");

	for (int i = 1; i < 5; i++) {
		sprintf(array, "rom-slot%d", i);
		var = array;

		// Read in the file, if possible
		sprintf(filename, "/ss/safestrap/rom-slot%d/name", i);
		FILE* in = fopen(filename, "rb");
		if (in) {
			// obtain file size:
			fseek(in, 0, SEEK_END);
			lSize = ftell(in);
			if (lSize > 0) {
				fseek(in, 0, SEEK_SET);
				// adjust for EOF
				result = fread(array, 1, lSize, in);
				if ((long)result == lSize) {
					array[lSize-1] = '\0';
					str = array;
				}
			}
			fclose(in);
			fprintf(stderr, "found: tw_%s_name=%s\n", var.c_str(), str.c_str());
			DataManager::SetValue("tw_" + var + "_name", str);
		}
// HASH: Don't complain so much about missing rom-slots
#if 0
		else {
			DataManager::GetValue("tw_" + var + "_name", str);
			fprintf(stderr, "not found: tw_%s_name=%s\n", var.c_str(), str.c_str());
		}
#endif
	}
	return 0;
}

int GUIAction::setslotvarname(std::string arg)
{
	string str = arg;
	string var = "tw_" + arg +"_name";
	DataManager::GetValue(var, str);
	fprintf(stderr, "Loaded from %s, setting tw_slotname: %s\n", var.c_str(), str.c_str());
	DataManager::SetValue("tw_slotname", str);
	return 0;
}

int GUIAction::setslotnickname(std::string arg __unused)
{
	string result;
	string romslot;
	string slotname;

	DataManager::GetValue("tw_trybootslot", romslot);
	DataManager::GetValue("tw_try_slotname", slotname);
	if ((romslot == "stock") || (slotname == ""))
		return 0;

	fprintf(stderr, "setslotnickname: echo \"%s\" > /ss/safestrap/%s/name\n", slotname.c_str(), romslot.c_str());
	TWFunc::Exec_Cmd("echo \"" + slotname + "\" > /ss/safestrap/" + romslot + "/name", result);

	DataManager::SetValue("tw_" + romslot + "_name", slotname);
	return 0;
}

int GUIAction::createslot(std::string arg)
{
        string result;
	std::string pageName = gui_parse_text(arg);
	std::string function = gui_parse_text(pageName);
	DataManager::GetValue("tw_trybootslot", arg);
	if (arg == "stock")
		return 0;

	operation_start("createslot");

	if (simulate) {
		simulate_progress_bar();
		gui_print("Simulating actions...\n");
	}
	else {
		int system_size = 600;
		int data_size = 1024;
		int cache_size = 300;

		gui_changePage(pageName);

		DataManager::GetValue("tw_slot_system_size", system_size);
		DataManager::GetValue("tw_slot_data_size", data_size);
		DataManager::GetValue("tw_slot_cache_size", cache_size);

		DataManager::SetValue("ui_progress", 0);

		TWFunc::Exec_Cmd("mkdir -p /ss/safestrap/" + arg, result);

		// SYSTEM
		if (createImagePartition(arg, "system", system_size, "system", 7, 5, 20, 30) != 0) {
			DataManager::SetValue("tw_operation", "Error creating system partition!");
			gui_print("Error creating system partition!\n");
			gui_print("Cleaning up files...\n");
			TWFunc::Exec_Cmd("rm -rf /ss/safestrap/" + arg, result);
			return -1;
		}

		// USERDATA
		if (createImagePartition(arg, "userdata", data_size, "data", 6, 35, 60, 70) != 0) {
			DataManager::SetValue("tw_operation", "Error creating data partition!");
			gui_print("Error creating data partition!\n");
			gui_print("Cleaning up files...\n");
			TWFunc::Exec_Cmd("rm -rf /ss/safestrap/" + arg, result);
			return -1;
		}

		// CACHE
		PartitionManager.Mount_By_Path("/cache", true);
		TWFunc::Exec_Cmd("cp -R /cache/recovery /tmp", result);
		TWFunc::Exec_Cmd("rm -rf /cache/recovery", result);
		PartitionManager.UnMount_By_Path("/cache", true);

		if (createImagePartition(arg, "cache", cache_size, "cache", 5, 75, 85, 90) != 0) {
			DataManager::SetValue("tw_operation", "Error creating cache partition!");
			gui_print("Error creating cache partition!\n");
			gui_print("Cleaning up files...\n");
			TWFunc::Exec_Cmd("rm -rf /ss/safestrap/" + arg, result);
			PartitionManager.Mount_By_Path("/cache", true);
			TWFunc::Exec_Cmd("rm -rf /cache/recovery", result);
			TWFunc::Exec_Cmd("cp -R /tmp/recovery /cache", result);
			TWFunc::Exec_Cmd("rm -rf /tmp/recovery", result);
			return -1;
		}

		DataManager::SetValue("tw_operation", "Activating ROM slot...");
		gui_print("Activating ROM slot...\n");
		TWFunc::Exec_Cmd("/sbin/changeslot.sh " + arg, result);
		DataManager::SetValue("ui_progress", 95);

		DataManager::SetValue("tw_operation", "Updating filesystem details...");
		gui_print("Updating filesystem details...\n");
		std::string fstab_filename = "/etc/twrp.fstab";
		if (!TWFunc::Path_Exists(fstab_filename)) {
			fstab_filename = "/etc/recovery.fstab";
		}
		printf("=> Processing %s\n", fstab_filename.c_str());
		if (!PartitionManager.Process_Fstab(fstab_filename, true, true)) {
			LOGERR("Failing out of recovery due to problem with fstab.\n");
			return -1;
		}
		PartitionManager.Update_System_Details();

		PartitionManager.Mount_By_Path("/cache", true);
		TWFunc::Exec_Cmd("rm -rf /cache/recovery", result);
		TWFunc::Exec_Cmd("cp -R /tmp/recovery /cache", result);
		TWFunc::Exec_Cmd("rm -rf /tmp/recovery", result);
	       
                // Done
	        DataManager::SetValue("ui_progress", 0);
	}
	operation_end(0);
	return 0;
}

int GUIAction::deleteslot(std::string arg)
{
	string result;
	if (arg == "stock")
		return 0;

	operation_start("deleteslot");

	if (simulate) {
		simulate_progress_bar();
		gui_print("Simulating actions...\n");
	}
	else {
		TWFunc::Exec_Cmd("rm -rf /ss/safestrap/" + arg, result);
	}
	operation_end(0);
	return 0;
}

int GUIAction::checkslot(std::string arg __unused)
{
	operation_start("checkslot");

	if (simulate) {
		simulate_progress_bar();
		gui_print("Simulating actions...\n");
	}
	else {
		// 1 at a time unmount partition and run e2fsck -pfv <block>

		DataManager::SetValue("ui_progress", 0);
		checkRomSlot("system", false);
		DataManager::SetValue("ui_progress", 20);
		checkRomSlot("data", false);
		DataManager::SetValue("ui_progress", 80);
		checkRomSlot("cache", true);
	}

	operation_end(0);
	return 0;
}
