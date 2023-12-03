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
    letterIRadius=LETTER_RADIUS/2-2;
    difference() {
        cube([LETTER_LENGTH+20,letterIRadius,LETTER_HEIGHT]);
        translate([70,letterIRadius/2,0]) metalCylinder();
    }
}

module bousoleArc() {
    arcInc=12;
    color(c="Gold") difference() {
        difference() {
            cylinder(h=LETTER_HEIGHT,r=LETTER_RADIUS+arcInc);
            translate([0,0,-1]) cylinder(h=LETTER_HEIGHT+2,r=LETTER_RADIUS+arcInc-2);
            translate([-35,-10,-1]) cube([30,50,LETTER_HEIGHT+2]);
        }
        metalCylinder();
    }
}

module bousole() {
    bousoleBlue();
    bousoleYellow();
}

module bousoleBlue() {
    color(c="LightBlue") difference() {
        rotate([0,0,-35]) linear_extrude(LETTER_HEIGHT) polygon([[-BOUSOLE_LENGTH,0], [0,-BOUSOLE_WIDTH], [0,0], [0,BOUSOLE_WIDTH]]);
        metalCylinder();
    } 
}

module bousoleYellow() {
    color(c="Gold") difference() {
        rotate([0,0,-35]) linear_extrude(LETTER_HEIGHT) polygon([[0,0], [0,-BOUSOLE_WIDTH], [BOUSOLE_LENGTH,0], [0,BOUSOLE_WIDTH]]);
        metalCylinder();
    } 
}

/** HELPERS **/
module letterUCylinder(lenght,radius,height) {
    cylinder(h=height,r=radius);
    translate([0,-radius,0]) cube([lenght,2*radius,height]);
}

module metalCylinder() {
    translate([-30,0,LETTER_HEIGHT/2-0.25]) rotate([0,90,0]) cylinder(h=100,r=0.5);
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
} else if (assembling == 6) {
    bousoleBlue();
} else if (assembling == 7) {
    bousoleYellow();
}
