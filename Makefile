# SV08 Max Table Makefile
# Automates STL compilation from SCAD files

# OpenSCAD executable
OPENSCAD = openscad

# Directories
STL_DIR = stl_files

# Component definitions (file:quantity)
COMPONENTS = leg:4 long_rail:4 short_rail:4 table_top_segment:5 table_top_final_segment:1 alignment_pin:20

# STL files to generate
STL_FILES = $(STL_DIR)/leg.stl $(STL_DIR)/long_rail.stl $(STL_DIR)/short_rail.stl \
           $(STL_DIR)/table_top_segment.stl $(STL_DIR)/table_top_final_segment.stl \
           $(STL_DIR)/alignment_pin.stl

.PHONY: all clean info

# Default target
all: $(STL_FILES) info

# Create STL directory
$(STL_DIR):
	mkdir -p $(STL_DIR)

# Generic rule for STL generation
$(STL_DIR)/%.stl: %.scad dimensions.scad | $(STL_DIR)
	@echo "Compiling $< -> $@"
	$(OPENSCAD) -o $@ $<

# Information target
info:
	@echo ""
	@echo "=== SV08 Max Table - Build Complete ==="
	@echo "STL files generated:"
	@ls -la $(STL_DIR)/
	@echo ""
	@echo "=== Print Quantities Required ==="
	@echo "- 4x leg.stl"
	@echo "- 4x long_rail.stl"
	@echo "- 4x short_rail.stl"
	@echo "- 5x table_top_segment.stl"
	@echo "- 1x table_top_final_segment.stl"
	@echo "- 20x alignment_pin.stl"
	@echo ""
	@echo "=== Assembly Hardware ==="
	@echo "- M8 bolts and nuts for rail connections"
	@echo "- Wood glue for alignment pins (optional)"

# Clean target
clean:
	rm -rf $(STL_DIR)
	@echo "Cleaned STL files"

# Help target
help:
	@echo "SV08 Max Table Makefile"
	@echo "Available targets:"
	@echo "  all    - Compile all STL files (default)"
	@echo "  clean  - Remove all generated STL files"
	@echo "  info   - Show build information"
	@echo "  help   - Show this help message"