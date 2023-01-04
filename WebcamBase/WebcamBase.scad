include <BOSL/metric_screws.scad>
include <BOSL/shapes.scad>
include <BOSL/transforms.scad>

rod=8;
leg_len=80;
ht=10;

legs=3;

cent_ht=30;
cent_fillet=5;
cent_d = cent_ht * 1.5;

// Rendering values
$fa=1;
//$fs=2;    // Drafting quality
$fs=0.5;    // Finish qua

module center() {
    difference () {
        top_half()
            cyl(l=cent_ht * 2, d=cent_d, fillet=cent_fillet);
        
        // Rod hole
        cylinder(d=rod*1.1, h=cent_ht);
        
        // Nut slots
        // Bottom
        sphere(d=rod*3); // Sphere to print w/o supports, but available spot to but a nut
        // Top
        scale([1.05, 1.05, 1.05])
            translate([0, 0, cent_ht - get_metric_nut_thickness(size=rod)])
                metric_nut(size=rod, hole=false);
        
    }
}

module leg() {
    zscale(cent_ht/ht * 0.75)
        xscale(leg_len / ht)
            top_half()
                right_half()
                    sphere(ht);
}

module legs() {
    ang = 360/legs;
    count = legs - 1;
    for (i = [0:count]) {
        rotate([0, 0, ang * i])
            translate([(cent_d - (cent_fillet))/2, 0, 0])
                leg();
    }
}

union() {
    center();
    legs();
}
