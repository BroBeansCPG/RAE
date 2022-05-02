
raeCallsignTOC	= "ODIN";	//HQ Callsign which sends missions

//Unit arrays
//Enemy
rae_OUnits			= [];
rae_OVehicles		= [];
rae_OTrucks			= [];
rae_OArmour			= [];
rae_OAntiAir		= [];
rae_OTurrets		= [];
rae_OHelis			= [];

//Civilian
rae_CivUnits		= [];
rae_CivVehicles		= [];
rae_CivBoats		= [];

//Friendly Military Units
rae_BUnits			= [];
rae_BsfUnits		= ["rhsusf_socom_marsoc_cso_light", "rhsusf_socom_marsoc_cso_mk17_light", "rhsusf_socom_marsoc_sniper", "rhsusf_socom_marsoc_teamchief", "rhsusf_socom_marsoc_sarc", "rhsusf_socom_marsoc_jtac"];
rae_BVehicles		= [];
rae_BHelis			= [];
rae_BPlanes			= [];
rae_BsfVehicles		= ["rhsusf_mrzr4_d", "rhsusf_m1165a1_gmv_mk19_m240_socom_d", "rhsusf_m1240a1_m240_usmc_d"];

rae_Crate = "Box_NATO_WpsSpecial_F";



//Blacklisted Locs
raeBlacklist 	= [];		//Blacklisted area arrays (marker names)
//Automatically populate blacklist array with any "blacklist" markers
private _allMarkers = allMapMarkers;
{
	if ("blacklist" in _x) then {raeBlacklist pushBack _x};
	if ("Blacklist" in _x) then {raeBlacklist pushBack _x};
} forEach _allMarkers;

//Params fetched from lobby

//Debug markers on (1) or off (0)
raeDebug 		= ["raeDebug", 0] call BIS_fnc_getParamValue;

raeMaxRange		= ["raeMaxRange", 0] call BIS_fnc_getParamValue;
switch (raeMaxRange) do {
	case 0: 	{raeMaxRange = (worldSize / 2)};
	case 4:		{raeMaxRange = 4000};
	case 6:		{raeMaxRange = 6000};
	case 8:		{raeMaxRange = 8000};
	case 10: 	{raeMaxRange = 10000};
};

//Don't Edit
raeCurrentMissions = [];