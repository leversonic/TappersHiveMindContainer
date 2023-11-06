include <Top.scad>
include <Bottom.scad>

intersection() {
    translate([0, 0, -2]) Top();
    translate([-200, -200, -2]) linear_extrude(height=4) square([400, 200]);
}

intersection() {
    translate([0, -lid_thickness-1, -bottom_thickness]) Bottom();
    translate([-200, -200, -2]) linear_extrude(height=4) square([400, 200]);
}
    