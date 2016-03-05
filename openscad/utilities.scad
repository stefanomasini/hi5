module bolt(diameter, depth) {
    translate([0, 0, depth/2]) union() {
        cube([diameter/1.75, diameter, depth], center=true);
        rotate([0, 0, 60]) cube([diameter/1.75, diameter, depth], center=true);
        rotate([0, 0, 120]) cube([diameter/1.75, diameter, depth], center=true);
    }
}

module roundedBox(width, height, radius) {
    union() {
        translate([radius, 0]) square([width-2*radius, height]);
        translate([0, radius]) square([width, height-2*radius]);
        translate([radius, radius]) circle(r=radius);
        translate([width-radius, radius]) circle(r=radius);
        translate([radius, height-radius]) circle(r=radius);
        translate([width-radius, height-radius]) circle(r=radius);
    }
}
