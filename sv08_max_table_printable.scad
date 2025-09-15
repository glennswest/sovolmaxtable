// OpenSCAD Printable Table for Sovol SV08 Max 3D Printer
// Designed for belt printer manufacturing
// Table dimensions: 802mm x 802mm x 463mm (desk height)
// All components designed to fit within typical belt printer constraints

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

// Belt printer constraints (typical limits)
max_print_length = 1000;      // mm (can be very long on belt)
max_print_width = 200;        // mm (cross-belt direction)
max_print_height = 200;       // mm

// Component selection for rendering
render_legs = false;
render_rails = false;
render_cross_members = false;
render_top_segments = false;
render_assembly = true;

//==============================================================================
// LEG COMPONENTS
//==============================================================================

module leg() {
    leg_height = table_height - top_thickness;

    difference() {
        // Main leg body
        cube([leg_size, leg_size, leg_height]);

        // Bolt holes for rail connections at bottom level (200mm)
        translate([leg_size/2, 0, 200])
            rotate([-90, 0, 0])
            cylinder(d=bolt_hole_diameter, h=leg_size);

        translate([0, leg_size/2, 200])
            rotate([0, 90, 0])
            cylinder(d=bolt_hole_diameter, h=leg_size);

        // Bolt holes for rail connections at mid level (250mm)
        translate([leg_size/2, 0, 250])
            rotate([-90, 0, 0])
            cylinder(d=bolt_hole_diameter, h=leg_size);

        translate([0, leg_size/2, 250])
            rotate([0, 90, 0])
            cylinder(d=bolt_hole_diameter, h=leg_size);

        // Bolt holes for top rail connections
        top_rail_height = leg_height - rail_width;
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

//==============================================================================
// RAIL COMPONENTS
//==============================================================================

module long_rail() {
    rail_length = table_width - 2 * leg_size;

    difference() {
        cube([rail_length, rail_width, rail_thickness]);

        // Bolt holes at ends
        translate([15, rail_width/2, rail_thickness/2])
            rotate([0, 90, 0])
            cylinder(d=bolt_hole_diameter, h=rail_thickness);

        translate([rail_length - 15, rail_width/2, rail_thickness/2])
            rotate([0, 90, 0])
            cylinder(d=bolt_hole_diameter, h=rail_thickness);

        // Counterbores for bolt heads
        translate([0, rail_width/2, rail_thickness/2])
            rotate([0, 90, 0])
            cylinder(d=counterbore_diameter, h=counterbore_depth);

        translate([rail_length - counterbore_depth, rail_width/2, rail_thickness/2])
            rotate([0, 90, 0])
            cylinder(d=counterbore_diameter, h=counterbore_depth);
    }
}

module short_rail() {
    rail_length = table_depth - 2 * leg_size;

    difference() {
        cube([rail_width, rail_length, rail_thickness]);

        // Bolt holes at ends
        translate([rail_width/2, 15, rail_thickness/2])
            rotate([90, 0, 0])
            cylinder(d=bolt_hole_diameter, h=rail_thickness);

        translate([rail_width/2, rail_length - 15, rail_thickness/2])
            rotate([90, 0, 0])
            cylinder(d=bolt_hole_diameter, h=rail_thickness);

        // Counterbores for bolt heads
        translate([rail_width/2, 0, rail_thickness/2])
            rotate([90, 0, 0])
            cylinder(d=counterbore_diameter, h=counterbore_depth);

        translate([rail_width/2, rail_length - counterbore_depth, rail_thickness/2])
            rotate([90, 0, 0])
            cylinder(d=counterbore_diameter, h=counterbore_depth);
    }
}

//==============================================================================
// CROSS MEMBER COMPONENTS (For additional stability)
//==============================================================================

module diagonal_brace() {
    // Calculate diagonal distance between inner corners of leg posts
    inner_width = table_width - 2 * leg_size;
    inner_depth = table_depth - 2 * leg_size;
    brace_length = sqrt(pow(inner_width, 2) + pow(inner_depth, 2));

    difference() {
        cube([brace_length, 40, 20]);

        // Bolt holes at ends for connection to corner brackets
        translate([10, 20, 10])
            rotate([0, 90, 0])
            cylinder(d=bolt_hole_diameter, h=20);

        translate([brace_length - 30, 20, 10])
            rotate([0, 90, 0])
            cylinder(d=bolt_hole_diameter, h=20);

        // Counterbores for bolt heads
        translate([0, 20, 10])
            rotate([0, 90, 0])
            cylinder(d=counterbore_diameter, h=counterbore_depth);

        translate([brace_length - counterbore_depth, 20, 10])
            rotate([0, 90, 0])
            cylinder(d=counterbore_diameter, h=counterbore_depth);
    }
}

module corner_bracket() {
    // L-shaped bracket to connect diagonal braces to existing rails
    difference() {
        union() {
            cube([60, 40, 20]);  // Horizontal arm
            cube([40, 60, 20]);  // Vertical arm
        }

        // Bolt holes for diagonal brace connection
        translate([50, 20, 10])
            rotate([0, 90, 0])
            cylinder(d=bolt_hole_diameter, h=20);

        // Bolt holes for rail connection
        translate([20, 50, 10])
            rotate([90, 0, 0])
            cylinder(d=bolt_hole_diameter, h=20);

        // Counterbores
        translate([60 - counterbore_depth, 20, 10])
            rotate([0, 90, 0])
            cylinder(d=counterbore_diameter, h=counterbore_depth);

        translate([20, 60 - counterbore_depth, 10])
            rotate([90, 0, 0])
            cylinder(d=counterbore_diameter, h=counterbore_depth);
    }
}

//==============================================================================
// TABLE TOP SEGMENTS
//==============================================================================

module top_segment(segment_width, segment_depth) {
    difference() {
        cube([segment_width, segment_depth, top_thickness]);

        // Alignment pin holes (8mm holes)
        if (segment_width < table_width) {
            // Right edge pins
            translate([segment_width - 5, segment_depth/4, top_thickness/2])
                rotate([0, 90, 0])
                cylinder(d=8, h=10);
            translate([segment_width - 5, 3*segment_depth/4, top_thickness/2])
                rotate([0, 90, 0])
                cylinder(d=8, h=10);
        }

        if (segment_depth < table_depth) {
            // Back edge pins
            translate([segment_width/4, segment_depth - 5, top_thickness/2])
                rotate([90, 0, 0])
                cylinder(d=8, h=10);
            translate([3*segment_width/4, segment_depth - 5, top_thickness/2])
                rotate([90, 0, 0])
                cylinder(d=8, h=10);
        }

        // Mounting holes for legs (only in corner segments)
        if (segment_width <= table_width/2 && segment_depth <= table_depth/2) {
            translate([leg_size/4, leg_size/4, 0])
                cylinder(d=bolt_hole_diameter, h=top_thickness);
            translate([3*leg_size/4, leg_size/4, 0])
                cylinder(d=bolt_hole_diameter, h=top_thickness);
            translate([leg_size/4, 3*leg_size/4, 0])
                cylinder(d=bolt_hole_diameter, h=top_thickness);
            translate([3*leg_size/4, 3*leg_size/4, 0])
                cylinder(d=bolt_hole_diameter, h=top_thickness);
        }
    }
}

module alignment_pin() {
    cylinder(d=7.8, h=15); // Slightly undersized for press fit
}

//==============================================================================
// ASSEMBLY
//==============================================================================

module assembled_table() {
    // Legs
    translate([0, 0, 0]) leg();
    translate([table_width - leg_size, 0, 0]) leg();
    translate([0, table_depth - leg_size, 0]) leg();
    translate([table_width - leg_size, table_depth - leg_size, 0]) leg();

    // Bottom rails (200mm height)
    translate([leg_size, 0, 200])
        rotate([0, 0, 0]) long_rail();
    translate([leg_size, table_depth - rail_width, 200])
        rotate([0, 0, 0]) long_rail();
    translate([0, leg_size, 200])
        rotate([0, 0, 90]) short_rail();
    translate([table_width - rail_width, leg_size, 200])
        rotate([0, 0, 90]) short_rail();

    // Mid-level rails (250mm height)
    translate([leg_size, 0, 250])
        rotate([0, 0, 0]) long_rail();
    translate([leg_size, table_depth - rail_width, 250])
        rotate([0, 0, 0]) long_rail();
    translate([0, leg_size, 250])
        rotate([0, 0, 90]) short_rail();
    translate([table_width - rail_width, leg_size, 250])
        rotate([0, 0, 90]) short_rail();

    // Top rails
    top_rail_height = table_height - top_thickness - rail_width;
    translate([leg_size, 0, top_rail_height])
        rotate([0, 0, 0]) long_rail();
    translate([leg_size, table_depth - rail_width, top_rail_height])
        rotate([0, 0, 0]) long_rail();
    translate([0, leg_size, top_rail_height])
        rotate([0, 0, 90]) short_rail();
    translate([table_width - rail_width, leg_size, top_rail_height])
        rotate([0, 0, 90]) short_rail();

    // Cross members (diagonal braces) at mid-level for additional stability
    mid_level_height = 250;

    // Calculate inner dimensions and diagonal angle
    inner_width = table_width - 2 * leg_size;
    inner_depth = table_depth - 2 * leg_size;
    diagonal_angle = atan2(inner_depth, inner_width);

    // Diagonal brace 1: front-left to back-right
    translate([leg_size, leg_size, mid_level_height])
        rotate([0, 0, diagonal_angle])
        diagonal_brace();

    // Diagonal brace 2: front-right to back-left
    translate([table_width - leg_size, leg_size, mid_level_height])
        rotate([0, 0, 180 - diagonal_angle])
        diagonal_brace();

    // Corner brackets to connect diagonal braces to existing rails
    translate([leg_size, leg_size, mid_level_height]) corner_bracket();
    translate([table_width - leg_size - 40, leg_size, mid_level_height])
        rotate([0, 0, 90]) corner_bracket();
    translate([table_width - leg_size - 40, table_depth - leg_size - 40, mid_level_height])
        rotate([0, 0, 180]) corner_bracket();
    translate([leg_size, table_depth - leg_size - 40, mid_level_height])
        rotate([0, 0, 270]) corner_bracket();

    // Table top segments (150x401x25mm each)
    translate([0, 0, table_height - top_thickness]) {
        // Row 1
        top_segment(150, table_depth);
        translate([150, 0, 0]) top_segment(150, table_depth);
        translate([300, 0, 0]) top_segment(150, table_depth);
        translate([450, 0, 0]) top_segment(150, table_depth);
        translate([600, 0, 0]) top_segment(150, table_depth);
        translate([750, 0, 0]) top_segment(52, table_depth); // Final narrow segment
    }
}

//==============================================================================
// INDIVIDUAL COMPONENT LAYOUTS FOR PRINTING
//==============================================================================

module print_layout_legs() {
    translate([0, 0, 0]) leg();
    translate([leg_size + 20, 0, 0]) leg();
    translate([0, leg_size + 20, 0]) leg();
    translate([leg_size + 20, leg_size + 20, 0]) leg();
}

module print_layout_rails() {
    long_rail();
    translate([0, rail_width + 10, 0]) long_rail();
    translate([0, 2*(rail_width + 10), 0]) long_rail();
    translate([0, 3*(rail_width + 10), 0]) long_rail();

    translate([table_width - 2 * leg_size + 20, 0, 0]) short_rail();
    translate([table_width - 2 * leg_size + 20, table_depth - 2 * leg_size + 10, 0]) short_rail();
    translate([table_width - 2 * leg_size + 20, 2*(table_depth - 2 * leg_size + 10), 0]) short_rail();
    translate([table_width - 2 * leg_size + 20, 3*(table_depth - 2 * leg_size + 10), 0]) short_rail();
}

module print_layout_cross_members() {
    // Diagonal braces
    diagonal_brace();
    translate([0, 50, 0]) diagonal_brace();

    // Corner brackets
    translate([0, 100, 0]) corner_bracket();
    translate([70, 100, 0]) corner_bracket();
    translate([140, 100, 0]) corner_bracket();
    translate([210, 100, 0]) corner_bracket();
}

module print_layout_top_segments() {
    // Main 150x401 segments
    for (i = [0:4]) {
        translate([i * 160, 0, 0]) top_segment(150, table_depth);
    }

    // Final narrow segment
    translate([5 * 160, 0, 0]) top_segment(52, table_depth);

    // Alignment pins
    translate([0, table_depth + 50, 0]) {
        for (i = [0:19]) {
            translate([i * 10, 0, 0]) alignment_pin();
        }
    }
}

//==============================================================================
// RENDER SELECTION
//==============================================================================

if (render_legs) {
    print_layout_legs();
} else if (render_rails) {
    print_layout_rails();
} else if (render_cross_members) {
    print_layout_cross_members();
} else if (render_top_segments) {
    print_layout_top_segments();
} else if (render_assembly) {
    assembled_table();
}

//==============================================================================
// INFORMATION OUTPUT
//==============================================================================

echo("=== SV08 Max Printable Table Specifications ===");
echo(str("Table dimensions: ", table_width, "mm x ", table_depth, "mm x ", table_height, "mm"));
echo(str("Leg size: ", leg_size, "mm x ", leg_size, "mm"));
echo(str("Rail dimensions: ", rail_width, "mm x ", rail_thickness, "mm"));
echo("=== Print Settings ===");
echo("Set render flags at top of file:");
echo("render_legs = true; - for leg components");
echo("render_rails = true; - for rail components");
echo("render_cross_members = true; - for diagonal braces and corner brackets");
echo("render_top_segments = true; - for table top segments");
echo("render_assembly = true; - for full assembly view");
echo("=== Assembly Requirements ===");
echo("Hardware needed:");
echo("- M8 bolts and nuts for rail connections");
echo("- M8 bolts and nuts for cross member connections");
echo("- Wood glue for alignment pins");
echo("- 20 alignment pins for table top segments");
echo("- 2 diagonal braces and 4 corner brackets for additional stability");