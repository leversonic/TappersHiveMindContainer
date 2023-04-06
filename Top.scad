include <Shared.scad>

module Top() {
	union() {
		difference() {
			TopBody();
			ButtonHoles();
			HiveMindLogo();
			EthernetCableHole();
			PowerCableHole();
			LockSlot();
		};
		translate([-lock_slot_width, -lid_thickness-1, -bottom_thickness]) TopLockTube();
		translate([lock_slot_width, -lid_thickness-1, -bottom_thickness]) TopLockTube();
	}
}

module TopBody() {
	difference() {
		linear_extrude(height=total_height) circle(r=total_radius, $fn=10);
		translate([-200, 0, -1]) linear_extrude(height=total_height+2) square(size=[400, 200], center=false);
		translate([0, -lid_thickness, -10]) TopInnerCavity();
	}
}

module TopInnerCavity() {
	difference() {
		translate([0, 0, 9]) linear_extrude(height=total_height-lid_thickness+1) circle(r=total_radius-(2*lid_thickness), $fn=10);
		translate([-200, 0, 9]) linear_extrude(height=total_height+2) square(size=[400, 200], center=false);
	}
}

module ButtonHoles() {
	for(i=[[18,1], [54,1], [90,1], [54,-1], [18,-1]]) {
		button_center_polar_length=total_radius - button_inset - button_hole_radius;
		x=i[1]*cos(i[0])*(button_center_polar_length);
		y=-sin(i[0])*(button_center_polar_length);
		translate([x, y, -1]) linear_extrude(height=total_height+2) circle(r=button_hole_radius, $fn=100);
		translate([x, y, total_height-lid_thickness-button_lip_height]) linear_extrude(height=lid_thickness-button_lip_height+1) circle(r=button_lip_radius, $fn=100);
	}
}

module HiveMindLogo() {
	translate([-28, -25, total_height-2]) linear_extrude(height=3) text("HiveMind", font="Liberation Serif:style=Bold", $fn=100);
	translate([0, -45, total_height-2]) linear_extrude(height=3) circle(r=12, $fn=6);
	translate([19, -56, total_height-2]) linear_extrude(height=3) circle(r=12, $fn=6);
	translate([0, -67, total_height-2]) linear_extrude(height=3) circle(r=12, $fn=6);
	translate([-19, -78, total_height-2]) linear_extrude(height=3) circle(r=12, $fn=6);
}

module LockSlot() {
	translate([0, -lid_thickness/2, -1]) linear_extrude(height=lock_slot_height+1) square(size=[lock_slot_width, lid_thickness+1], center=true);
}

module TopLockTube() {
	translate([-(lock_slot_width)/2, lock_tube_outer_radius+lid_thickness, lock_slot_height+bottom_thickness-lock_tube_outer_radius]) rotate([-90, 180, -90]) linear_extrude(height=lock_slot_width) difference(){
		union() {
			polygon([[0, lock_tube_outer_radius], [lock_tube_outer_radius, 0], [lock_tube_outer_radius, lock_tube_outer_radius-lock_slot_height], [-lock_tube_outer_radius-1, lock_tube_outer_radius-lock_slot_height], [-lock_tube_outer_radius-1, lock_tube_outer_radius]]);
			circle(r=lock_tube_outer_radius, $fn=500);
		}
		circle(r=lock_tube_inner_radius, $fn=500);
	}
}
