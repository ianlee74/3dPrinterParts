inner_width = 17;
wall_thickness = 1.5;
segment_length = 40;
segments =4;
cutter_height = 25;
angle = 140;

fudge = 0.1*1;

module chevron(width, height, length)
{
	angled_length = sin(angle/2)*length;
	adj = -1.1;
	offset = angled_length/2 + adj;

echo(offset);

	difference()
	{
		intersection()
		{
			for(i=[0:segments-1])
			{
				translate([offset * i, 0, 0])
				rotate([0,0,i%2 == 0 ? angle : -angle])
					cube([length, width, height],center=true);
			}
		}
	}
}

module cookieCutter()
{
	union()
	{
		difference()
		{
			chevron(inner_width + wall_thickness*2, cutter_height, segment_length);
			chevron(inner_width, cutter_height + fudge*2, segment_length);
		}
		
		// ends
		translate([-16,13.2,0])
		rotate([0,0,angle])
		cube([wall_thickness, inner_width+wall_thickness*2, cutter_height], center=true);

		translate([68,12.2,0])
		rotate([0,0,-angle])
		cube([wall_thickness, inner_width+wall_thickness*2, cutter_height], center=true);

		translate([-28,-25,-cutter_height/2])
		cube([110, 50, wall_thickness]);
	}
}

//chevron(inner_width, cutter_height);
cookieCutter();