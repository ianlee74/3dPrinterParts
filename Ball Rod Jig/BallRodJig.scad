include <configuration.scad>;

ball_dia = 12.7;
rod_dia = 5.8;
wall_thickness = 5.0;
height = ball_dia/2+wall_thickness;
ball_cnt = 3;
end_length = 15;

module clamp_half()
{
	difference()
	{
		// Main block
		translate([-(ball_dia+wall_thickness)/2,-(ball_dia/2) - end_length])
		cube([ball_dia + wall_thickness, ball_dia*ball_cnt + wall_thickness*(ball_cnt-1) + end_length*2, height]);

		for(i=[0:ball_cnt-1]) translate([0, (ball_dia + wall_thickness)*i, 0])
		{		
			// Ball cutout
			sphere(r=ball_dia/2 + 0.1, $fn=50);
			
			// Rod cutout
			translate([-ball_dia/2, 0, 0])
			rotate([0, 90, 0])			
				cylinder(r=rod_dia/2 + 0.1, h=wall_thickness + 1, center=true, $fn=30);
		}

		// Left screw hole.
		translate([0, -ball_dia/2 - end_length/2, ball_dia/2 - wall_thickness/2 + 2])
			cylinder(r=m3_wide_radius, h=height+1, center=true, $fn=20);

		// Right screw hole.
		translate([0, ball_dia/2 + (ball_dia + wall_thickness) * (ball_cnt-1) + end_length/2, ball_dia/2 - wall_thickness/2 + 2])
			cylinder(r=m3_wide_radius, h=height+1, center=true, $fn=20);		
	}
}

module top_clamp_half()
{
	translate([0, (ball_dia + wall_thickness)*(ball_cnt-1)])
	rotate([0,0,180])
		clamp_half();
}

module bottom_clamp_half()
{
	mount_len = 10;
	mount_thickness = 5;

	union()
	{
		clamp_half();
		
		translate([-ball_dia/2 - wall_thickness/2, -ball_dia/2 - end_length - mount_len + 0.1, height - mount_thickness])
			difference()
			{
				cube([ball_dia + wall_thickness, mount_len, mount_thickness]);
				
				translate([(ball_dia + wall_thickness)/2, mount_len/2, -0.1])
					cylinder(r=m3_wide_radius*1.5, h=mount_thickness + 1, $fn=20);
			}

		translate([-ball_dia/2 - wall_thickness/2, ball_dia/2 + (ball_dia + wall_thickness) * (ball_cnt - 1) + mount_len + mount_len/2 - 0.1, height - mount_thickness])
			difference()
			{
				cube([ball_dia + wall_thickness, mount_len, mount_thickness]);
				
				translate([(ball_dia + wall_thickness)/2, mount_len/2, -0.1])
					cylinder(r=m3_wide_radius*1.5, h=mount_thickness + 1, $fn=20);
			}
	}
}

//rotate([0,180,0])
	top_clamp_half();

rotate([0,180,0])
	bottom_clamp_half();

