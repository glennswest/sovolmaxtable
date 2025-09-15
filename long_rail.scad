// SV08 Max Table Long Rail Component (X direction)
include <dimensions.scad>

module long_rail() {
    difference() {
        cube([long_rail_length, rail_width, rail_thickness]);

        // Bolt holes at ends
        translate([15, rail_width/2, rail_thickness/2])
            rotate([0, 90, 0])
            cylinder(d=bolt_hole_diameter, h=rail_thickness);

        translate([long_rail_length - 15, rail_width/2, rail_thickness/2])
            rotate([0, 90, 0])
            cylinder(d=bolt_hole_diameter, h=rail_thickness);

        // Counterbores for bolt heads
        translate([0, rail_width/2, rail_thickness/2])
            rotate([0, 90, 0])
            cylinder(d=counterbore_diameter, h=counterbore_depth);

        translate([long_rail_length - counterbore_depth, rail_width/2, rail_thickness/2])
            rotate([0, 90, 0])
            cylinder(d=counterbore_diameter, h=counterbore_depth);
    }
}

// Generate single long rail for STL export
long_rail();