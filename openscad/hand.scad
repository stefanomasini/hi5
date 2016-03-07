include <constants.scad>;
include <utilities.scad>;


module hand2d() {
    // arm
    difference() {
        square(size = [arm_width, arm_length]);
        for (holeIdx=[0 : mounting_holes-1]) {
            translate([first_mounting_hole_left+mounting_holes_spacing*holeIdx, mounting_holes_distance_from_bottom]) circle(r=screw_diameter/2, $fs=cylinder_precision);
        }
    }

    // spring hook
    spring_hook_hole_distance_from_side = (spring_hook_height-spring_hook_hole_diameter)/2;
    translate([-spring_hook_width, spring_hook_distance]) {
        difference() {
            roundedBox(spring_hook_width*2, spring_hook_height, spring_hook_height/2);
            translate([spring_hook_hole_distance_from_side + spring_hook_hole_diameter/2, spring_hook_hole_distance_from_side + spring_hook_hole_diameter/2]) circle(r = spring_hook_hole_diameter/2, $fs=cylinder_precision);
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
}

module hand3d() {
    linear_extrude(height=arm_thickness) hand2d();
}


hand2d();
