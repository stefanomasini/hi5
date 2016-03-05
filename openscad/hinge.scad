include <constants.scad>;
include <utilities.scad>;

module hinge() {
    axle_hole_diameter = axle_diameter + hinge_axle_housing_allowance;
    axle_section_size = axle_hole_diameter / 2 + hinge_thickness;
    bolt_housing_depth = holder_thickness / 3;
    housing_depth = mounting_holes_distance_from_bottom*2 + hinge_arm_housing_allowance/2;

    translate([-holder_thickness-hinge_arm_housing_allowance/2, -holder_thickness-hinge_arm_housing_allowance/2, 0]) {
        difference() {
            // Body of the hinge
            cube([holder_thickness + housing_depth, hinge_thickness, arm_width]);

            // Housing for the arm
            translate([holder_thickness, holder_thickness, -abbundance_for_subtraction]) cube([housing_depth+abbundance_for_subtraction, arm_housing_space, arm_width+2*abbundance_for_subtraction]);

            // mouting holes
            for (holeIdx=[0 : mounting_holes-1]) {
                translate([mounting_holes_distance_from_bottom + hinge_arm_housing_allowance*2 + screw_diameter, 0, first_mounting_hole_left+mounting_holes_spacing*holeIdx]) {
                    rotate([-90, 0, 0]) union() {
                        // body of the screw
                        cylinder(r=screw_diameter/2, h=hinge_thickness, $fs=cylinder_precision);
                        // housing for screw head
                        translate([0, 0, -abbundance_for_subtraction]) cylinder(r1=screw_head_diameter/2, r2=0, h=screw_head_diameter/2, $fs=cylinder_precision);
                        // housing for bolts
                        translate([0, 0, hinge_thickness-bolt_housing_depth+abbundance_for_subtraction]) rotate([0, 0, 30]) bolt(screw_bolt_diameter, bolt_housing_depth);
                    }
                }
            }
        }

        // axle housing
        difference() {
            union() {
                translate([-axle_hole_diameter / 2, 0, 0]) cube([axle_hole_diameter / 2, hinge_thickness, arm_width]);
                translate([-axle_hole_diameter / 2, hinge_thickness/2, 0]) cylinder(r=hinge_thickness/2, h=arm_width, $fs=cylinder_precision);
            }
            translate([-axle_hole_diameter / 2, hinge_thickness/2, -abbundance_for_subtraction/2]) cylinder(r=axle_hole_diameter/2, h=arm_width+abbundance_for_subtraction, $fs=cylinder_precision);
        }
    }
}

hinge();
