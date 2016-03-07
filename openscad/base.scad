include <constants.scad>;
include <utilities.scad>;

spring_servo_holder_degree = arm_ready_degrees/2;
servo_holder_distance = 50;

axle_side_exceedance = (axle_length - arm_width) / 2;
base_side_width = base_axle_side_thickness + axle_side_exceedance - base_arm_horizontal_gap/2;
axle_hole_diameter = axle_diameter+base_axle_mount_allowance;
base_side_height = base_distance_to_axle_center * 2;


servo_holder_length = servo_length + servo_screws_distance_from_servo*4;
first_screw_offset = (servo_holder_width - servo_distance_between_screws*(servo_screws-1)) / 2;
perforation_height = servo_holder_thickness + abbundance_for_subtraction*2;
axle_height = servo_holder_thickness + servo_axle_top_distance_from_holder_base;


module base() {
    difference() {
        // side axle holders
        union() {
            translate([-base_axle_side_thickness, 0, 0]) cube([base_side_width, base_side_height, base_side_height]);
            translate([axle_length - axle_side_exceedance + base_arm_horizontal_gap/2, 0, 0]) cube([base_side_width, base_side_height, base_side_height]);
        }
        // axle housing
        translate([-base_axle_mount_allowance, base_distance_to_axle_center, base_distance_to_axle_center]) rotate([0, 90, 0]) cylinder(r=axle_hole_diameter/2, h=axle_length + 2*base_axle_mount_allowance + axle_side_exceedance + abbundance_for_subtraction, $fs=cylinder_precision);
    }

    // base
    extra_width_for_spring_servo = spring_servo_arm_thickness/2 + servo_axle_top_distance_from_holder_base + servo_holder_thickness;
    translate([-base_axle_side_thickness - extra_width_for_spring_servo, 0, -base_thickness])
        cube([base_axle_side_thickness*2 + axle_length + extra_width_for_spring_servo + servo_width + servo_holder_thickness, base_length, base_thickness]);

    // spring servo holder
    springServoHolder() children(0);

    // stand of the spring servo holder
    difference() {
        linear_extrude(height=servo_holder_distance*2) projection() springServoHolder();
        placeSpringServoHolder() {
            servoHolder();
            translate([-(servo_holder_width/2), -(servo_screws_distance_from_servo*2 + servo_axle_distance_from_front), -servo_holder_base_to_arm_distance]) {
                translate([0, -servo_holder_distance, -servo_holder_thickness]) cube([servo_holder_width + servo_holder_distance, servo_holder_length + servo_holder_distance, servo_holder_thickness*3]);
            }
        }
    }

    // holder servo
    holderServoHolder() children(1);

    // stand of the holder servo holder
    difference() {
        linear_extrude(height=servo_holder_distance*2) projection()
        placeHolderServoHolder() {
            translate([-(servo_holder_width/2), -(servo_screws_distance_from_servo*2 + servo_axle_distance_from_front), -servo_holder_base_to_arm_distance]) {
                difference() {
                    cube([servo_holder_width, servo_holder_length, servo_holder_thickness]);
                    // hole for servo
                    translate([servo_holder_thickness, servo_screws_distance_from_servo*2, -abbundance_for_subtraction]) cube([servo_width, servo_length*2, perforation_height]);
                }
            }
        }
        placeHolderServoHolder() {
            translate([-(servo_holder_width/2), -(servo_screws_distance_from_servo*2 + servo_axle_distance_from_front), -servo_holder_base_to_arm_distance]) {
                translate([-servo_holder_width, 0, 0]) cube([servo_holder_width*3, servo_holder_distance*2, servo_holder_distance*2]);
            }
        }
    }
}

module placeHolderServoHolder() {
    translate([(axle_length - arm_width)/2 + arm_width + servo_holder_width/2 + holder_servo_gap_from_arm, base_distance_to_axle_center, base_distance_to_axle_center]) {
        rotate([-arm_ready_degrees, 0, 0])
        translate([0, -arm_thickness/2, holder_servo_distance])
        rotate([90, 0, 0]) {
            children();
        }
    }
}

module holderServoHolder() {
    placeHolderServoHolder() {
        servoHolder();
        children();
    }
}

module placeSpringServoHolder() {
    rotate([-spring_servo_holder_degree, 0, 0])
    translate([0, 0, servo_holder_distance])
    translate([(axle_length - arm_width)/2 - spring_hook_hole_distance_from_arm - spring_servo_arm_thickness, base_distance_to_axle_center, base_distance_to_axle_center]) {
        rotate([-spring_servo_holder_degree-90, 0, 0])
        rotate([0, 90, 0]) {
            children();
        }
    }
}

module springServoHolder() {
    placeSpringServoHolder() {
        servoHolder();
        children();
    }
}

module servoHolder() {
    translate([-(servo_holder_width/2), -(servo_screws_distance_from_servo*2 + servo_axle_distance_from_front), -servo_holder_base_to_arm_distance]) {
        difference() {
            cube([servo_holder_width, servo_holder_length, servo_holder_thickness]);
            // hole for servo
            translate([servo_holder_thickness, servo_screws_distance_from_servo*2, -abbundance_for_subtraction]) cube([servo_width, servo_length, perforation_height]);
            // holes for screws
            for (yOffset=[servo_screws_distance_from_servo, servo_screws_distance_from_servo*3 + servo_length]) {
                for (screwIdx=[0 : servo_screws-1]) {
                    translate([first_screw_offset + servo_distance_between_screws*screwIdx, yOffset, 0]) {
                        translate([0, 0, -abbundance_for_subtraction]) cylinder(r=servo_screw_diameter/2, h=perforation_height, $fs=cylinder_precision);
                    }
                }
            }
        }
    }
}


module servoArm2D(springHoleDistance, springHole) {
    translate([-spring_servo_arm_distance_between_screws/2 - spring_servo_arm_width/2, -spring_servo_arm_width/2]) {
        difference() {
            roundedBox(spring_servo_arm_width + springHoleDistance + spring_servo_arm_distance_between_screws/2, spring_servo_arm_width, spring_servo_arm_width/2);
            // first servo hole
            translate([spring_servo_arm_width/2, spring_servo_arm_width/2]) circle(r = spring_servo_arm_screw_diameter/2, $fs=cylinder_precision);
            // second servo hole
            translate([spring_servo_arm_width/2 + spring_servo_arm_distance_between_screws, spring_servo_arm_width/2]) circle(r = spring_servo_arm_screw_diameter/2, $fs=cylinder_precision);
            // spring servo hole
            if (springHole) {
                translate([spring_servo_arm_width/2 + spring_servo_arm_distance_between_screws/2 + springHoleDistance, spring_servo_arm_width/2]) circle(r = spring_servo_arm_hole_diameter/2, $fs=cylinder_precision);
            }
        }
    }
}

module springServoArm2D() {
    servoArm2D(springHoleDistance = spring_servo_arm_spring_hole_distance, springHole = true);
}

module springServoArm3D() {
    linear_extrude(height=spring_servo_arm_thickness) springServoArm2D();
}

module rotatedSpringServoArm(armDegrees) {
    rotate([0, 0, armDegrees+90]) springServoArm3D();
}


module holderServoArm2D() {
    servoArm2D(springHoleDistance = holder_servo_arm_spring_hole_distance, springHole = false);
}

module holderServoArm3D() {
    linear_extrude(height=spring_servo_arm_thickness) holderServoArm2D();
}

module rotatedHolderServoArm(armDegrees) {
    rotate([0, 0, armDegrees+90]) holderServoArm3D();
}


// --------------------------------

base();
