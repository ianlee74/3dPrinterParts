thickness = 5;
height = 30;
width = 80;

mount_width = 20;
mount_depth = 15;
mount_thickness = 8;

m3_diameter = 3;

module mount() {
	difference() {
		cube([mount_width, mount_depth, mount_thickness]);
		translate([4+m3_diameter/2, mount_depth-4-m3_diameter/2, 0])
		# cylinder(mount_thickness, m3_diameter, m3_diameter);
	}
}

module base() {
	union() {
		// Main Hexagon
		difference() {
			cube([width, thickness, height]);					// main rectangle
			translate([0, 0, 8])										// cut off left corner
			rotate([0, -45, 0])
			#cube([height+2, thickness, height/2+1]);
			translate([width, 0, 8])								// cut off right corner
			rotate([0, -45, 0])
			#cube([height/2+1, thickness, height+2]);
		}

		// L. Mount
		translate([0, -mount_depth, 0])
		mount();

		// R. Mount
		translate([width, -mount_depth, mount_thickness])
		rotate([0, 180, 0])
		mount();
	}
}

base();