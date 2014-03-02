
module supportPole(height)
{
	rotate([-90])
	difference()
	{
		cylinder(h=height, r=5);
		
		translate([-5.1, 0, -0.1])
			cube([11, 6, 166]);
	}
}

module plank(tolerance=0)
{
	difference()
	{
		cube([75, 10+tolerance, 3.5+tolerance]);
	}
}

module bridgeSupport()
{
	length = 150;
	height = 20;
	thickness = 2;

	difference()
	{
		translate([0, 5])
		union()
		{
			cube([height, length, thickness]);
		
			for(i = [0: length: length])
			{
				translate([115, i, 0])
				rotate([0, 0, 90])
					%supportPole(165);
			}
		}
		
		for(i = [0: length/11: length])
		{
			translate([-1.5, i, 3])
			rotate([0, 90, 0])
				#plank(0.3);
		}
	}
}

//supportPole(165);
bridgeSupport();
//plank();