$fn = 100;

/** VARIABLES **/
RAIL_LENGTH = 124.9;
RAIL_WIDTH = 21.2;
RAIL_HEIGHT = 8.6;

ENCOCHE_LENGTH = 4.78;
ENCOCHE_WIDTH = 15.6;
ENCOCHE_HEIGHT = 2.8;
ENCOCHE_SEPARATOR = 5.23;
ENCOCHE_ANGLE_SIZE = (RAIL_WIDTH - ENCOCHE_WIDTH) / 2; // =2.8
ENCOCHE_HOLE = 3;


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
// Rail : https://pinshape.com/items/53040-3d-printed-kar98k-picattiny-rail
module rail() {
    translate([0, ENCOCHE_LENGTH / 2, 0]) cube([RAIL_LENGTH, RAIL_WIDTH - ENCOCHE_LENGTH, RAIL_HEIGHT]);

    // Create all the encoches
    separator = 0;
    for (i = [0:1:12]) {
        translate([separator, RAIL_WIDTH / 2, RAIL_HEIGHT]) rotate([90, 0, 90]) encocheRail();
        separator = i * (ENCOCHE_SEPARATOR + ENCOCHE_LENGTH);
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
assembling = false;
if (assembling) {
    canonHook();
} else {
    // canonHook();
    translate([0, 100, 0]) rail();
}
