$fn = 100;

/** MESURSES **/
// Weapon fix
FRONT_WEAPON_FIX_LENGTH = 130;
BACK_WEAPON_FIX_LENGTH = 170;
WEAPON_SEPARATOR = FRONT_WEAPON_FIX_LENGTH + (BACK_WEAPON_FIX_LENGTH - HOOK_LENGTH);
WEAPON_FIX_WIDTH = 15;
WEAPON_FIX_HEIGHT = 30;


/** Front Weapon Fix **/
module weaponFrontFix() {
    cube([FRONT_WEAPON_FIX_LENGTH, WEAPON_FIX_WIDTH, WEAPON_FIX_HEIGHT + 6]);
}

/** VIEW **/
assembling = 1;
if (assembling == 1) {
    weaponFrontFix();
}
