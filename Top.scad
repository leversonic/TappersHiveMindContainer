include <Shared.scad>

module Top() {
	union() {
		difference() {
			TopBody();
			ButtonHoles(button_hole_radius, button_inset);
			TopTexture();
			PowerCableHole();
			EthernetCableHole();
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
		translate([0, -(cos(18) * total_radius + 1), total_height / 2]) rotate([-90, 0, 0]) Queen(total_height / 2, total_height / 2, engrave_depth);
		translate([-(cos(18) * total_radius + 1) * cos(54), -(cos(18) * total_radius + 1) * sin(54), total_height / 2]) rotate([-90, 0, -36]) Abs(total_height / 2, total_height / 2, engrave_depth);
		translate([-(cos(18) * total_radius + 1) * cos(18), -(cos(18) * total_radius + 1) * sin(18), total_height / 2]) rotate([-90, 0, -72]) Stripes(total_height / 2, total_height / 2, engrave_depth);
		translate([(cos(18) * total_radius + 1) * cos(54), -(cos(18) * total_radius + 1) * sin(54), total_height / 2]) rotate([-90, 0, 36]) Skulls(total_height / 2, total_height / 2, engrave_depth);
		translate([(cos(18) * total_radius + 1) * cos(18), -(cos(18) * total_radius + 1) * sin(18), total_height / 2]) rotate([-90, 0, 72]) Checks(total_height / 2, total_height / 2, engrave_depth);
	}
}

module TopInnerCavity() {
	difference() {
		translate([0, 0, 9]) linear_extrude(height=total_height-lid_thickness+1) circle(r=total_radius-(2*lid_thickness), $fn=10);
		translate([-200, 0, 9]) linear_extrude(height=total_height+2) square(size=[400, 200], center=false);
	}
}

module TopTexture() {
	intersection() {
		difference() {
			translate([0, -lid_thickness, 0]) difference() {
				translate([0, 0, total_height - engrave_depth]) linear_extrude(height=engrave_depth + 1) circle(r=total_radius - (2 * lid_thickness), $fn=10);
			translate([-200, 0, 9]) linear_extrude(height=total_height - engrave_depth + 2) square(size=[400, 200], center=false);
			}
			ButtonHoles(button_outline_radius, button_outline_inset);
		}
		HoneycombTexture();
	}
}

module HoneycombTexture() {
	for(x=[-floor(total_radius / honeycomb_hex_radius) : floor(total_radius / honeycomb_hex_radius)]) {
		for(y=[0 : floor(total_radius / honeycomb_hex_radius)]) {
			offset = y % 2 == 0 ? honeycomb_hex_radius : 0;
			translate([0, -total_radius, total_height - engrave_depth + 1]) linear_extrude(height=engrave_depth + 1) translate([x * honeycomb_hex_radius * 2 + offset, y * honeycomb_hex_radius * cos(30) * 2]) rotate([0, 0, 90]) circle(r=honeycomb_hex_radius, $fn=6);
		}
	}
}

module ButtonHoles(hole_radius, inset) {
	for(i=[[18,1], [54,1], [90,1], [54,-1], [18,-1]]) {
		button_center_polar_length=total_radius - inset - hole_radius;
		x=i[1]*cos(i[0])*(button_center_polar_length);
		y=-sin(i[0])*(button_center_polar_length);
		translate([x, y, -1]) linear_extrude(height=total_height+2) circle(r=hole_radius, $fn=100);
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
	translate([0, -lid_thickness/2, -1]) linear_extrude(height=lock_slot_height+2) square(size=[lock_slot_width, lid_thickness+1], center=true);
}

module TopLockTube() {
	translate([-(lock_slot_width)/2, lock_tube_outer_radius+lid_thickness, lock_slot_height+bottom_thickness-lock_tube_outer_radius]) rotate([-90, 180, -90]) linear_extrude(height=lock_slot_width) difference(){
		union() {
			polygon([[0, lock_tube_outer_radius], [lock_tube_outer_radius, 0], [0, -lock_tube_outer_radius], [-lock_tube_outer_radius-1, -lock_tube_outer_radius], [-lock_tube_outer_radius-1, lock_tube_outer_radius]]);
			circle(r=lock_tube_outer_radius, $fn=500);
		}
		circle(r=lock_tube_inner_radius, $fn=500);
	}
}

module Border(width, height) {
	difference() {
		translate([-width * 0.01, -height * 0.01, 0]) square(size=[width * 1.02, height * 1.02], center=false);
		translate([width * 0.01, height * 0.01]) square(size=[width * 0.98, height * 0.98], center=false);
	}
}
module ScaledPolygon(points, width, height) {
	function scalePoint(point) = [point[0] * width / 128, point[1] * height / 128];

	scaledPoints = [for (i = [0 : len(points) - 1]) scalePoint(points[i])];
	polygon(scaledPoints);
}

module Stripes(width, height, thickness) {
	translate([-width / 2, -height / 2, 0]) linear_extrude(height=thickness) union() {
		Border(width, height);
		square(size=[width, height * 0.2]);
		translate([0, height * 0.4, 0]) square(size=[width, height * 0.2]);
		translate([0, height * 0.8, 0]) square(size=[width, height * 0.2]);
	}
}

module Checks(width, height, thickness) {
	translate([-width / 2, -height / 2, 0]) linear_extrude(height=thickness) union() {
		Border(width, height);
		square(size=[width / 3, height / 3]);
		translate([2 * width / 3, 0, 0]) square(size=[width / 3, height / 3]);
		translate([1.01 * width / 3, 1.01 * width / 3, 0]) square(size=[0.98 * width / 3, 0.98 * height / 3]);
		translate([0, 2 * width / 3, 0]) square(size=[width / 3, height / 3]);
		translate([2 * width / 3, 2 * width / 3, 0]) square(size=[width / 3, height / 3]);
	}
}

module Queen(width, height, thickness) {
	translate([-width / 2, -height / 2, 0]) linear_extrude(height=thickness) difference() {
		square(size=[width, height], center=false);
		ScaledPolygon([[24, 112], [103.72, 112], [112, 24.73], [80, 56], [64, 16], [48, 56], [15.86, 24.73], [24, 112]], width, height);
	}
}

module Abs(width, height, thickness) {
	translate([-width / 2, -height / 2, 0]) linear_extrude(height=thickness) union() {
		Border(width, height);
		translate([28.29 * width / 128, 32.29 * height / 128, 0]) square(size=[14.29 * width / 128, 14.29 * width / 128]);
		translate([85.71 * width / 128, 32.29 * height / 128, 0]) square(size=[14.29 * width / 128, 14.29 * width / 128]);
		ScaledPolygon([[71.14, 18], [56.86, 18], [56.86, 60.86], [14, 60.86], [14, 75.14], [56.86, 75.14], [56.86, 89.43], [28.29, 89.43], [28.29, 103.71], [56.86, 103.71], [56.86, 128], [71.14, 128], [71.14, 103.71], [99.71, 103.71], [99.71, 89.43], [71.14, 89.43], [71.14, 75.14], [114, 75.14], [114, 60.86], [71.14, 60.86], [71.14, 18]], width, height);
	}
}

module Skulls(width, height, thickness) {
	translate([-width / 2, -height / 2, 0]) linear_extrude(height=thickness) union() {
		difference() {
			square(size=[width, height], center=false);
			ScaledPolygon([[99, 57], [99, 43], [85, 43], [85, 29], [43, 29], [43, 43], [29, 43], [29, 57], [15, 57], [15, 85], [29, 85], [29, 99], [43, 99], [43, 85], [57, 85], [57, 99], [71, 99], [71, 85], [85, 85], [85, 99], [99, 99], [99, 85], [113, 85], [113, 57], [99, 57]], width, height);
		}
		translate([43 * width / 128, 57 * height / 128, 0]) square(size=[14* width / 128, 14 * width / 128]);
		translate([71 * width / 128, 57 * height / 128, 0]) square(size=[14 * width / 128, 14 * width / 128]);
	}
}
