      
// Added !canbuild check to make sure detain doesn't happen in safezones (Lunchbox). 

if (!canbuild) then { cutText [format["Cannot detain in safezones!"], "PLAIN"]; } else { 

// Well the script determined it could build, so lets arrest some people!

_newCiv = _this select 3;

detach _newCiv;// Just incase

// removing required...
player removeMagazine"equip_cable_tie";
playsound "cuffs";
sleep 1;

player playActionNow "Medic";
// Hint
cutText [format["Your hostage is tied up for the next 5 Minutes!"], "PLAIN"];
systemChat ('Your hostage is tied up for the next 5 Minutes!');

// Public Var
_newCiv setVariable ["Detain",1,true];
_newCiv setVariable ["Escort",0,true];

if (!isnil ("PVDZ_ply_Arrst")) then {
	// id removed from array
	_id = getPlayerUID _newCiv;
	PVDZ_ply_Arrst= [_id]+PVDZ_ply_Arrst;
	publicVariable "PVDZ_ply_Arrst";
} else {
	_id = getPlayerUID _newCiv;
	PVDZ_ply_Arrst= [_id];
	publicVariable "PVDZ_ply_Arrst";
};

//animation sitting arrested
//[objNull, _newCiv, rswitchmove ,"CivilSitting"] call RE;

};
