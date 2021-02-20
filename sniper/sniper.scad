$fn = 100;

/** MESURSES **/
// Hook
HOOK_LENGTH = 44;
HOOK_WIDTH = 12;
HOOK_HEIGHT = 6.5;
HOOK_FIX_HEIGHT = 5;
HOOK_HOLE = 2.5;
HOOK_HOLE_RIGHT = 6.5;
HOOK_HOLE_LEFT = 35;

// Rail
RAIL_LENGTH = 124.9;
RAIL_WIDTH = 21.2;
RAIL_HEIGHT = 8.6;

// Encoche
ENCOCHE_LENGTH = 4.78;
ENCOCHE_WIDTH = 15.6;
ENCOCHE_HEIGHT = 2.8;
ENCOCHE_SEPARATOR = 5.23;
ENCOCHE_ANGLE_SIZE = (RAIL_WIDTH - ENCOCHE_WIDTH) / 2; // =2.8
ENCOCHE_HOLE = 3;

// Weapon fix
FRONT_WEAPON_FIX_LENGTH = 130;
BACK_WEAPON_FIX_LENGTH = 170;
WEAPON_SEPARATOR = FRONT_WEAPON_FIX_LENGTH + (BACK_WEAPON_FIX_LENGTH - HOOK_LENGTH);
WEAPON_FIX_WIDTH = 15;
WEAPON_FIX_HEIGHT = 30;

// Front weapon fix holes
FRONT_WEAPON = 70;
FRONT_HOLE = 15;
FRONT_HOLE_DEPTH = 5;
FRONT_HOLE_HEIGHT = 2;

// Back weapon fix holes
BACK_FIX_LENGHT = 98;
BACK_HOLE_LENGHT = 110;
BACK_HOLE_WIDTH = 8;
BACK_HOLE_HEIGHT = 10;

/** Canon hook **/
// Core
module canonHook() {
    color("LightGreen") {
        union() {
            difference() {
                difference() {  
                    cube([HOOK_LENGTH, HOOK_WIDTH, HOOK_HEIGHT]);
                    translate([HOOK_HOLE_LEFT - 4, 2, -1]) cube([HOOK_WIDTH - 3, HOOK_WIDTH - 4, 20]);
                }
                translate([HOOK_HOLE_LEFT, 20, HOOK_HEIGHT / 2]) rotate([90, 0, 0]) cylinder(h=30, r=HOOK_HOLE);
            }
            translate([4, HOOK_WIDTH / 2 + 1.5 / 2, HOOK_HEIGHT]) curveHook(1.5, HOOK_FIX_HEIGHT);
            translate([HOOK_HOLE_LEFT - HOOK_FIX_HEIGHT - 4 , HOOK_WIDTH - 4 +2, HOOK_HEIGHT]) fixHook(HOOK_WIDTH - 4, HOOK_FIX_HEIGHT);
        }
    }
}

// Curve to fit the holes
module curveHook(height, raduis) {
    difference() {
        rotate([90, 0, 0]) cylinder(h=height, r=raduis);
        translate([-HOOK_FIX_HEIGHT, -2, - raduis - 1]) cube([5, 5, 20]);
    }
}

// Fix to fit the holes
module fixHook(height, raduis) {
    difference() {
        rotate([90, 0, 0]) cylinder(h=height, r=raduis);
        translate([-5, -15, - raduis - 1]) cube([5, 20, 20]);
    }
}

/** Front Weapon Fix **/
module weaponFrontFix() {
    color("IndianRed") {
        difference() {
            difference() {
                cube([FRONT_WEAPON_FIX_LENGTH, WEAPON_FIX_WIDTH, WEAPON_FIX_HEIGHT + 6]);
                translate([-5, FRONT_HOLE_DEPTH, FRONT_HOLE_HEIGHT]) cube([FRONT_WEAPON_FIX_LENGTH + 20, WEAPON_FIX_WIDTH, WEAPON_FIX_HEIGHT - 5]);
            }
            balckHole();
        }
    }
}

module weaponBackFix() {
    color("LightBlue") {
        difference() {
            union() {
                translate([FRONT_WEAPON_FIX_LENGTH, 0, 0]) cube([BACK_FIX_LENGHT + 2, ENCOCHE_WIDTH / 2, WEAPON_FIX_HEIGHT + 6]);
            }
            balckHole();
        }
    }
}

module balckHole() {
    translate([125, -0.1, -0.1]) cube([BACK_HOLE_LENGHT - 20, BACK_HOLE_WIDTH + 10, BACK_HOLE_HEIGHT]);
}

/** Holder **/
// Rail : https://pinshape.com/items/53040-3d-printed-kar98k-picattiny-rail
module rail() {
    color("LightGrey") {
        translate([0, ENCOCHE_LENGTH / 2, 0]) cube([RAIL_LENGTH, RAIL_WIDTH - ENCOCHE_LENGTH, RAIL_HEIGHT]);

        // Create all the encoches
        separator = 0;
        for (i = [0:1:12]) {
            translate([separator, RAIL_WIDTH / 2, RAIL_HEIGHT]) rotate([90, 0, 90]) encocheRail();
            separator = i * (ENCOCHE_SEPARATOR + ENCOCHE_LENGTH);
        }
    }
}

module encocheRail() {
    linear_extrude(height = ENCOCHE_HEIGHT) {
        encocheRailPolygon();
        mirror([1,0,0]) {
            encocheRailPolygon();
        }
    }
} 

module encocheRailPolygon() {
    polygon(points=[ 
        [0, 0],
        [RAIL_WIDTH / 2 - ENCOCHE_LENGTH / 2, 0], 
        [RAIL_WIDTH / 2, ENCOCHE_LENGTH / 2],
        [RAIL_WIDTH / 2 - ENCOCHE_LENGTH / 2, ENCOCHE_LENGTH], 
        [ENCOCHE_HOLE / 2, ENCOCHE_LENGTH], 
        [ENCOCHE_HOLE / 2, ENCOCHE_LENGTH / 2], 
        [0, ENCOCHE_LENGTH / 2]
    ]);
}

/** VIEW **/
assembling = true;
if (assembling) {
    weaponFrontFix();
    weaponBackFix();
    translate([0, WEAPON_FIX_WIDTH - ENCOCHE_LENGTH / 2, WEAPON_FIX_HEIGHT]) rail();
    translate([FRONT_WEAPON_FIX_LENGTH + BACK_FIX_LENGHT, (HOOK_WIDTH / 2) + 0.5, 0]) rotate([90, 0, 0]) canonHook();
} else {
    canonHook();
    translate([0, 50, 0]) rail();
    translate([0, 100, 0]) weaponFrontFix();
    translate([0, 200, 0]) weaponBackFix();
}
