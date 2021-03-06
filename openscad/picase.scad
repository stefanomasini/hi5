include <constants.scad>;
include <utilities.scad>;


enclosure_thickness_bottom = 4; // TODO: verify the length of the screws
enclosure_thickness_top = 2;
enclosure_thickness_sides = 3;
display_hole_size = [68, 52];
display_hole_wrt_raspi = [10, 2.5];
raspi_size = [85, 56, 1];
raspi_pos_wrt_cavity = [3, 3, 2];
raspi_holes_left = 23;
raspi_holes_distance_from_border = 3.7;
raspi_supports_diameter = 5;
raspi_support_screws_diameter = 2;
raspi_front_mask_thickness = 2;
raspi_front_mask_height = 19;
raspi_front_mask_top_height = 8;
raspi_front_mask_snap_size = 1.5;
raspi_front_mark_snap_tolerance = 0.3;
display_board_distance_from_raspi = 20;
display_board_support_thickness = 3;
display_board_support_distance_from_raspi_base = 21.5;
distance_raspi_bottom_to_display_top = 28;
back_hole_width = 54;
back_hole_width_no_usb = 39;
back_hole_height = 12;
back_hole_extra_size = 1;
back_hole_distance_from_front_raspi = 27;
enclosure_cavity = [97, 62, raspi_pos_wrt_cavity[2]+distance_raspi_bottom_to_display_top];
buttons_distance_from_raspi_left = 3;
first_button_distance_from_raspi_bottom = 9.5;
buttons_distance_from_each_other = 14;
buttons_diameter = 6;
buttons_distance_from_screen_surface = 2;
buttons_top_overflow = 2;
buttons_holes_abbundance = 0.5;
top_cut_height_sides = display_board_support_distance_from_raspi_base+raspi_pos_wrt_cavity[2]+1;
top_cut_height_back = 10;
closing_tab_size = 10;
closing_screw_diameter = 3;
closing_screw_head_diameter = 7;
closing_screw_height = top_cut_height_back + 5;



module enclosureBottomWrtCavity() {
    difference() {
        translate([-enclosure_thickness_sides, -enclosure_thickness_sides, -enclosure_thickness_bottom])
            cube([
                enclosure_cavity[0] + enclosure_thickness_sides*2,
                enclosure_cavity[1] + enclosure_thickness_sides*2,
                enclosure_thickness_bottom
            ]);
        translate([30, 0, -enclosure_thickness_bottom*2])
            cube([20, 5, enclosure_thickness_bottom*5]);
    }
}

module raspiFrontTopMaskWrtCavity() {
    translate([-enclosure_thickness_sides, 0, enclosure_cavity[2]-raspi_front_mask_top_height]) {
        cube([raspi_front_mask_snap_size-raspi_front_mark_snap_tolerance, enclosure_cavity[1], raspi_front_mask_top_height]);
        cube([enclosure_thickness_sides-raspi_front_mark_snap_tolerance, enclosure_cavity[1], raspi_front_mask_snap_size-raspi_front_mark_snap_tolerance]);
    }
}

module raspiFrontMaskWrtCavity() {
    translate([-enclosure_thickness_sides+raspi_front_mask_snap_size, 0, enclosure_cavity[2]-raspi_front_mask_top_height+raspi_front_mask_snap_size])
        cube([enclosure_thickness_sides+raspi_front_mask_thickness-raspi_front_mask_snap_size, enclosure_cavity[1], raspi_front_mask_snap_size*2]);
    translate([2-raspi_front_mask_thickness, 0, 0])
        difference() {
            cube([raspi_front_mask_thickness, enclosure_cavity[1], enclosure_cavity[2]-raspi_front_mask_top_height+raspi_front_mask_snap_size*2]);
            translate([-raspi_front_mask_thickness, raspi_pos_wrt_cavity[1], raspi_pos_wrt_cavity[2]])
                cube([raspi_front_mask_thickness*3, raspi_size[1], raspi_front_mask_height]);
        }
    translate([2, 0, raspi_pos_wrt_cavity[2] + display_board_support_distance_from_raspi_base])
        rotate([0, 0, 90])
            displayBoardSupport(enclosure_cavity[1], 3);
}

module enclosureFrontSideWrtCavity() {
    translate([-enclosure_thickness_sides, -enclosure_thickness_sides, 0])
        cube([enclosure_cavity[0] + enclosure_thickness_sides*2, enclosure_thickness_sides, enclosure_cavity[2]]);
    translate([raspi_pos_wrt_cavity[0]+15+55, 0, raspi_pos_wrt_cavity[2] + display_board_support_distance_from_raspi_base])
        rotate([0, 0, 180])
            displayBoardSupport(55, 6);

    firstMountX = enclosure_cavity[0]/2-base_enclosure_mounts_distance/2-base_mount_thickness/2;

    translate([firstMountX, -enclosure_thickness_sides, -enclosure_thickness_bottom]) {
        rotate([90, 0, 0]) {
            baseMounts(extra_diameter_left=false);
        }
    }
}

module enclosureRightSideWrtCavity() {
    translate([enclosure_cavity[0], 0, 0])
        cube([enclosure_thickness_sides, enclosure_cavity[1], enclosure_cavity[2]]);
}

module displayBoardSupport(support_length, support_height) {
    translate([0, 0, -support_height])
        rotate([90, 0, 0])
            rotate([0, 90, 0])
                linear_extrude(height=support_length)
                    polygon([
                        [0, 0],
                        [-display_board_support_thickness, support_height],
                        [0, support_height]
                    ]);
}

module enclosureBackSideWrtCavity(usb) {
    hole_width = usb ? back_hole_width : back_hole_width_no_usb;
    difference() {
        translate([-enclosure_thickness_sides, enclosure_cavity[1], 0]) {
            cube([enclosure_cavity[0] + enclosure_thickness_sides*2, enclosure_thickness_sides, enclosure_cavity[2]]);
        }
        translate([back_hole_distance_from_front_raspi + raspi_pos_wrt_cavity[0] - back_hole_extra_size, enclosure_cavity[1]-enclosure_thickness_sides, 0])
            cube([hole_width+back_hole_extra_size*2, enclosure_thickness_sides*3, back_hole_height + back_hole_extra_size]);
    }
    translate([raspi_pos_wrt_cavity[0], enclosure_cavity[1], raspi_pos_wrt_cavity[2] + display_board_support_distance_from_raspi_base])
        translate([15, 0, 0])
            displayBoardSupport(55, 6);
}

button_bottom = enclosure_cavity[2] - buttons_distance_from_screen_surface/2;
button_top = enclosure_cavity[2] + enclosure_thickness_top + buttons_top_overflow;
first_button_pos = [
    raspi_pos_wrt_cavity[0]+buttons_distance_from_raspi_left,
    raspi_pos_wrt_cavity[1]+first_button_distance_from_raspi_bottom,
    button_bottom
];

module buttonsWrtToCavity() {
    for (buttonIdx=[0,1,2]) {
        translate([first_button_pos[0], first_button_pos[1] + buttonIdx*buttons_distance_from_each_other, first_button_pos[2]-0.5]) {
            cylinder(r=buttons_diameter/2, h=button_top-button_bottom, $fs=cylinder_precision);
            translate([0, 0, 0.5]) cube([buttons_diameter, buttons_diameter*2, 1], center=true);
        }
    }
}

module enclosureTopSideWrtCavity() {
    z = raspi_pos_wrt_cavity[2]+distance_raspi_bottom_to_display_top;
    difference() {
        translate([-enclosure_thickness_sides, -enclosure_thickness_sides, z])
            cube([
                enclosure_cavity[0]+enclosure_thickness_sides*2,
                enclosure_cavity[1]+enclosure_thickness_sides*2,
                enclosure_thickness_top
                ]);
        // Display hole
        translate([
                raspi_pos_wrt_cavity[0] + display_hole_wrt_raspi[0],
                raspi_pos_wrt_cavity[1] + display_hole_wrt_raspi[1],
                z-enclosure_thickness_top
            ])
            cube([display_hole_size[0], display_hole_size[1], enclosure_thickness_top*3]);
        for (buttonIdx=[0,1,2]) {
            translate([first_button_pos[0], first_button_pos[1] + buttonIdx*buttons_distance_from_each_other, first_button_pos[2]])
                cylinder(r=(buttons_diameter+buttons_holes_abbundance)/2, h=button_top-button_bottom, $fs=cylinder_precision);
        }
    }
}

module enclosureBottomWithSupportsWrtCavity() {
    difference() {
        union() {
            enclosureBottomWrtCavity();
            raspiSupportsWrtCavity();
        }
        raspiSupportHolesWrtCavity();
    }
}

module enclosureBottomWrtToCavity(usb) {
    enclosureBottomWithSupportsWrtCavity();
    raspiFrontMaskWrtCavity();
    difference() {
        union() {
            enclosureFrontSideWrtCavity();
            enclosureBackSideWrtCavity(usb);
        }
        translate([-enclosure_cavity[0], -enclosure_cavity[1], top_cut_height_sides])
            cube([enclosure_cavity[0]*3, enclosure_cavity[0]*3, enclosure_cavity[2]]);
        translate([-10, -enclosure_cavity[1], top_cut_height_sides-2.8])
            cube([10, enclosure_cavity[0]*3, enclosure_cavity[2]]);
    }
    difference() {
        union() {
            difference() {
                enclosureRightSideWrtCavity();
                translate([-enclosure_cavity[0], -enclosure_cavity[1], top_cut_height_back])
                    cube([enclosure_cavity[0]*3, enclosure_cavity[0]*3, enclosure_cavity[2]]);
            }
            translate([enclosure_cavity[0]-enclosure_thickness_sides, (enclosure_cavity[1]-closing_tab_size)/2, top_cut_height_back-closing_tab_size/2+2])
                cube([enclosure_thickness_sides, closing_tab_size, closing_tab_size+2]);
        }
        translate([enclosure_cavity[0]+enclosure_thickness_sides, enclosure_cavity[1]/2, closing_screw_height])
            holeForClosingScrew();
    }
}

module enclosureTopWrtToCavity(usb) {
    enclosureTopSideWrtCavity();
    raspiFrontTopMaskWrtCavity();
    difference() {
        union() {
            enclosureFrontSideWrtCavity();
            enclosureBackSideWrtCavity(usb);
        }
        translate([0, -enclosure_cavity[1], top_cut_height_sides-enclosure_cavity[2]])
            cube([enclosure_cavity[0]*3, enclosure_cavity[0]*3, enclosure_cavity[2]]);
        translate([-enclosure_cavity[0], -enclosure_cavity[1], top_cut_height_sides-enclosure_cavity[2]-2.5])
            cube([enclosure_cavity[0]*3, enclosure_cavity[0]*3, enclosure_cavity[2]]);
    }
    difference() {
        enclosureRightSideWrtCavity();
        translate([-enclosure_cavity[0], -enclosure_cavity[1], top_cut_height_back-enclosure_cavity[2]])
            cube([enclosure_cavity[0]*3, enclosure_cavity[0]*3, enclosure_cavity[2]]);
        translate([enclosure_cavity[0]+enclosure_thickness_sides, enclosure_cavity[1]/2, closing_screw_height])
            holeForClosingScrew();
    }
}

module raspi() {
    cube(raspi_size);
}

module raspiWrtCavity() {
    translate(raspi_pos_wrt_cavity) raspi();
}

raspi_supports_positions = [
   [raspi_holes_left, raspi_holes_distance_from_border, 0],
   [raspi_holes_left, raspi_size[1]-raspi_holes_distance_from_border, 0],
   [raspi_size[0] - raspi_holes_distance_from_border, raspi_holes_distance_from_border, 0],
   [raspi_size[0] - raspi_holes_distance_from_border, raspi_size[1] - raspi_holes_distance_from_border, 0],
];

module raspiSupportsWrtCavity() {
    r = raspi_supports_diameter / 2;
    h = raspi_pos_wrt_cavity[2];
    translate([raspi_pos_wrt_cavity[0], raspi_pos_wrt_cavity[1], 0]) {
        for (pos=raspi_supports_positions) {
            translate(pos)
                cylinder(r=r, h=h, $fs=cylinder_precision);
        }
    }
}

module raspiSupportHolesWrtCavity() {
    h = raspi_pos_wrt_cavity[2] + enclosure_thickness_bottom;
    translate([raspi_pos_wrt_cavity[0], raspi_pos_wrt_cavity[1], 0]) {
        for (pos=raspi_supports_positions) {
            translate(pos)
                translate([0, 0, -enclosure_thickness_bottom+1])
                    cylinder(r=raspi_support_screws_diameter/2, h=h, $fs=cylinder_precision);
        }
    }
}


module enclosureToPrint(usb) {
    translate([0, 0, enclosure_thickness_bottom])
        enclosureBottomWrtToCavity(usb);

    rotate([180, 0, 0])
        translate([0, 22, -enclosure_cavity[2]-enclosure_thickness_top])
            enclosureTopWrtToCavity(usb);
}

module buttonsToPrint() {
    translate([20, -40, 0])
        rotate([0, 0, -90])
            translate([0, 0, -first_button_pos[2]+0.5])
                buttonsWrtToCavity();
}

module holeForClosingScrew() {
    h = 10;
    head_h = enclosure_thickness_sides/2;
    rotate([0, 90, 0]) {
        translate([0, 0, -h])
            cylinder(r=closing_screw_diameter/2, h=h, $fs=cylinder_precision);
        translate([0, 0, -head_h])
            cylinder(r=closing_screw_head_diameter/2, h=head_h+1, $fs=cylinder_precision);
    }
}

module enclosure(usb) {
    enclosureBottomWrtToCavity(usb);
    enclosureTopWrtToCavity(usb);
}

module enclosureWrtToCorner(usb) {
    translate([enclosure_thickness_sides, enclosure_thickness_sides, enclosure_thickness_bottom])
        enclosure(usb);
}

module enclosureWrtToMountHoles(usb) {
    translate([0, base_mount_length_to_axle, -base_mount_size/2])
        enclosureWrtToCorner(usb);
}

enclosureToPrint(usb=true);
//buttonsToPrint();

//enclosure(usb=true);
//enclosureWrtToMountHoles(usb=true);
//raspiWrtCavity();
//buttonsWrtToCavity();

