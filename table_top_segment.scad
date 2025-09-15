// SV08 Max Table Top Segment Component
include <dimensions.scad>

module top_segment(seg_width, seg_depth) {
    difference() {
        cube([seg_width, seg_depth, top_thickness]);

        // Alignment pin holes (on right edge if not full width)
        if (seg_width < table_width) {
            // Right edge pins
            translate([seg_width - 5, seg_depth/4, top_thickness/2])
                rotate([0, 90, 0])
                cylinder(d=pin_hole_diameter, h=10);
            translate([seg_width - 5, 3*seg_depth/4, top_thickness/2])
                rotate([0, 90, 0])
                cylinder(d=pin_hole_diameter, h=10);
        }

        // Alignment pin sockets (on left edge if not at table edge)
        if (seg_width == segment_width) { // Standard segments get sockets on left
            translate([-5, seg_depth/4, top_thickness/2])
                rotate([0, 90, 0])
                cylinder(d=pin_hole_diameter, h=10);
            translate([-5, 3*seg_depth/4, top_thickness/2])
                rotate([0, 90, 0])
                cylinder(d=pin_hole_diameter, h=10);
        }

        // Mounting holes for legs (only in segments that align with legs)
        // Front left leg area
        if (seg_width >= leg_size) {
            translate([leg_size/4, leg_size/4, 0])
                cylinder(d=bolt_hole_diameter, h=top_thickness);
            translate([3*leg_size/4, leg_size/4, 0])
                cylinder(d=bolt_hole_diameter, h=top_thickness);
            translate([leg_size/4, 3*leg_size/4, 0])
                cylinder(d=bolt_hole_diameter, h=top_thickness);
            translate([3*leg_size/4, 3*leg_size/4, 0])
                cylinder(d=bolt_hole_diameter, h=top_thickness);
        }

        // Back left leg area (if segment covers back of table)
        if (seg_width >= leg_size && seg_depth >= table_depth - leg_size) {
            translate([leg_size/4, seg_depth - leg_size/4, 0])
                cylinder(d=bolt_hole_diameter, h=top_thickness);
            translate([3*leg_size/4, seg_depth - leg_size/4, 0])
                cylinder(d=bolt_hole_diameter, h=top_thickness);
            translate([leg_size/4, seg_depth - 3*leg_size/4, 0])
                cylinder(d=bolt_hole_diameter, h=top_thickness);
            translate([3*leg_size/4, seg_depth - 3*leg_size/4, 0])
                cylinder(d=bolt_hole_diameter, h=top_thickness);
        }
    }
}

// Generate standard segment for STL export
top_segment(segment_width, segment_depth);