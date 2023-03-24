total_radius=161.8;
button_inset=20;
button_hole_radius=12.5;
lid_thickness=5;

difference() {
	Body();
	ButtonHoles();
	HiveMindLogo();
}

module Body() {
	difference() {
		translate([0, 0, 10]) linear_extrude(height=10) circle(r=total_radius, $fn=10);
		translate([-200, 0, -3]) linear_extrude(height=25) square(size=[400, 200], center=false);
		translate([0, -lid_thickness, 0]) InnerCavity();
	}
}

module InnerCavity() {
	difference() {
		translate([0, 0, 9]) linear_extrude(height=11-lid_thickness) circle(r=total_radius-(2*lid_thickness), $fn=10);
		translate([-200, 0, -3]) linear_extrude(height=25) square(size=[400, 200], center=false);
	}
}

module ButtonHoles() {
	for(i=[[18,1], [54,1], [90,1], [54,-1], [18,-1]]) {
		button_center_polar_length=total_radius - button_inset - button_hole_radius;
		x=i[1]*cos(i[0])*(button_center_polar_length);
		y=-sin(i[0])*(button_center_polar_length);
		translate([x, y, -3]) linear_extrude(height=25) circle(r=button_hole_radius, $fn=1000);
	}
}

module HiveMindLogo() {
	translate([-28, -20, 18]) linear_extrude(height=3) text("HiveMind", font="Liberation Serif:style=Bold", $fn=100);
	translate([0, -40, 18]) linear_extrude(height=3) circle(r=15, $fn=6);
	translate([24, -53.5, 18]) linear_extrude(height=3) circle(r=15, $fn=6);
	translate([0, -67, 18]) linear_extrude(height=3) circle(r=15, $fn=6);
	translate([-24, -80.5, 18]) linear_extrude(height=3) circle(r=15, $fn=6);
}
