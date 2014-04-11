cam_dia = 49.1;
cam_angle = 30.0;
mount_height = 45;
width=140.0;
height=100.0;
thickness = 2;
fudge = 0.1;

difference()
{
	union()
	{
		translate([-10, 0, 0])
		cube([height,width,thickness], center=true);

		rotate([0,cam_angle,0])
		cylinder(h=mount_height, r=cam_dia/2 + 4, center=true, $fn=200);

		for(i=[width/2-10, -width/2+10])
		{
			translate([-50, i, 0])
			rotate([0, 30, 0])
				cylinder(h=10, r1=2, r2=.5);
		}

		
	}
	
	rotate([0,cam_angle,0])
	cylinder(h=mount_height + fudge*2, r=cam_dia/2, center=true, $fn=200);

	translate([0, 0, -mount_height/2 - thickness/2])
	cube([140, 100, mount_height], center=true);
}
