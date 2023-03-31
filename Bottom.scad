include <Shared.scad>

module Bottom() {
	difference() {
		linear_extrude(height=total_height) circle(r=total_radius-(2*lid_thickness)-lid_buffer, $fn=10);
		translate([-200, 0, -1]) linear_extrude(height=total_height+2) square(size=[400, 200], center=false);
		BottomInnerCavity();
		translate([0, 0, 5]) EthernetCableHole();
		translate([0, 0, 5]) PowerCableHole();
	}
}

module BottomInnerCavity() {
	difference() {
		translate([0, -bottom_thickness, bottom_thickness]) linear_extrude(height=total_height-bottom_thickness+1) circle(r=total_radius-(2*bottom_thickness)-(2*lid_thickness)-lid_buffer, $fn=10);
		translate([-200, -bottom_thickness, bottom_thickness-1]) linear_extrude(height=total_height+2) square(size=[400, 200], center=false);
	}
}
