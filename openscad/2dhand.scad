// structural parameters (can play with these)
arm_length = 130;
arm_width = 40;
palm_width = 60;

mounting_hole_diameter = 5;
mounting_holes_spacing = 20; // center to center
mounting_holes_distance_from_bottom = 10;

spring_hook_distance = 100;
spring_hook_width = 10;
spring_hook_height = 8;
spring_hook_hole_diameter = 3;
spring_hook_hole_distance_from_side = (spring_hook_height-spring_hook_hole_diameter)/2;

// aesthetic parameters (best not to change)
fingers_gap = palm_width / 30;
palm_height = palm_width / 6 * 5;
rounding_radius = palm_width / 6;
finger_length_perc = [1.25, 1.3, 1.4, 1.35, 1.2];

// --------------------------------------------------


// arm
first_mounting_hole_left = (arm_width - mounting_holes_spacing - mounting_hole_diameter) / 2 + mounting_hole_diameter / 2;
difference() {
    square(size = [arm_width, arm_length]);
    translate([first_mounting_hole_left, mounting_holes_distance_from_bottom]) circle(r=mounting_hole_diameter/2);
    translate([first_mounting_hole_left+mounting_holes_spacing, mounting_holes_distance_from_bottom]) circle(r=mounting_hole_diameter/2);
}

// spring hook
translate([-spring_hook_width, spring_hook_distance]) {
    difference() {
        roundedBox(spring_hook_width*2, spring_hook_height, spring_hook_height/2);
        translate([spring_hook_hole_distance_from_side + spring_hook_hole_diameter/2, spring_hook_hole_distance_from_side + spring_hook_hole_diameter/2]) circle(r = spring_hook_hole_diameter/2);
    }
}

// palm
palm_left = -(palm_width-arm_width)/2;
palm_base = arm_length;
translate([palm_left, palm_base]) roundedBox(palm_width, palm_height, rounding_radius);

// fingers
fingerSpace = (palm_width+fingers_gap)/4;
fingerWidth = fingerSpace - fingers_gap;
// thumb
translate([palm_left, palm_base]) rotate([0, 0, 20]) roundedBox(fingerWidth*1.1, palm_height*finger_length_perc[0], fingerWidth/2);

// front fingers
for (fingerIdx=[0,1,2,3]) {
    translate([palm_left + fingerSpace*fingerIdx, palm_base+palm_height-palm_width/4]) roundedBox(fingerWidth, palm_height*finger_length_perc[1+fingerIdx], fingerWidth/2);
}


// --------------------------------------------------

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

