$fn = 200;

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

module letterI() {
    cube([LETTER_LENGTH+20,LETTER_RADIUS/2-2,LETTER_HEIGHT]);
}

module letterIPunct() {
    arc();
}

module bousole() {
        rotate([0,0,0]) linear_extrude(5) polygon([[-10,0], [0,-5], [10,0], [0,5]]);
}

/** HELPERS **/
module letterUCylinder(lenght,radius,height) {
        cylinder(h=height,r=radius);
        translate([0,-radius,0]) cube([lenght,2*radius,height]);
}

module arc() {
    difference() {
        cylinder(h=LETTER_HEIGHT,r=LETTER_RADIUS);
        translate([0,0,-1]) cylinder(h=LETTER_HEIGHT+2,r=LETTER_RADIUS-2);
        translate([-20,0,-1]) cube([10,20,LETTER_HEIGHT+2]);
    }
}

/** VIEW **/
assembling = ;
if (assembling == 1) {
    color(c="LightBlue") {
        translate([20,0,0]) letterU();
        translate([0,-50,0]) letterM();
        translate([0,-125,0]) letterI();
    }
    color(c="Gold") {
        translate([60,-130,0]) letterIPunct();
        translate([60,-130,0]) bousole();
    }
} else if (assembling == 2) {
    letterU();
} else if (assembling == 3) {
    letterM();
} else if (assembling == 4) {
    letterI();
} else if (assembling == 5) {
    letterIPunct();
    bousole();
}
