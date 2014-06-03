// Despawn AI around safezones (Lunchbox). You're welcome.
if (isNil 'no_ai_loop') then {no_ai_loop = true;};
		while {true} do {
			waitUntil { !canbuild };
			_pos = getPosATL (vehicle player);
			_ai = _pos nearEntities ["Man",350]; // Change number for range. 
			{if ((!isPlayer _x) && (!isAgent _x)) then {deletevehicle _x;};} forEach _ai;
			sleep 1;
				};
