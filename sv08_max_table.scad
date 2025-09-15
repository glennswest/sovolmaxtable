// OpenSCAD Table for Sovol SV08 Max 3D Printer
// Table dimensions: 802mm x 802mm x 463mm (desk height)
// Designed with 2-inch clearance on all sides
// Features 4x4 inch corner posts and cross rails

// Convert inches to mm
inch = 25.4;

// Table dimensions
table_width = 802;  // mm
table_depth = 802;  // mm
table_height = 463; // mm (desk height - printer bed at ~30" from floor)

// Post and rail dimensions
post_size = 4 * inch;  // 4x4 inch posts (101.6mm)
rail_size = 4 * inch;  // 4x4 inch rails (101.6mm)

// Table top thickness
top_thickness = 25; // mm

module corner_post() {
    cube([post_size, post_size, table_height - top_thickness]);
}

module cross_rail_x() {
    cube([table_width - 2 * post_size, rail_size, rail_size]);
}

module cross_rail_y() {
    cube([rail_size, table_depth - 2 * post_size, rail_size]);
}

module table_top() {
    cube([table_width, table_depth, top_thickness]);
}

module sv08_max_table() {
    // Table top
    translate([0, 0, table_height - top_thickness])
        table_top();

    // Corner posts
    // Front left
    translate([0, 0, 0])
        corner_post();

    // Front right
    translate([table_width - post_size, 0, 0])
        corner_post();

    // Back left
    translate([0, table_depth - post_size, 0])
        corner_post();

    // Back right
    translate([table_width - post_size, table_depth - post_size, 0])
        corner_post();

    // Cross rails - bottom level (200mm from ground)
    rail_height = 200;

    // Front and back rails (X direction)
    translate([post_size, 0, rail_height])
        cross_rail_x();
    translate([post_size, table_depth - rail_size, rail_height])
        cross_rail_x();

    // Left and right rails (Y direction)
    translate([0, post_size, rail_height])
        cross_rail_y();
    translate([table_width - rail_size, post_size, rail_height])
        cross_rail_y();

    // Mid-level cross rails for additional support
    mid_rail_height = 250;

    // Front and back mid rails
    translate([post_size, 0, mid_rail_height])
        cross_rail_x();
    translate([post_size, table_depth - rail_size, mid_rail_height])
        cross_rail_x();

    // Left and right mid rails
    translate([0, post_size, mid_rail_height])
        cross_rail_y();
    translate([table_width - rail_size, post_size, mid_rail_height])
        cross_rail_y();

    // Top support rails (just below table top)
    top_rail_height = table_height - top_thickness - rail_size;

    // Front and back top rails
    translate([post_size, 0, top_rail_height])
        cross_rail_x();
    translate([post_size, table_depth - rail_size, top_rail_height])
        cross_rail_x();

    // Left and right top rails
    translate([0, post_size, top_rail_height])
        cross_rail_y();
    translate([table_width - rail_size, post_size, top_rail_height])
        cross_rail_y();
}

// Display information
echo("=== SV08 Max Table Specifications ===");
echo(str("Table dimensions: ", table_width, "mm x ", table_depth, "mm x ", table_height, "mm"));
echo(str("Post size: ", post_size, "mm x ", post_size, "mm (", post_size/inch, "\" x ", post_size/inch, "\")"));
echo(str("Rail size: ", rail_size, "mm x ", rail_size, "mm (", rail_size/inch, "\" x ", rail_size/inch, "\")"));
echo(str("Estimated SV08 Max footprint: 700mm x 700mm x 800mm"));
echo(str("Clearance provided: 51mm (2\") on all sides"));

// Render the table
sv08_max_table();