Private ["_EH_VFired"];

if (isNil "canbuild") then {
	canbuild = false;
};

while {true} do {
	waitUntil { !canbuild };

	waitUntil { player != vehicle player };

	theVehicle = vehicle player;
	_EH_VFired = theVehicle addEventHandler ["Fired", {
		titleText ["You can not fire your weapon in a safe zone.","PLAIN DOWN"]; titleFadeOut 4;
		NearestObject [_this select 0,_this select 4] setPos[0,0,0];
	}];

	theVehicle removeAllEventHandlers "handleDamage";
	theVehicle addEventHandler ["handleDamage", {false}];
	theVehicle allowDamage false;
	
	fnc_usec_damageVehicle ={};
	vehicle_handleDamage ={};
	vehicle_handleKilled ={};
	hintSilent "Vehicle godmode ON"; // Uncomment this to help see when it actually turns on and off
	
	waitUntil { canbuild };

	theVehicle removeEventHandler ["Fired", _EH_VFired];

	theVehicle removeAllEventHandlers "handleDamage";
        theVehicle addEventHandler ["handleDamage", {_this select 2}];
	theVehicle allowDamage true;
	
	fnc_usec_damageVehicle = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_damageHandlerVehicle.sqf";
	vehicle_handleDamage = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\vehicle_handleDamage.sqf";
	vehicle_handleKilled = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\vehicle_handleKilled.sqf";
	hintSilent "Vehicle godmode OFF"; // Uncomment this to help see when it actually turns on and off
	
};
