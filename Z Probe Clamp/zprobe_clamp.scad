include <configuration.scad>;

d_probe = 2.35 + 2*extra_radius; // probe diameter (mm)
d_clamp = 7;                    // outside diameter of the clamp (mm)
h_clamp = 8;                    // clamp heigth (mm)
d_nut = 6.4 + 2*extra_radius;   // hex nut diameter, M3 = 6.1 (mm)
h_nut = 2.5 + 2*extra_radius;   // hex thickness (mm)
delta_nut = 0.8;                // slight nut shift toward zprobe and space on the opposite side (mm)
$fn = 40;

difference() {
  union() {
    cylinder(r=d_clamp/2, h=h_clamp, $fn=100);
    translate([0, -d_clamp/2, 0]) cube([d_probe/2+h_nut+3*delta_nut, d_clamp, h_clamp]);
  };
  cylinder(r=d_probe/2, h=h_clamp, $fn=100);
  translate([0, 0, h_clamp/2]) rotate(a=90, v=[0,1,0]) cylinder(r=m3_wide_radius, h=2*d_clamp);

  translate([d_probe/2+delta_nut, 0, h_clamp/2]) rotate(a=90, v=[0,1,0]) cylinder(r=d_nut/2, h=h_nut, $fn=6);
  translate([d_probe/2+delta_nut, -d_nut*cos(30)/2, h_clamp-d_nut/2]) cube([h_nut, d_nut*cos(30), d_nut]);
};