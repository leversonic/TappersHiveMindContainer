total_radius=161.8;
button_hole_radius=11.6;
button_lip_radius=12.6;
button_lip_height=2;
lid_buffer=2;
lid_thickness=10;
bottom_thickness=5;
button_inset=lid_thickness+bottom_thickness+20;
total_height=50;
lock_tube_outer_radius=9;
lock_tube_inner_radius=7;
lock_tube_thickness=lock_tube_outer_radius-lock_tube_inner_radius;
lock_slot_width=20;
lock_slot_height=total_height/2+lock_tube_outer_radius;
module EthernetCableHole() {
	translate([-total_radius+2*lid_thickness+2*bottom_thickness+20, 1, 20]) rotate([90, 0, 0]) linear_extrude(height=30) circle(r=10, $fn=100);
}

module PowerCableHole() {
	translate([total_radius-2*lid_thickness-2*bottom_thickness-20, 1, 20]) rotate([90, 0, 0]) linear_extrude(height=30) circle(r=7.5, $fn=100);
}
