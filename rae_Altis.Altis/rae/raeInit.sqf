//load config
call compile PreProcessFileLineNumbers "rae\raeConfig.sqf";

if (raeDebug == 1) then 
{
	["RAE Debug ON... mission initializing"] remoteExec ["systemChat", 0, true]
};

if (isClass (configFile >> "cfgPatches" >> "vtx_main")) then {
	//Delete JVMF messages
	for "_i" from 0 to (count VTX_JVMF_MESSAGES) do {
	_del = VTX_JVMF_MESSAGES deleteAt 0;
	};
	//Create intro JVMF
	_introJVMF = [
	"Welcome to RAE",
	raeCallsignTOC,
	"PILOTS", 
	0, 
	[
		"Welcome to RAE",
        "aka Random Aircrew Environment",
		"",
		"RAE is a purpose built system to", 
		"fulfill the void in logistics",
		"based dynamic missions that us ", 
		"helicopter pilots are after.",
		"",
		"Missions will show here and",
		"if set the vanilla task system"
	]
] call vtx_uh60_jvmf_fnc_attemptSendMessage;
};

