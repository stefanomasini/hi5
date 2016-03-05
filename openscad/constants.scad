// ================================================
// structural parameters (can play with these)
//

// arm
arm_length = 200;
arm_width = 60;
arm_thickness = 4;

// hand
palm_width = 100;

// spring hook
spring_hook_distance = 100;
spring_hook_width = 10;
spring_hook_height = 8;
spring_hook_hole_diameter = 3;

// mounting holes
mounting_holes = 3;
mounting_hole_diameter = 4;
mounting_holes_spacing = 18; // center to center
mounting_holes_distance_from_bottom = 10; // border to center
screw_head_diameter = 7;
bolt_diameter = 7;

// hinge
hinge_thickness = 16;
arm_housing_allowance = 1;
axle_diameter = 5;
axle_housing_allowance = 1;


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


// -------------------------------------

first_mounting_hole_left = (arm_width - mounting_holes_spacing * (mounting_holes-1)) / 2;
