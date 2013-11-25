include <configuration.scad>;

mount_height = 10.0;
lip_thickness = 15.0;
extrusion_triangle_ext = 56.0;
expansion_gap = 1.0;

module M3Screw()
{
	union()
	{
		// Main shaft
		translate([0, 0, m3_head_height])
		cylinder(r=m3_radius, h=mount_height+1, $fn=20);
		// Head
		cylinder(r=m3_washer_radius, h=m3_head_height+m3_washer_height, $fn=20);
	}
}

module M3ExactScrew()
{
	union()
	{
		// Main shaft
		translate([0, 0, m3_head_height])
		cylinder(r=m3_radius - extra_radius, h=mount_height+1, $fn=20);
		// Head
		cylinder(r=m3_washer_radius, h=m3_head_height+m3_washer_height, $fn=20);
	}
}

module BuildSurfaceMount(
	build_surface_radius = 110,
	build_surface_height = 3.25,
	pad_height = 2.3,
	width = 40,
	height = 10,
	extrusion_width = 15,
	extrusion_length = 240)
{
	//build_center = sqrt((pow(extrusion_length + extrusion_triangle_ext*2,2) - pow((extrusion_length+extrusion_triangle_ext*2)/2,2)))/2;
	build_center = 93;
echo(build_center);

	difference()
	{
		union()
		{
			intersection()
			{
				// Main mount block
				translate([-width/2, build_center-extrusion_width/2, 0])
					cube([width, build_surface_radius-build_center+extrusion_width/2 + lip_thickness, height]);
				// Outer Radius
				cylinder(r=build_surface_radius+lip_thickness/2+expansion_gap, h=mount_height, $fn=200);
			}
		}
		
		// Build surface
		translate([0,0,-1])
		#cylinder(r=build_surface_radius+expansion_gap, h=build_surface_height+pad_height, $fn=200);

		// Extrusion mount screw holes
		translate([10, build_center, (build_surface_height+pad_height-1) ])
		M3Screw();
		translate([-10, build_center, (build_surface_height+pad_height-1) ])
		M3Screw();

		// Glass hold-down screw
		translate([0, build_surface_radius+2.5, thickness - build_surface_height-m3_head_height-m3_washer_height ])
		M3ExactScrew();
	}
}

//M3Screw();
BuildSurfaceMount();