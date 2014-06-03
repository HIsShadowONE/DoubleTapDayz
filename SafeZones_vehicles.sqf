// Godmode vehicle in safe zones (Lunchbox).
// How it works: When in safezone, vehicle takes no damage. However, When the player
// leaves the safezone with the car in the safezone, the car will take damage.
// This is to prevent abuses with the safezone system. 

if (isNil "canbuild") then {
	canbuild = true;
};

while {true} do {
        
        // Vehicle Godmode on.
	waitUntil { !canbuild };

	waitUntil { player != vehicle player };

	theVehicle = vehicle player;
	
	theVehicle removeAllEventHandlers "handleDamage";
	theVehicle addEventHandler ["handleDamage", {false}];
	theVehicle allowDamage false;
	
	fnc_usec_damageVehicle ={};
	vehicle_handleDamage ={};
	vehicle_handleKilled ={};
	// hintSilent "Vehicle godmode ON"; // Uncomment this to help see when it actually turns on and off
	
	waitUntil { canbuild };
	
	// Vehicle Godmode off. 
	
	theVehicle removeAllEventHandlers "handleDamage";
        theVehicle addEventHandler ["handleDamage", {_this select 2}];
	theVehicle allowDamage true;
	
	// Call global scripts. 
	fnc_usec_damageVehicle = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_damageHandlerVehicle.sqf";
	vehicle_handleDamage = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\vehicle_handleDamage.sqf";
	vehicle_handleKilled = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\vehicle_handleKilled.sqf";
	// hintSilent "Vehicle godmode OFF"; // Uncomment this to help see when it actually turns on and off
	
};


// edit by infiSTAR.de - No DMG if   vehicle is Locked & has no crew & has a Plot within 50m. OR within 120m of Safezone
private["_unit","_selection","_strH","_total","_damage","_needUpdate"];
_unit = _this select 0;
_selection = _this select 1;
_total = _this select 2;
 
_state = false;
{
        if (_unit distance _x < 120) exitWith {_state = true;};
} forEach [[4361,2259],[13532.614,6355.9497],[7989.3354,2900.9946],
        [12060.471,12638.533],[1606.6443,7803.5156],[11447.91,11364.536],
        [13441.16,5429.3013],[12944.227,12766.889],[10066.4,5434.24],[2306.17,9633.46],
        [4065.87,10818.9],[3332.07,3923.91],[6326.4805,7809.4888],[1704.5732,12841.845]];
if ((locked _unit && (count (crew _unit)) == 0) || (_state))) exitWith {};
if (_selection != "") then
{
        _strH = "hit_" + _selection;
}
else
{
        _strH = "totalDmg";
};
if (_total >= 0.98) then
{
        _total = 1.0;
};
if (local _unit) then
{
        if (_total > 0) then
        {
                _unit setVariable [_strH, _total, true];
                _unit setHit [_selection, _total];
                if (isServer) then
                {
                        [_unit, "damage"] call server_updateObject;
                }
                else
                {
                        PVDZE_veh_Update = [_unit,"damage"];
                        publicVariableServer "PVDZE_veh_Update";
                };
        };
}
else
{
        PVDZE_send = [_unit,"VehHandleDam",_this];
        publicVariableServer "PVDZE_send";
};
_total
