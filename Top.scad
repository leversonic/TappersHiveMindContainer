total_radius=161.8;
button_inset=20;
button_hole_radius=12.5;

difference() {
	translate([0, 0, 10]) linear_extrude(height=10) circle(r=total_radius, $fn=10);
	translate([-200, 0, -3]) linear_extrude(height=25) square(size=[400, 200], center=false);
	for(i=[[18,1], [54,1], [90,1], [54,-1], [18,-1]]) {
		button_center_polar_length=total_radius - button_inset - button_hole_radius;
		x=i[1]*cos(i[0])*(button_center_polar_length);
		y=-sin(i[0])*(button_center_polar_length);
		translate([x, y, -3]) linear_extrude(height=25) circle(r=button_hole_radius);
	}
}
