// SV08 Max Table Alignment Pin Component
include <dimensions.scad>

module alignment_pin() {
    cylinder(d=pin_diameter, h=pin_length); // Slightly undersized for press fit
}

// Generate single alignment pin for STL export
alignment_pin();