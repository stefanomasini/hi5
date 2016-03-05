include <constants.scad>;
include <utilities.scad>;


module base() {
    axle_side_exceedance = (axle_length - arm_width) / 2;
    base_side_width = base_axle_side_thickness + axle_side_exceedance - base_arm_horizontal_gap/2;
    axle_hole_diameter = axle_diameter+base_axle_mount_allowance;
    base_side_height = base_distance_to_axle_center * 2;

    difference() {
        // side axle holders
        union() {
            translate([-base_axle_side_thickness, 0, 0]) cube([base_side_width, base_side_height, base_side_height]);
            translate([axle_length - axle_side_exceedance + base_arm_horizontal_gap/2, 0, 0]) cube([base_side_width, base_side_height, base_side_height]);
        }
        // axle housing
        translate([-base_axle_mount_allowance, base_distance_to_axle_center, base_distance_to_axle_center]) rotate([0, 90, 0]) cylinder(r=axle_hole_diameter/2, h=axle_length + 2*base_axle_mount_allowance, $fs=cylinder_precision);
    }

    translate([-base_axle_side_thickness, 0, -base_thickness]) cube([base_axle_side_thickness*2 + axle_length, base_length, base_thickness]);
}

base();
