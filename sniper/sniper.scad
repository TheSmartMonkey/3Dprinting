$fn = 100;

/** VARIABLES **/
// Rail
LONGEUR_RAIL = 124.9;
LARGEUR_RAIL = 21.2;
HAUTEUR_RAIL = 8.6;

LONGEUR_ENCOCHE = 4.78;
LARGEUR_ENCOCHE = 15.6;
HAUTEUR_ENCOCHE = 2.8;
SEPARATION_ENCOCHE = 5.23;
TAILLE_ANGLE_ENCOCHE = (LARGEUR_RAIL - LARGEUR_ENCOCHE) / 2; // =2.8
HOLE_ENCOCHE = 3;


/** Canon hook **/
module canonHook() {
    difference() {
        difference() {  
            cube([50, 10, 15]);
            translate([30,-13,2]) cube([15, 30, 11]);
        }
        translate([37, 5, -10]) cylinder(h=30, r=3);
    }
}


/** Holder **/
// Rail
module rail() {
    difference() {
        cube([LONGEUR_RAIL, LARGEUR_RAIL, HAUTEUR_RAIL]);
        translate([-1, 22, 2.75]) rotate([40, 0, 0]) cube([LONGEUR_RAIL + 2, 20, 5]); // Border left
    }

    separator = 0;
    for (i = [0:1:12]) {
        translate([separator, 0, HAUTEUR_RAIL]) encocheOfRail();
        separator = i * (SEPARATION_ENCOCHE + LONGEUR_ENCOCHE);
    }
}

module encocheOfRail() {
    difference() {
        difference() {
            difference() {
                cube([LONGEUR_ENCOCHE, LARGEUR_RAIL, HAUTEUR_ENCOCHE]); // Primary shape
                translate([-1, 0, 0]) rotate([40, 0, 0]) cube([10, 20, 5]); // Border right
            }
            translate([-1, 15.25, 5]) rotate([-40, 0, 0]) cube([10, 20, 5]); // Border left
        }
        translate([-1, (LARGEUR_ENCOCHE + HOLE_ENCOCHE) / 2, -1]) cube([10, HOLE_ENCOCHE, 5]); // Hole
    }
}


/** VIEW **/
assemblage = false;
if (assemblage) {
    canonHook();
} else {
    // canonHook();
    translate([0, 100, 0]) rail();
}
