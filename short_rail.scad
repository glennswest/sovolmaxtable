// SV08 Max Table Short Rail Component (Y direction)
include <dimensions.scad>

module short_rail() {
    difference() {
        cube([rail_width, short_rail_length, rail_thickness]);

        // Bolt holes at ends
        translate([rail_width/2, 15, rail_thickness/2])
            rotate([90, 0, 0])
            cylinder(d=bolt_hole_diameter, h=rail_thickness);

        translate([rail_width/2, short_rail_length - 15, rail_thickness/2])
            rotate([90, 0, 0])
            cylinder(d=bolt_hole_diameter, h=rail_thickness);

        // Counterbores for bolt heads
        translate([rail_width/2, 0, rail_thickness/2])
            rotate([90, 0, 0])
            cylinder(d=counterbore_diameter, h=counterbore_depth);

        translate([rail_width/2, short_rail_length - counterbore_depth, rail_thickness/2])
            rotate([90, 0, 0])
            cylinder(d=counterbore_diameter, h=counterbore_depth);
    }
}

// Generate single short rail for STL export
short_rail();