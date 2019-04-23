ARMS=7;
ARM_R1=2.5;
ARM_R2=1.5;
ARM_LENGTH=20;
BODY_R=3;
BODY_H=5;
CUP_R_IN=9;
CUP_R_OUT=10;
HOLE_R=0.5;
CUT=0;
//$fs=0.3;
//$fa=5;

color("gray")
anemometer();

module anemometer() {
	body();

	if(CUT) {
		difference(){
			make_ring_of(radius = 0, count = ARMS)
				arm();
			cylinder(r=ARM_LENGTH+CUP_R_OUT*2,
				h=CUP_R_OUT,
				center=false);
		}
	} else {
		make_ring_of(radius = 0, count = ARMS)
			arm();
	}
}

module make_ring_of(radius, count) {
	for (a = [0 : count - 1]) {
		angle = a * 360 / count;
		translate(radius * [sin(angle), -cos(angle), 0])
			rotate([0, 0, angle])
				children();
	}
}

module body() {
	difference() {
		cylinder(r=BODY_R,
			h=BODY_H,
			center=true);
		cylinder(r=HOLE_R,
			h=BODY_H*2,
			center=true);
	}
}

module arm(radius) {
	shift=atan(ARM_R2/ARM_LENGTH);

	difference() {
		rotate([-90,0,shift])
			cylinder(r1=ARM_R1,
				r2=ARM_R2,
				h=ARM_LENGTH,
				center=false);

		cylinder(r=BODY_R,
			h=BODY_H,
			center=true);

	}

	translate([0, ARM_LENGTH + CUP_R_IN, 0])
		cup();
}

module cup() {
	rotate([0,90,0])
		difference()
		{
			sphere(CUP_R_OUT);
			sphere(CUP_R_IN);
			cylinder(r=CUP_R_OUT,
				h=CUP_R_OUT,
				center=false);
		}
}

