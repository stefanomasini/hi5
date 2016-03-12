include <constants.scad>;
include <utilities.scad>;
use <hand.scad>;
use <hinge.scad>;
use <base.scad>;
use <picase.scad>;


module centerAxle() {
    translate([0, -arm_thickness/2, hinge_arm_housing_allowance/2 + holder_thickness + axle_diameter/2 + hinge_axle_housing_allowance/2]) children();
}

rotate([-arm_ready_degrees])
centerAxle() {
    // hand
    translate([0, arm_thickness, 0]) rotate([90, 0, 0]) hand3d();
    // hinge
    translate([arm_width, 0, 0]) rotate([0, -90, 0]) hinge();
}


centerAxle() {
    // axle
    translate([-(axle_length - arm_width)/2, arm_thickness/2, -hinge_arm_housing_allowance/2 - holder_thickness - axle_diameter/2 - hinge_axle_housing_allowance/2]) rotate([0, 90, 0]) cylinder(r=axle_diameter/2, h=axle_length, $fs=cylinder_precision);

    // base
    translate([-(axle_length - arm_width)/2, -base_distance_to_axle_center + arm_thickness/2, -base_distance_to_axle_center - (hinge_arm_housing_allowance/2 + holder_thickness + axle_diameter/2 + hinge_axle_housing_allowance/2)]) base() {
        rotatedSpringServoArm(160); // spring servo arm
        rotatedHolderServoArm(90); // holding servo arm
    };
}

translate([-20, -70, -base_distance_to_axle_center+base_mount_length_to_axle])
    rotate([60, 0, 0])
        enclosureWrtToMountHoles();
