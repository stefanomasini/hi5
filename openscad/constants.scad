// ================================================
// structural parameters (can play with these)
//

// arm
arm_length = 200;
arm_width = 60;
arm_thickness = 4;
arm_ready_degrees = 45;

// hand
palm_width = 100;

// spring hook
spring_hook_distance = 120;
spring_hook_width = 10;
spring_hook_height = 8;
spring_hook_hole_diameter = 3;

// mounting holes
mounting_holes = 3;
mounting_holes_spacing = 18; // center to center
mounting_holes_distance_from_bottom = 10; // border to center

// screws and bolts
screw_diameter = 4; // TODO: add some allowance for the 3D printer
screw_head_diameter = 7; // probably here too...
screw_bolt_diameter = 7; // TODO: add some allowance for the 3D printer

// hinge
hinge_thickness = 16;
hinge_arm_housing_allowance = 1;
hinge_axle_housing_allowance = 0.5;

// axle
axle_diameter = 3;
axle_length = 71;

// base
base_thickness = 5;
base_length = 100;
base_hinge_allowance = 2;
base_arm_horizontal_gap = 2;
base_axle_mount_allowance = 0.5;
base_axle_side_thickness = 3;

// small servo
small_servo_width = 12;
small_servo_length = 23;
small_servo_screws = 1; // number of screws on each side
small_servo_screw_diameter = 2;
small_servo_screws_distance_from_servo = 3; // from center
small_servo_distance_between_screws = 11;
small_servo_axle_distance_from_front = 5;
small_servo_axle_top_distance_from_holder_base = 17;

// big servo
big_servo_width = 20;
big_servo_length = 41;
big_servo_screws = 2; // number of screws on each side
big_servo_screw_diameter = 2; // TODO
big_servo_screws_distance_from_servo = 4; // from center
big_servo_distance_between_screws = 9.5;
big_servo_axle_distance_from_front = 10;
big_servo_axle_top_distance_from_holder_base = 15;

// servo holder
servo_holder_thickness = 10;

// spring servo arm
spring_servo_arm_width = 8;
spring_servo_arm_spring_hole_distance = 25;
spring_servo_arm_screw_diameter = 3;
spring_servo_arm_hole_diameter = 5;
spring_servo_arm_distance_between_screws = 10;
spring_servo_arm_thickness = 4;

// spring servo
spring_servo_distance_from_axle = 70;

// holder servo
holder_servo_gap_from_arm = 3;
holder_servo_distance = 80;

// holder servo arm
holder_servo_arm_spring_hole_distance = 16;

// ================================================
// aesthetic parameters (best not to change)
//
fingers_gap = palm_width / 30;
palm_height = palm_width / 6 * 5;
rounding_radius = palm_width / 6;
finger_length_perc = [1.25, 1.3, 1.4, 1.35, 1.2];


// ================================================
// technical parameters for rendering
//
cylinder_precision = 0.05;
abbundance_for_subtraction = 0.01;
