include <parametric_involute_gear_v5.0.scad>;

gear_thickness = 20;
rod_extension_len = 10;

bearing_inside_dia = 8;
bearing_outer_dia = 21.8;

small_gear_dia = 25;
large_gear_dia = 100;

//winder();
//small_gear();
rotate([180])
small_gear_rod();
//large_gear();
//large_gear_rod();

module winder ()
{
	large_gear();

	mirror ([0,1,0])
	translate ([90,0,0])
	small_gear();

	mirror ([0,1,0])
	translate ([-90,0,0])
	rotate([0,0,19])
	small_gear();

	translate([0, 0, -gear_thickness/2 - rod_extension_len])
	%large_gear_rod();

	translate([-90, 0, -gear_thickness/2 - rod_extension_len])
	%small_gear_rod();

	translate([90, 0, -gear_thickness/2 - rod_extension_len])
	%small_gear_rod();

}

module hook() {
	dia = 25;
	band_clearance = 8;
	difference() 
	{
		translate([0, 0, 8])
		sphere(dia/2, $fn=100);
	
		rotate([0, 90, 0])
		translate([-8, 0, -37.4/2+6.1/2+4.5/2])	
		#bandHandle();

		translate([-dia/2, 1.5, 10.5])
		rotate([-115, 0, 0])
		cube([dia, 7, dia/2+2]);
		
		translate([-band_clearance/2, -2, 5])
		cube([band_clearance, dia/2 + 5, dia/2 + 5]);
		
		translate([-dia/2, -dia/2, 17])
		cube([dia, dia, 5]);
	}
}

module bandHandle() {
	dia = 6.1;
	len = 37.4;
	middle_len = 4.7;
	middle_dia = 4.5;

	union() {
		// lower part
		cylinder(h=len/2-dia-middle_len/2, r=dia/2, $fn=100);
		sphere(dia/2, $fn=100);
		translate([0, 0, len/2-dia-middle_len/2])
		sphere(dia/2, $fn=100);

		// middle part
		translate([0, 0, len/2 - middle_len - dia/2])
		cylinder(h=middle_len, r=middle_dia/2, $fn=100);

		// lower part
		translate([0, 0, len/2 + middle_len/2 - dia/2]) {
		cylinder(h=len/2-dia-middle_len/2, r=dia/2, $fn=100);
		sphere(dia/2, $fn=100);
		translate([0, 0, len/2-dia-middle_len/2])
		sphere(dia/2, $fn=100);
		}
	}
}

module small_gear_rod() {
	rod_len = gear_thickness + rod_extension_len + 50;
	union() {
		rod(rod_len, 0.1);
		translate([0, 0, rod_len])
		hook();
	}
}

module large_gear_rod() {
	rod(gear_thickness + rod_extension_len*2, -0.1);
}

module rod(length, radius_adj=0.0) {
	radius=bearing_inside_dia/2 + radius_adj;
	cylinder(h=length, r=radius, $fn=50);
}

module small_gear()
{
	double_helix_gear (teeth=9,circles=0, bore_dia=bearing_inside_dia);
}

module large_gear()
{
	double_helix_gear (teeth=36, circles=9, bore_dia=bearing_inside_dia+0.2);
}

module double_helix_gear (
	teeth=17,
	circles=8,
	bore_dia=8)
{
	//double helical gear
	{
		twist=200;
		height=gear_thickness;
		pressure_angle=30;

		gear (number_of_teeth=teeth,
			circular_pitch=700,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = height/2*0.5,
			rim_thickness = height/2,
			rim_width = 5,
			hub_thickness = height/2,
			hub_diameter=bore_dia+10,
			bore_diameter=bore_dia,
			circles=circles,
			twist=twist/teeth);
		mirror([0,0,1])
		gear (number_of_teeth=teeth,
			circular_pitch=700,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = height/2,
			rim_thickness = height/2,
			rim_width = 5,
			hub_thickness = height/2,
			hub_diameter=bore_dia+10,
			bore_diameter=bore_dia,
			circles=circles,
			twist=twist/teeth);
	}
}
