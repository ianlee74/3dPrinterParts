use <NM2.scad>;

band_thickness = 2;
logo_depth = 1;

topper_width = 23;
topper_height = 20;

function scaleFactor(ringSize) = (ringSize+2*band_thickness)/topper_width;

module ring(size, width)
{ 
	topper_thickness = 10;
	scaleAmt = scaleFactor(size);

	difference()
	{
		union()
		{
			// Outer cylinder
			cylinder(h=width, r=size/2+band_thickness, center=true, $fn=200);

			// Topper
			translate([-size/2-band_thickness, 0, -topper_height/2*scaleAmt])
			rotate([90, 0, 0])	
			ringTopper(size/2 + band_thickness+1, size);
		}

		cylinder(h=topper_width*scaleAmt+1, r=size/2, center=true, $fn=200);

		for(i = [-1,1])
		{
			translate([-size/2-band_thickness-.5, 0, (width/2 + size/2 + 2)*i])
			rotate([0, 90, 0])
			cylinder(h=size+band_thickness*2+1, r=size/2+2, $fn=200);
		}
	}
}

module ringTopper(thickness, ringSize)
{
	corner_angle = 35;
	
	scaleAmt = scaleFactor(ringSize);
	scale([scaleAmt, scaleAmt, 1.0])
	difference()
	{
		cube([topper_width, topper_height, thickness]);

		translate([topper_width/2, topper_height/2, thickness - .5])
		scale([0.15, 0.15, 1.0])
		#nmLogo(logo_depth);

/*
		translate([topper_width, cos(corner_angle)*topper_height*0.6+0.5, thickness - logo_depth])
		rotate([0, 0, corner_angle])
#		cube([topper_width*0.25, topper_height*0.6, logo_depth+0.1]);
*/
	}
}

//color("purple")
//ringBand(10, 18);
//ringTopper(6);
//nmLogo(4);
rotate([90,0,0]) ring(18, 10);
