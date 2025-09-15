// SV08 Max Table Top Final Segment Component (narrow)
include <dimensions.scad>

module top_segment(seg_width, seg_depth) {
    difference() {
        cube([seg_width, seg_depth, top_thickness]);

        // Alignment pin sockets (on left edge)
        translate([-5, seg_depth/4, top_thickness/2])
            rotate([0, 90, 0])
            cylinder(d=pin_hole_diameter, h=10);
        translate([-5, 3*seg_depth/4, top_thickness/2])
            rotate([0, 90, 0])
            cylinder(d=pin_hole_diameter, h=10);

        // Mounting holes for right legs
        // Front right leg area
        translate([seg_width - leg_size + leg_size/4, leg_size/4, 0])
            cylinder(d=bolt_hole_diameter, h=top_thickness);
        translate([seg_width - leg_size + 3*leg_size/4, leg_size/4, 0])
            cylinder(d=bolt_hole_diameter, h=top_thickness);
        translate([seg_width - leg_size + leg_size/4, 3*leg_size/4, 0])
            cylinder(d=bolt_hole_diameter, h=top_thickness);
        translate([seg_width - leg_size + 3*leg_size/4, 3*leg_size/4, 0])
            cylinder(d=bolt_hole_diameter, h=top_thickness);

        // Back right leg area
        translate([seg_width - leg_size + leg_size/4, seg_depth - leg_size/4, 0])
            cylinder(d=bolt_hole_diameter, h=top_thickness);
        translate([seg_width - leg_size + 3*leg_size/4, seg_depth - leg_size/4, 0])
            cylinder(d=bolt_hole_diameter, h=top_thickness);
        translate([seg_width - leg_size + leg_size/4, seg_depth - 3*leg_size/4, 0])
            cylinder(d=bolt_hole_diameter, h=top_thickness);
        translate([seg_width - leg_size + 3*leg_size/4, seg_depth - 3*leg_size/4, 0])
            cylinder(d=bolt_hole_diameter, h=top_thickness);
    }
}

// Generate final narrow segment for STL export
top_segment(final_segment_width, segment_depth);