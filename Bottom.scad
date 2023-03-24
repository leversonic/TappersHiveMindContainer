total_radius=161.8;
button_inset=20;
button_hole_radius=12.5;
bottom_thickness=5;
lid_buffer=2;


Body();

module Body() {
	difference() {
		linear_extrude(height=10) circle(r=total_radius-(2*bottom_thickness)-lid_buffer, $fn=10);
		translate([-200, 0, -3]) linear_extrude(height=25) square(size=[400, 200], center=false);
		translate([0, -bottom_thickness, 0]) InnerCavity();
	}
}

module InnerCavity() {
	difference() {
		translate([0, 0, bottom_thickness]) linear_extrude(height=11-bottom_thickness) circle(r=total_radius-(4*bottom_thickness)-lid_buffer, $fn=10);
		translate([-200, 0, -3]) linear_extrude(height=25) square(size=[400, 200], center=false);
	}
}
