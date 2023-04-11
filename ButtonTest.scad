include <Top.scad>

intersection() {
	Top();
	ButtonCutout();
};

module ButtonCutout() {
	button_center_polar_length=total_radius - button_inset - button_hole_radius;
	difference() {
		translate([0, -button_center_polar_length, -1]) linear_extrude(height=total_height+2) circle(r=25, $fn=100);
		translate([-10, -134, 48]) linear_extrude(height=3) text(str(button_hole_radius, "mm"), size=4);
	};
}
