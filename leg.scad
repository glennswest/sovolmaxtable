// SV08 Max Table Leg Component
include <dimensions.scad>

module leg() {
    leg_height = table_height - top_thickness;

    difference() {
        // Main leg body
        cube([leg_size, leg_size, leg_height]);

        // Bolt holes for rail connections at bottom level
        translate([leg_size/2, 0, bottom_rail_height])
            rotate([-90, 0, 0])
            cylinder(d=bolt_hole_diameter, h=leg_size);

        translate([0, leg_size/2, bottom_rail_height])
            rotate([0, 90, 0])
            cylinder(d=bolt_hole_diameter, h=leg_size);

        // Bolt holes for rail connections at mid level
        translate([leg_size/2, 0, mid_rail_height])
            rotate([-90, 0, 0])
            cylinder(d=bolt_hole_diameter, h=leg_size);

        translate([0, leg_size/2, mid_rail_height])
            rotate([0, 90, 0])
            cylinder(d=bolt_hole_diameter, h=leg_size);

        // Bolt holes for top rail connections
        translate([leg_size/2, 0, top_rail_height + rail_width/2])
            rotate([-90, 0, 0])
            cylinder(d=bolt_hole_diameter, h=leg_size);

        translate([0, leg_size/2, top_rail_height + rail_width/2])
            rotate([0, 90, 0])
            cylinder(d=bolt_hole_diameter, h=leg_size);

        // Top mounting holes for table surface
        translate([leg_size/4, leg_size/4, leg_height - 20])
            cylinder(d=bolt_hole_diameter, h=25);
        translate([3*leg_size/4, leg_size/4, leg_height - 20])
            cylinder(d=bolt_hole_diameter, h=25);
        translate([leg_size/4, 3*leg_size/4, leg_height - 20])
            cylinder(d=bolt_hole_diameter, h=25);
        translate([3*leg_size/4, 3*leg_size/4, leg_height - 20])
            cylinder(d=bolt_hole_diameter, h=25);
    }
}

// Generate single leg for STL export
leg();