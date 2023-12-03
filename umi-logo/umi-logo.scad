$fn = 200;

/** CONTANTS **/
LETTER_LENGTH=30;
LETTER_RADIUS=20;
LETTER_HEIGHT=30;

BOUSOLE_LENGTH=13;
BOUSOLE_WIDTH=7;


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

module letterI() {
    cube([LETTER_LENGTH+20,LETTER_RADIUS/2-2,LETTER_HEIGHT]);
}

module bousoleArc() {
    arcInc=12;
    color(c="Gold") difference() {
        cylinder(h=LETTER_HEIGHT,r=LETTER_RADIUS+arcInc);
        translate([0,0,-1]) cylinder(h=LETTER_HEIGHT+2,r=LETTER_RADIUS+arcInc-2);
        translate([-35,-10,-1]) cube([30,50,LETTER_HEIGHT+2]);
    }
}

module bousole() {
    bousole1();
    bousole2();
}

module bousole1() {
    color(c="LightBlue") rotate([0,0,-35]) {
        linear_extrude(LETTER_HEIGHT) polygon([[-BOUSOLE_LENGTH,0], [0,-BOUSOLE_WIDTH], [0,0], [0,BOUSOLE_WIDTH]]);
    } 
}

module bousole2() {
    color(c="Gold") rotate([0,0,-35]) {
        linear_extrude(LETTER_HEIGHT) polygon([[0,0], [0,-BOUSOLE_WIDTH], [BOUSOLE_LENGTH,0], [0,BOUSOLE_WIDTH]]);
    } 
}

/** HELPERS **/
module letterUCylinder(lenght,radius,height) {
    cylinder(h=height,r=radius);
    translate([0,-radius,0]) cube([lenght,2*radius,height]);
}

/** VIEW **/
assembling = 1;
if (assembling == 1) {
    color(c="LightBlue") {
        translate([20,0,0]) letterU();
        translate([0,-50,0]) letterM();
        translate([0,-125,0]) letterI();
    }
    translate([65,-121,0]) {
        bousoleArc();
        bousole();
    }
} else if (assembling == 2) {
    letterU();
} else if (assembling == 3) {
    letterM();
} else if (assembling == 4) {
    letterI();
} else if (assembling == 5) {
    bousoleArc();
    bousole();
}
