#!/bin/bash

# SV08 Max Table STL Compilation Script
# Generates all STL files from individual SCAD components

echo "Compiling SV08 Max Table STL files..."

# Create STL output directory
mkdir -p stl_files

# Component files and their STL outputs with quantities needed
declare -A components=(
    ["leg.scad"]="leg.stl:4"
    ["long_rail.scad"]="long_rail.stl:4"
    ["short_rail.scad"]="short_rail.stl:4"
    ["table_top_segment.scad"]="table_top_segment.stl:5"
    ["table_top_final_segment.scad"]="table_top_final_segment.stl:1"
    ["alignment_pin.scad"]="alignment_pin.stl:20"
)

# Compile each component
for scad_file in "${!components[@]}"; do
    if [ -f "$scad_file" ]; then
        IFS=':' read -r stl_file quantity <<< "${components[$scad_file]}"
        echo "Compiling $scad_file -> stl_files/$stl_file (quantity needed: $quantity)"
        openscad -o "stl_files/$stl_file" "$scad_file"

        if [ $? -eq 0 ]; then
            echo "✓ Successfully compiled $stl_file"
        else
            echo "✗ Failed to compile $stl_file"
        fi
    else
        echo "Warning: $scad_file not found"
    fi
done

echo ""
echo "=== Compilation Summary ==="
echo "STL files generated in stl_files/ directory:"
ls -la stl_files/

echo ""
echo "=== Bill of Materials ==="
echo "Print the following quantities:"
echo "- 4x leg.stl"
echo "- 4x long_rail.stl (for X-direction rails)"
echo "- 4x short_rail.stl (for Y-direction rails)"
echo "- 5x table_top_segment.stl (150x802x25mm segments)"
echo "- 1x table_top_final_segment.stl (52x802x25mm final segment)"
echo "- 20x alignment_pin.stl (for connecting table top segments)"

echo ""
echo "=== Assembly Hardware Required ==="
echo "- M8 bolts and nuts for rail connections (quantity varies based on design)"
echo "- Wood glue for alignment pins (optional, for permanent assembly)"

echo "Compilation complete!"