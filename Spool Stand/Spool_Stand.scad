bearing_od = 21.8;
tube_length = 110;
tube_wall_thickness = 3;
end_ring_diameter = 37;
end_ring_thickness = 4;
rod_extension_length = 25;
rod_diameter = 7.8;

module endCone() {
	cylinder(h=end_ring_thickness, r1 = end_ring_diameter/2, r2=bearing_od/2 + tube_wall_thickness, $fn = 200);
};

module spool() {
	difference() {
		union() {
			cylinder(h=tube_length, r=bearing_od/2 + tube_wall_thickness, $fn=200);
			translate([0, 0, -end_ring_thickness])
				endCone();
			translate([0, 0, tube_length + end_ring_thickness])
			rotate([180, 0, 0])
				endCone();
		}

		// Hollow out the tube.
		translate([0, 0, -end_ring_thickness-1])
			cylinder(h=tube_length + end_ring_thickness*2 + 2, r=bearing_od/2, $fn=200);
		
		// Take away the sharp edge on the end rings.
		translate([0, 0, -end_ring_thickness -1])
		difference() {		
			cylinder(h=tube_length + end_ring_thickness * 2 + 2, r=end_ring_diameter/2, $fn=200);
			translate([0, 0, -1])
				cylinder(h=tube_length + end_ring_thickness*2 + 2, r=end_ring_diameter/2 - 3, $fn=200);
		}
	};
};

module rod() {
	cylinder (h=tube_length + rod_extension_length*2, r=rod_diameter/2, $fn=200);
};

module mount() {
	//polyhedron(points=[[
};

module completeAssembly() {
	spool();
	translate([0, 0, -end_ring_thickness-rod_extension_length])
	#rod();
};

//completeAssembly();
spool();