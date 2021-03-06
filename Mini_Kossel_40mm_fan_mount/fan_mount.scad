include <configuration.scad>;

// Input parameters
mount_thickness = 3;                             // Overall thickness (mm)
mount_angle = 45;                                // Angle to mount the fan at (degrees)
hole_radius = 12.5;                              // Radius at which the effector mount holes are made (mm)
effector_offset = 25;                            // Length of the side that offsets the fan from the effector (mm)
fan_radius = 20;                                 // overall fan radius, e.g. 40mm fan = 20 (mm)
fan_hole_pitch = 32;                             // pitch of the fan mounting holes (mm)
hole_offset = 2;                                 // space between thru holes and edges (mm)
hotend_radius = 8 + 0.25;                        // Radius of the hotend + buffer (mm)

// Calculated parameters
bracket_length = 2*(hole_offset+m3_wide_radius);                // Length of the angled portion (mm)
bracket_width = fan_hole_pitch+2*(hole_offset+m3_wide_radius);  // Overall bracket width (mm)

$fn = 40;

//rotate(a=90, v=[0,1,0]) // print on its side for a strong angle joint
union() {
difference() {
  union() {
    translate([0, hotend_radius+effector_offset, 0])
    rotate(a=mount_angle, v=[1,0,0])
      difference() {
        cube([bracket_width, bracket_length, mount_thickness]);
        translate([bracket_width/2, fan_radius+hole_offset, -1.5])
          cylinder(r=fan_radius, h=mount_thickness + 2, $fn=100);

        // Fan mounting holes
        translate([m3_wide_radius+hole_offset, m3_wide_radius+hole_offset, -1.5])
          cylinder(r=m3_wide_radius, h=mount_thickness + 2);
        translate([bracket_width-m3_wide_radius-hole_offset, m3_wide_radius+hole_offset, -1.5])
          cylinder(r=m3_wide_radius, h=mount_thickness + 2);
    }

    // Effector mounting side
    translate([0, hotend_radius/2 - 1, 0])
      cube([bracket_width, effector_offset+hotend_radius/2 + 1, mount_thickness]);
  }

  // Thru holes
  for (hole_angle = [-60:60:90]) {
    translate([bracket_width/2, 0, 0])
      translate([sin(hole_angle)*hole_radius,cos(hole_angle)*hole_radius,0])
      cylinder(r=m3_wide_radius, h=mount_thickness+ 5, center=true);
  }

  // Thru hole for hotend
  translate([bracket_width/2, 0, 1.5])
      cylinder(r=hotend_radius, h=mount_thickness + 1, center=true, $fn=100);

	// Kossel logo
	translate([20, 30, 1]) 
	rotate([0, 180, 180])
   scale([0.11, 0.11, 1]) 
	import("logotype.stl");

	// Cut out excess plastic on sides.
	translate([-4, 16, -0.1])
		cylinder(r=hotend_radius, h=mount_thickness + 1);
	translate([-.8, 2, -0.1])
		cube([5.2, 15, mount_thickness+0.2]);
	translate([bracket_width + 4, 16, -0.1])
		cylinder(r=hotend_radius, h=mount_thickness + 1);
	translate([bracket_width - 4.2, 2, -0.1])
		cube([5, 15, mount_thickness+0.2]);
}
// Add support for the center of the "O"
translate([9.5, 24, 0])
	cube([1.0, 2.0, mount_thickness]);
translate([9.5, 28.25, 0])
	 cube([1.0, 2.0, mount_thickness]);
};