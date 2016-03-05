include <constants.scad>;
include <utilities.scad>;
use <2dhand.scad>;
use <hinge.scad>;


module hand3d() {
    linear_extrude(height=arm_thickness) hand2d();
}


translate([0, arm_thickness, 0]) rotate([90, 0, 0]) hand3d();
translate([arm_width, 0, 0]) rotate([0, -90, 0]) hinge();
