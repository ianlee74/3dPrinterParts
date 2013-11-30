include <configuration.scad>;

bearing_od = 21.8;
tube_length = 110;
tube_wall_thickness = 3;
end_ring_diameter = 37;
end_ring_thickness = 4;
rod_extension_length = 25;
rod_diameter = 7.8;
stand_height = 150.0;
stand_base_thickness = 5;
stand_base_length = 70;

module standBase() {
	difference()
	{
		cube([stand_base_length, extrusion, stand_base_thickness]);

		for(x=[10:(stand_base_length-20)/2:stand_base_length-10]) {
			translate([x, extrusion/2, stand_base_thickness+0.1])
			rotate([0, 180, 0])
				#M3Screw(stand_base_thickness + 3);	
		}
	}
}

module rightStand() {
	difference()
	{
		union()
		{
			rotate([0, 0, 120])
				standBase();
			// Top attachment point
			translate([0, stand_base_length/2-5, stand_height])
			rotate([90, 0, 90])
				cylinder(r=bearing_od/2, h=stand_base_thickness,$fn=50);
			// main cube
			translate([0, 0, 0])
				cube([stand_base_thickness, stand_base_length-8, stand_height]);
			// bottom fill
			linear_extrude(height=stand_base_thickness)
				polygon(points=[[0,0],[0,stand_base_length-8],[-35,stand_base_length-9.5],]);
			// large support triangle
			translate([-15, 31, stand_base_thickness-1])
			rotate([90, 0, 0])
			linear_extrude(height=stand_base_thickness)
				polygon(points=[[0,0],[15,0],[15,stand_height-bearing_od],]);
		}


		// Remove right triangle
		translate([0, -31, 8])
		rotate([-8])
			#cube([10, 30, stand_height]);

		// Remove left triangle
		translate([0, 64, 3])
		rotate([9])
			cube([10, 30, stand_height]);

		// Remove hole for spool rod.
		translate([-25, stand_base_length/2-5, stand_height])
		rotate([0, 90, 0])
			#rod();

		// Remove notch for rod to slip into.
		// Hack: the height of linear_extrude doesn't seem to work in the difference().  Using the loop to duplicate the default thickness...
		for(x=[0:2:6]) {	
			translate([0+x, stand_base_length/2-5, stand_height])
			rotate([0,-90,0])
			linear_extrude(height=20)
				#polygon(points=[[0,3],[0,-3],[20,-rod_diameter/2-5],[20,rod_diameter/2+5],]);
		}
	}
}


module leftStand() {
	difference()
	{
		union()
		{
			rotate([0, 0, 60])
				standBase();
			// Top attachment point
			translate([30, stand_base_length/2-5, stand_height])
			rotate([90, 0, 90])
				cylinder(r=bearing_od/2, h=stand_base_thickness,$fn=50);
			// main cube
			translate([30, 0, 0])
				cube([stand_base_thickness, stand_base_length-8, stand_height]);
			// bottom fill
			linear_extrude(height=stand_base_thickness)
				polygon(points=[[0,0],[30,0],[30,stand_base_length-8],]);
			// large support triangle
			translate([15, 31, stand_base_thickness-1])
			rotate([90, 0, 0])
			linear_extrude(height=stand_base_thickness)
				polygon(points=[[0,0],[15,0],[15,stand_height-bearing_od],]);
		}


		// Remove right triangle
		translate([30, -31, 8])
		rotate([-8])
			cube([10, 30, stand_height]);

		// Remove left triangle
		translate([30, 64, 3])
		rotate([9])
			cube([10, 30, stand_height]);

		// Remove hole for spool rod.
		translate([25, stand_base_length/2-5, stand_height])
		rotate([0, 90, 0])
			#rod();

		// Remove notch for rod to slip into.
		// Hack: the height of linear_extrude doesn't seem to work in the difference().  Using the loop to duplicate the default thickness...
		for(x=[0:2:6]) {	
			translate([30+x, stand_base_length/2-5, stand_height])
			rotate([0,-90,0])
			linear_extrude(height=20)
				#polygon(points=[[0,3],[0,-3],[20,-rod_diameter/2-5],[20,rod_diameter/2+5],]);
		}
	}
}

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
//spool();
rightStand();