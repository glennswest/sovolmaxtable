// Shared dimensions for SV08 Max Table Components
// Include this file in all component SCAD files

// Convert inches to mm
inch = 25.4;

// Table dimensions
table_width = 802;  // mm
table_depth = 802;  // mm
table_height = 463; // mm (desk height - printer bed at ~30" from floor)

// Component dimensions
leg_size = 4 * inch;          // 4x4 inch legs (101.6mm)
rail_thickness = 30;          // mm (printable thickness)
rail_width = 80;              // mm (printable width)
top_thickness = 25;           // mm

// Connection system dimensions
bolt_hole_diameter = 8;       // M8 bolts
counterbore_diameter = 16;    // For bolt heads
counterbore_depth = 10;       // mm

// Rail heights
bottom_rail_height = 200;     // mm
mid_rail_height = 250;        // mm
top_rail_height = table_height - top_thickness - rail_width; // Calculated

// Calculated rail lengths
long_rail_length = table_width - 2 * leg_size;   // 599mm
short_rail_length = table_depth - 2 * leg_size;  // 599mm

// Table top segment dimensions
segment_width = 150;          // mm
segment_depth = table_depth;  // 802mm
final_segment_width = 52;     // mm (to complete 802mm total width)

// Alignment pin dimensions
pin_diameter = 7.8;           // mm (slightly undersized for press fit)
pin_length = 15;              // mm
pin_hole_diameter = 8;        // mm