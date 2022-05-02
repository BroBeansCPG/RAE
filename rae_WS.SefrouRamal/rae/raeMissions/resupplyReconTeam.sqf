//Resupply Recon Team

if !(isServer) exitWith {}; 

//Find Location & POI
_mapCentre = [worldSize / 2, worldsize / 2, 0]; 
_pos = [_mapCentre, 1000, raeMaxRange, 0, 200, 0.5, 0, raeBlacklist, [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
_gridPos = mapGridPosition _pos;

private _missionID = "resupplyReconTeam" + (str _pos);
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

_reconVehicleComp = [
	[(selectRandom rae_BsfUnits),[2.38428,-2.30859,-3.8147e-006],213,1,0,[-0.000130694,0.0059443],"","_this switchMove ""amovPsitMstpSlowWrflDnon_Smoking"";",true,false], 
	["Land_PortableCabinet_01_closed_sand_F",[3.15967,-1.75293,0],119.05,1,0,[-0.28955,-0.422777],"","",false,false], 
	["Land_MultiScreenComputer_01_sand_F",[3.12646,-1.74805,0.318615],116.003,1,0,[0,-0],"","",false,false], 
	[(selectRandom rae_BsfUnits),[-1.64746,4.15625,-3.8147e-006],230,1,0,[-0.229608,0.237611],"","_this switchMove ""c4coming2cDf_genericstani1"";",true,false], 
	[(selectRandom rae_BsfUnits),[1.38721,-4.30859,-7.62939e-006],15,1,0,[-0.000198623,0.237516],"","_this switchMove ""AA_XOutroLamb"";",true,false], 
	["OmniDirectionalAntenna_01_black_F",[4.07666,-0.691406,-0.3],0.0213465,1,0,[-0.226045,0.460607],"","",false,false], 
	[(selectRandom rae_BsfVehicles),[6.32324,0.459961,-0.0215187],100,1,0,[-0.363062,-0.817598],"","",true,false], 
	[(selectRandom rae_BsfVehicles),[1.19531,7.49609,-0.0114937],0.0116689,1,0,[-1.16597,2.06755],"","",true,false]
];

[_pos, (random 360), _reconVehicleComp, 0] call BIS_fnc_objectsMapper;

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
		"Resupply Recon Element", 
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
		"LZ KILO",
		"NOMAD 1-2 is requesting a", // description
		"resupply at the following grid.",
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
	[_missionID] call rae_fnc_deleteJVMF;
	if (raeDebug) then {deleteMarker _missionID};
};