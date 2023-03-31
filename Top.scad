include <Shared.scad>


module Top() {
	difference() {
		TopBody();
		ButtonHoles();
		HiveMindLogo();
		EthernetCableHole();
		PowerCableHole();
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
