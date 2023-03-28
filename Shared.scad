module EthernetCableHole() {
	translate([-120, 1, 20]) rotate([90, 0, 0]) linear_extrude(height=30) circle(r=10, $fn=100);
}

module PowerCableHole() {
	translate([120, 1, 20]) rotate([90, 0, 0]) linear_extrude(height=30) circle(r=7.5, $fn=100);
}
