include <parametric_involute_gear_v5.0.scad>;

bearing_inside_dia = 8;
bearing_outer_dia = 21.8;

small_gear_dia = 25;
large_gear_dia = 100;

//meshing_double_helix ();
//small_gear();
 large_gear();

module meshing_double_helix ()
{
	large_gear();

	mirror ([0,1,0])
	translate ([102,0,0])
	small_gear();

	mirror ([0,1,0])
	translate ([-102,0,0])
	small_gear();
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
		height=20;
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
