include <constants.scad>;

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
        translate([radius, radius]) circle(r=radius, $fs=cylinder_precision);
        translate([width-radius, radius]) circle(r=radius, $fs=cylinder_precision);
        translate([radius, height-radius]) circle(r=radius, $fs=cylinder_precision);
        translate([width-radius, height-radius]) circle(r=radius, $fs=cylinder_precision);
    }
}

first_mounting_hole_left = (arm_width - mounting_holes_spacing * (mounting_holes-1)) / 2;
arm_housing_space = arm_thickness+hinge_arm_housing_allowance;
holder_thickness = (hinge_thickness-arm_housing_space)/2;
base_distance_to_axle_center = hinge_thickness / 2 + base_hinge_allowance;
small_servo_holder_base_to_arm_distance = small_servo_axle_top_distance_from_holder_base+servo_holder_thickness;
big_servo_holder_base_to_arm_distance = big_servo_axle_top_distance_from_holder_base+servo_holder_thickness;
small_servo_holder_width = small_servo_width + servo_holder_thickness*2;
big_servo_holder_width = big_servo_width + servo_holder_thickness*2;
spring_hook_hole_distance_from_arm = spring_hook_width - spring_hook_height / 2;
