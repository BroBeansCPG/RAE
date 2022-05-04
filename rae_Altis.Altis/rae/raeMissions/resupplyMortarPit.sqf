//Resupply Mortar Pit

if !(isServer) exitWith {}; 

//Find Location & POI
_mapCentre = [worldSize / 2, worldsize / 2, 0]; 
_pos = [_mapCentre, 1000, raeMaxRange, 0, 200, 0.05, 0, raeBlacklist, [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
_gridPos = mapGridPosition _pos;

private _missionID = "resupplyMortarPit" + (str _pos);
raeCurrentMissions pushBack _missionID;

//Debug
if (raeDebug == 1) then { 
 _dbMarker = createMarker [_missionID, _pos]; 
 _dbMarker setMarkerType "hd_dot"; 
 _dbMarker setMarkerText _missionID; 
};
/*_nearLoc = nearestLocations [_Pos, ["CityCenter","NameCity", "NameCityCapital", "NameVillage"], worldSize]; 
private _selectLoc = selectRandom _nearLoc; 
_townPos = locationPosition _selectLoc; 
_townName = text _selectLoc; */

//create blacklist around existing mission
_blMissionAreaID = "blacklist_" + (str _pos);
_blMissionArea = createMarker [_blMissionAreaID, _pos];
_blMissionArea setMarkerShape "Ellipse";
_blMissionArea setMarkerAlpha 0;
_blMissionArea setMarkerSize [150, 150];

_mortarPitComp = [
	["Land_BagFence_01_round_green_F",[5.21777,1.3252,0.258686],0.245163,1,0,[0,0],"","",false,false], 
	["Land_BagFence_01_round_green_F",[5.38477,1.58008,0.553032],0.245163,1,0,[0,0],"","",false,false], 
	["B_T_Mortar_01_F",[5.55273,5.08105,-0.0384636],190.092,1,0,[-7.33755e-005,-0.00054824],"","",false,false], 
	["Land_ShellCrater_02_decal_F",[5.18359,6.20215,0.211864],0,1,0,[0,0],"","",false,false], 
	["Land_ShellCrater_02_extralarge_F",[5.84863,5.55957,-0.398991],0,1,0,[0,0],"","",false,false], 
	["Land_BagFence_01_round_green_F",[3.65137,9.08594,0.552737],145.451,1,0,[0,-0],"","",false,false], 
	["Land_ShellCrater_01_decal_F",[9.79395,-0.746094,-0.015892],45.6106,1,0,[0,0],"","",false,false], 
	["Land_BagFence_01_round_green_F",[9.82324,3.95313,0.505005],278.898,1,0,[0,0],"","",false,false], 
	["Land_BagFence_01_round_green_F",[6.14648,9.43945,0.67276],180.815,1,0,[0,0],"","",false,false], 
	["Land_PillboxWall_01_3m_round_F",[3.68262,13.5986,0.101776],193.617,1,0,[0,0],"","",false,false], 
	["Land_ShellCrater_01_decal_F",[14.5488,3.26758,-0.418457],45.6106,1,0,[0,0],"","",false,false], 
	["Land_CncShelter_F",[6.29199,13.6504,-0.257877],319.515,1,0,[0,0],"","",false,false], 
	["Land_PillboxWall_01_3m_round_F",[1.52734,15.0508,-0.0510139],243.39,1,0,[0,0],"","",false,false], 
	["Land_ShellCrater_01_decal_F",[3.30176,15.0059,0.211864],307.54,1,0,[0,0],"","",false,false], 
	["Land_BagFence_01_round_green_F",[15.4512,1.41797,0.300739],47.533,1,0,[0,0],"","",false,false], 
	["Land_CncShelter_F",[11.4473,11.4355,0.0579224],57.5862,1,0,[0,0],"","",false,false], 
	["Land_ShellCrater_01_decal_F",[1.74707,16.0215,0.211864],307.54,1,0,[0,0],"","",false,false], 
	["Land_ShellCrater_02_small_F",[16.542,2.93457,-0.166084],341.828,1,0,[0,0],"","",false,false], 
	["B_T_Mortar_01_F",[3.86816,16.0908,-0.0384674],0.65061,1,0,[-0.000208795,-3.82335e-005],"","",false,false], 
	["Land_ShellCrater_02_small_F",[16.6357,2.97266,-0.43082],341.828,1,0,[0,0],"","",false,false], 
	["Land_ShellCrater_02_small_F",[16.3301,2.59766,-0.0909195],80.2636,1,0,[0,0],"","",false,false], 
	["Land_ShellCrater_01_decal_F",[16.6084,3.37891,-0.43082],45.6106,1,0,[0,0],"","",false,false], 
	["Land_WoodenShelter_01_F",[16.7959,2.75879,-0.635231],131.929,1,0,[0,-0],"","",false,false], 
	["Land_ShellCrater_02_extralarge_F",[3.34375,16.6953,-0.331501],261.929,1,0,[0,0],"","",false,false], 
	["Land_PillboxWall_01_3m_round_F",[13.6553,10.8535,-0.44582],173.244,1,0,[0,-0],"","",false,false], 
	["Land_PillboxWall_01_3m_round_F",[6.60645,16.3984,-0.107895],75.1736,1,0,[0,0],"","",false,false], 
	["Land_ShellCrater_02_decal_F",[5.06543,16.8848,0.211864],261.929,1,0,[0,0],"","",false,false], 
	["Land_PillboxWall_01_3m_round_F",[1.23145,17.7266,-0.0875664],286.55,1,0,[0,0],"","",false,false], 
	["Land_PillboxWall_01_3m_round_F",[11.293,14.1416,-0.379986],291.688,1,0,[0,0],"","",false,false], 
	["Land_ShellCrater_01_decal_F",[2.95117,17.9785,0.210835],84.441,1,0,[0,0],"","",false,false], 
	["Land_BagFence_01_round_green_F",[18.0254,4.15918,0.263557],226.205,1,0,[0,0],"","",false,false], 
	["Land_ShellCrater_02_decal_F",[14.3516,12.3105,0.211864],0,1,0,[0,0],"","",false,false], 
	["Land_ShellCrater_01_decal_F",[12.7383,14.3203,0.211864],45.6106,1,0,[0,0],"","",false,false], 
	["Land_PillboxWall_01_3m_round_F",[5.3623,18.8311,-0.140007],48.7459,1,0,[0,0],"","",false,false], 
	["Land_PillboxWall_01_3m_round_F",[2.95508,19.5625,-0.015976],346.678,1,0,[0,0],"","",false,false], 
	["B_T_Mortar_01_F",[14.3652,13.4902,-0.038475],0.224412,1,0,[-0.00037292,-3.58753e-005],"","",false,false], 
	["Land_PillboxWall_01_3m_round_F",[16.2363,11.7441,-0.465725],146.817,1,0,[0,-0],"","",false,false], 
	["Land_ShellCrater_02_extralarge_F",[14.4053,14.042,-0.635506],0,1,0,[0,0],"","",false,false], 
	["Land_PillboxWall_01_3m_round_F",[13.0322,16.0713,-0.456577],341.461,1,0,[0,0],"","",false,false], 
	["Land_ShellCrater_01_decal_F",[13.9629,15.7168,0.211864],45.6106,1,0,[0,0],"","",false,false], 
	["Land_ShellCrater_01_decal_F",[15.7314,14.251,0.211864],182.512,1,0,[0,0],"","",false,false], 
	["Land_PillboxWall_01_3m_round_F",[17.2461,14.0156,-0.42268],84.7487,1,0,[0,0],"","",false,false], 
	["Land_PillboxWall_01_3m_round_F",[15.7217,15.9883,-0.505871],24.6208,1,0,[0,0],"","",false,false]
];

[_pos, (random 360), _mortarPitComp, 0] call BIS_fnc_objectsMapper;

_missionObjects = [];

_addObjs = _pos nearObjects 75;
{
	_missionObjects pushBack _x;
} forEach _addObjs;

_crate = rae_Crate createVehicle position player;
_missionObjects pushBack _crate;

//Create Task
_objTask = 	[
	true, 
	_missionID, 	
	[
		format [	
				"
					<br/>Mission:<br/>One of our friendly helo's, callsign Rodeo Six, was shot down. The pilot has been captured and moved to a building somewhere in the town of <marker name= '%1'>%2</marker>.
					<br/><br/>Execution:<br/>Heathen Teams are tasked to recon the village to locate the captured pilot then extract the pilot back to the HQ.
					<br/><br/>Administration:<br/>A friendly pilot is the target for this operation, the building the pilot is being held in will be heavily guarded.
				", 
				_blMissionAreaID, _gridPos
				],
		"Resupply Mortar Pit", 
		""
	], 
	objNull, "ASSIGNED" ,1, true, "", false	

] call BIS_fnc_taskCreate;

//Send JVMF Message
_objMSL = format ["%1MSL",round (getTerrainHeightASL _pos)];
_missionJVMF = [
	_missionID, // TITLE
	raeCallsignTOC, // SENDER
	"HAWK 1-1", // RECIPIENTS
	2, //MSG TYPE
	[
		_gridPos,
		_objMSL,
		"LZ BRONZE",
		"APPROACH FROM THE SOUTH", // description
		"WATCH FOR THINGS AND STUFF",
		"", // restrictions
		"",
		"",
		"",
		""
	], //MSG TEXT
	[_pos]
] call vtx_uh60_jvmf_fnc_attemptSendMessage;

waitUntil {(player distance _pos < 2000)};

_dis = [6,15] call BIS_fnc_randomInt;
_smokePos = [_pos, _dis, (random 360)] call BIS_fnc_relPos;
while {(player distance _pos > 50)} do {
	_smoke="SmokeShellPurple" createVehicle _smokePos;
	sleep 15;
};

waitUntil {(_crate distance _pos < 50) or _objTask call BIS_fnc_taskState == "Canceled"};

if (_crate distance _pos < 50) exitWith {
	[_objTask,"Succeeded"] remoteExec ["BIS_fnc_taskSetState", 0, true];
	
	sleep 4;
	[_objTask] remoteExec ["BIS_fnc_deleteTask", 0, true];
	waitUntil {{(_x distance _initialPos) >= 1500} forEach playableUnits};
	{
		deleteVehicle _x;
	} forEach _missionObjects;
	deleteMarker _blMissionAreaID;
	raeCurrentMissions - [_missionID];
	[_missionID] call rae_fnc_deleteJVMF;
	if (raeDebug) then {deleteMarker _missionID};
};

if (_objTask call BIS_fnc_taskState == "Canceled") exitWith {
	sleep 4;
	[_objTask] remoteExec ["BIS_fnc_deleteTask", 0, true];
	waitUntil {{(_x distance _initialPos) >= 1500} forEach playableUnits};
	{
		deleteVehicle _x;
	} forEach _missionObjects;
	deleteMarker _blMissionAreaID;
	raeCurrentMissions - [_missionID];
	[_missionID] call rae_fnc_deleteJVMF;
	if (raeDebug) then {deleteMarker _missionID};
};

//End