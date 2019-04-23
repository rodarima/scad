H=30;
CYL_BORDER=8;
HOLE_R1=21/2;
HOLE_R2=22.6/2;
SLIT=16;
ARM_L=20;
ARM_HOLE_R=11/2;
OFFSET=1.2;

ARM_W=CYL_BORDER;
CYL_R=max(HOLE_R1, HOLE_R2) + CYL_BORDER;

module hole() {
	cylinder(r1=HOLE_R1, r2=HOLE_R2,
			h=H*OFFSET, center=true);
}

module handle() {
	union() {
		difference() {
			cylinder(r1=CYL_R, r2=CYL_R, h=H, center=true);
			hole();
			translate([CYL_R/2, 0, 0])
			cube([CYL_R*1.5, SLIT, H*OFFSET], center=true);
		}
		difference() {
			translate([0, 0, -H/2])
			rotate([0, 0, 90+45])
			cube([CYL_R, CYL_R, H], center=false);
			hole();
		}
	}
}

module arm() {
	difference(){
		union(){
			translate([-ARM_L, -ARM_W/2, -H/2])
			cube([ARM_L, ARM_W, H]);
			rotate([90, 0, 0])
			translate([-ARM_L, 0, 0])
			cylinder(r=H/2, h=ARM_W, center=true);
		}
		/* Hole to hold the arm */
		translate([-ARM_L, 0, 0])
		rotate([90, 0, 0])
		cylinder(r=ARM_HOLE_R, h=ARM_W*OFFSET, center=true);
	}
}

module main() {
	union(){
		arm();
		translate([CYL_R, 0, 0])
		handle();
	}
}

main();
