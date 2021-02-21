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

// Metal barres
METAL_BAR_RADIUS = 2.5;
METAL_BAR_HEIGHT = 20;

/** Canon hook **/
// Core
module canonHook() {
    color("LightGreen") {
        difference() {
            union() {
                cube([HOOK_LENGTH, HOOK_WIDTH, HOOK_HEIGHT]);
                translate([4, HOOK_WIDTH / 2 + 1.5 / 2, HOOK_HEIGHT]) curveHook(1.5, HOOK_FIX_HEIGHT);
                translate([HOOK_HOLE_LEFT - HOOK_FIX_HEIGHT - 4 , HOOK_WIDTH - 4 +2, HOOK_HEIGHT]) fixHook(HOOK_WIDTH - 4, HOOK_FIX_HEIGHT);
            }
            union() {
                translate([HOOK_HOLE_LEFT - 4, 2, -1]) cube([HOOK_WIDTH - 3, HOOK_WIDTH - 4, 20]);
                translate([HOOK_HOLE_LEFT, 20, HOOK_HEIGHT / 2]) rotate([90, 0, 0]) cylinder(h=30, r=HOOK_HOLE);
            }
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
            cube([FRONT_WEAPON_FIX_LENGTH, WEAPON_FIX_WIDTH, WEAPON_FIX_HEIGHT + 6]);
            union() {
                translate([-5, FRONT_HOLE_DEPTH, FRONT_HOLE_HEIGHT]) cube([FRONT_WEAPON + 20, WEAPON_FIX_WIDTH, WEAPON_FIX_HEIGHT - 5]);
                balckHole();
                metalBarsHole();

                // Fixes to rail
                railFixLength = 5 + (ENCOCHE_LENGTH / 2);
                translate([20, WEAPON_FIX_WIDTH - railFixLength + 0.01, WEAPON_FIX_HEIGHT]) cube([25, railFixLength + 0.5, 3.5]);
                translate([80, WEAPON_FIX_WIDTH - railFixLength + 0.01, WEAPON_FIX_HEIGHT]) cube([25, railFixLength + 0.5, 3.5]);
            }
        }
    }
}

module weaponBackFix() {
    color("LightBlue") {
        difference() {
            translate([FRONT_WEAPON_FIX_LENGTH, 0, -6]) cube([BACK_FIX_LENGHT + 2, ENCOCHE_WIDTH / 2, WEAPON_FIX_HEIGHT + 6]);
            union() {
                balckHole();
                metalBarsHole();
            }
        }
    }
}

module balckHole() {
    translate([125, -0.1, -10]) cube([BACK_HOLE_LENGHT - 20, BACK_HOLE_WIDTH + 10, BACK_HOLE_HEIGHT + 10]);
}

module metalBarsHole() {
    middle = FRONT_WEAPON_FIX_LENGTH - METAL_BAR_HEIGHT / 2;
    centerWidth = (ENCOCHE_WIDTH / 2) / 2;
    translate([middle, centerWidth, 25]) rotate([0, 90, 0]) cylinder(h=METAL_BAR_HEIGHT, r=METAL_BAR_RADIUS);
    translate([middle, centerWidth, 15]) rotate([0, 90, 0]) cylinder(h=METAL_BAR_HEIGHT, r=METAL_BAR_RADIUS);
}

/** Holder **/
// Rail : https://pinshape.com/items/53040-3d-printed-kar98k-picattiny-rail
module rail() {
    color("LightGrey") {
        union() {
            translate([0, ENCOCHE_LENGTH / 2, 0]) cube([RAIL_LENGTH, RAIL_WIDTH - ENCOCHE_LENGTH, RAIL_HEIGHT]);

            // Create all the encoches
            separator = 0;
            for (i = [0:1:12]) {
                translate([separator, RAIL_WIDTH / 2, RAIL_HEIGHT]) rotate([90, 0, 90]) encocheRail();
                separator = i * (ENCOCHE_SEPARATOR + ENCOCHE_LENGTH);
            }

            // Fixes to front weapon
            translate([20, -5, 0]) cube([25, 10, 3]);
            translate([80, -5, 0]) cube([25, 10, 3]);
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
    translate([FRONT_WEAPON_FIX_LENGTH + BACK_FIX_LENGHT, 0, (ENCOCHE_WIDTH / 2) - 1.8]) rotate([-90, 0, 0]) canonHook();
} else {
    canonHook();
    translate([0, 50, 0]) rail();
    translate([0, 100, 0]) weaponFrontFix();
    translate([0, 200, 0]) weaponBackFix();
}
