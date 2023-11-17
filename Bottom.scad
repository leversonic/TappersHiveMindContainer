include <Shared.scad>

module Bottom() {
	union() {
		difference() {
			linear_extrude(height=total_height-lid_thickness+4) circle(r=total_radius-(2*lid_thickness)-lid_buffer, $fn=10);
			translate([-200, 0, -1]) linear_extrude(height=total_height+2) square(size=[400, 200], center=false);
			BottomInnerCavity();
			translate([0, 0, 5]) EthernetCableHole();
			translate([0, 0, 5]) PowerCableHole();
		};
		BottomLockTube();
	}
}

module BottomInnerCavity() {
	difference() {
		translate([0, -bottom_thickness, bottom_thickness]) linear_extrude(height=total_height-bottom_thickness+1) circle(r=total_radius-(2*bottom_thickness)-(2*lid_thickness)-lid_buffer, $fn=10);
		translate([-200, -bottom_thickness, bottom_thickness-1]) linear_extrude(height=total_height+2) square(size=[400, 200], center=false);
	}
}

module BottomLockTube() {
	translate([-(lock_slot_width-lid_buffer)/2, lock_tube_outer_radius+lid_thickness, lock_slot_height+bottom_thickness-lock_tube_outer_radius]) rotate([-90, 180, -90]) linear_extrude(height=lock_slot_width-lid_buffer) difference(){
		union() {
			polygon([[0, lock_tube_outer_radius], [lock_tube_outer_radius, 0], [0, -lock_tube_outer_radius], [-lid_thickness-lock_tube_outer_radius-1, -lock_tube_outer_radius], [-lid_thickness-lock_tube_outer_radius-1, lock_tube_outer_radius]]);
			circle(r=lock_tube_outer_radius, $fn=500);
		}
		circle(r=lock_tube_inner_radius, $fn=500);
	}
}

