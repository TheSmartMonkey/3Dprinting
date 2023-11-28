$fn = 100;

/** CONTANTS **/

/** MODULES **/
module letterU() {
    difference() {
        letterUCylinder(30,20,30);
        translate([0,0,-1]) letterUCylinder(31,12,32);
    }
}

/** PRIVATE MODULES **/
module letterUCylinder(l,r,h) {
    cylinder(h=h,r=r);
    translate([0,-r,0]) cube([l,2*r,h]);
}

/** VIEW **/
assembling = 1;
if (assembling == 1) {
    letterU();
}
