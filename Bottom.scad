use <Shared.scad>
total_radius=161.8;
button_inset=20;
button_hole_radius=12.5;
bottom_thickness=5;
lid_buffer=2;
total_height=50;

Bottom();

module Bottom() {
	difference() {
		linear_extrude(height=total_height) circle(r=total_radius-(2*bottom_thickness)-lid_buffer, $fn=10);
		translate([-200, 0, -1]) linear_extrude(height=total_height+2) square(size=[400, 200], center=false);
		translate([0, -bottom_thickness, 0]) InnerCavity();
		translate([0, 0, 5]) EthernetCableHole();
		translate([0, 0, 5]) PowerCableHole();
	}
}

module InnerCavity() {
	difference() {
		translate([0, 0, bottom_thickness]) linear_extrude(height=total_height-bottom_thickness+1) circle(r=total_radius-(4*bottom_thickness)-lid_buffer, $fn=10);
		translate([-200, 0, bottom_thickness-1]) linear_extrude(height=total_height+2) square(size=[400, 200], center=false);
	}
}
