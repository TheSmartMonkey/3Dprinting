$fn = 100;

/** VARIABLES **/
// Rail
LONGEUR_RAIL = 125.23;
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


/** Porte Lunette **/
// Rail
module rail() {
    cube([LONGEUR_RAIL, LARGEUR_RAIL, HAUTEUR_RAIL]);
    translate([0, 0, HAUTEUR_RAIL]) encocheOfRail();
}

module encocheOfRail() {
    difference() {
        difference() {
            difference() {
                cube([LONGEUR_ENCOCHE, LARGEUR_RAIL, HAUTEUR_ENCOCHE]); // Primary shape
                translate([-1, 0, 0]) rotate([40, 0, 0]) cube([10, 20, 5]); // Border
            }
            translate([-1, 15.25, 5]) rotate([-40, 0, 0]) cube([10, 20, 5]); // Border
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
