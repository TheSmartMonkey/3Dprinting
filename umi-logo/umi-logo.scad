$fn = 100;

/** CONTANTS **/
LETTER_LENGTH=30;
LETTER_RADIUS=20;
LETTER_HEIGHT=30;


/** MODULES **/
module letterU() {
    difference() {
        letterUCylinder(LETTER_LENGTH,LETTER_RADIUS,LETTER_HEIGHT);
        translate([0,0,-1]) letterUCylinder(LETTER_LENGTH+1,LETTER_RADIUS-8,LETTER_HEIGHT+2);
    }
}

module letterM() {
    translate([LETTER_LENGTH,0,LETTER_HEIGHT]) rotate([0,180,0]) letterU();
    translate([LETTER_LENGTH,-LETTER_HEIGHT-2.5,LETTER_HEIGHT]) rotate([0,180,0]) letterU();
}


/** HELPERS **/
module letterUCylinder(lenght,radius,height) {
    cylinder(h=height,r=radius);
    translate([0,-radius,0]) cube([lenght,2*radius,height]);
}

/** VIEW **/
assembling = 1;
if (assembling == 1) {
    translate([20,0,0]) letterU();
    translate([0,-50,0]) letterM();
} else if (assembling == 2) {
    letterU();
} else if (assembling == 3) {
    letterM();
}
