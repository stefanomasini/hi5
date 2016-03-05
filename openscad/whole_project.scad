include <constants.scad>;
include <utilities.scad>;
use <2dhand.scad>;
use <hinge.scad>;
use <base.scad>;


module hand3d() {
    linear_extrude(height=arm_thickness) hand2d();
}


// hand
translate([0, arm_thickness, 0]) rotate([90, 0, 0]) hand3d();

// hinge
translate([arm_width, 0, 0]) rotate([0, -90, 0]) hinge();

// axle
translate([-(axle_length - arm_width)/2, arm_thickness/2, -hinge_arm_housing_allowance/2 - holder_thickness - axle_diameter/2 - hinge_axle_housing_allowance/2]) rotate([0, 90, 0]) cylinder(r=axle_diameter/2, h=axle_length, $fs=cylinder_precision);

// base
translate([-(axle_length - arm_width)/2, -base_distance_to_axle_center + arm_thickness/2, -base_distance_to_axle_center - (hinge_arm_housing_allowance/2 + holder_thickness + axle_diameter/2 + hinge_axle_housing_allowance/2)]) base();
