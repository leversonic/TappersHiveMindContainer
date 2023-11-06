include <Top.scad>
include <Bottom.scad>

//Top();
intersection() {
    translate([-200, -200, -2]) linear_extrude(height=4) square([400, 200]);
    translate([0, -lid_thickness-1, -bottom_thickness]) Bottom();
}