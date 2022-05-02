params ["_missionID"];

_idx = 0;
for "_i" from 0 to (count VTX_JVMF_MESSAGES) do {
	_array = VTX_JVMF_MESSAGES # _i;
	_id = _array # 0;
	if (_id == _missionID) exitWith {_idx = _i;};
};
_del = VTX_JVMF_MESSAGES deleteAt _idx;
true