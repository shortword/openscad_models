include <BOSL/metric_screws.scad>
include <BOSL/shapes.scad>
include <BOSL/transforms.scad>

rod=8;

_gmnt = get_metric_nut_thickness(size=rod) * 1.05;
_gmns = get_metric_nut_size(size=rod) * 1.02;

thick=_gmnt + 2;
l=80;
w=35;

cam_screw_hole=6.5;
cam_screw_depth=4;
cam_screw_head_dia=15;

// Rendering values
$fa=1;
//$fs=2;    // Drafting quality
$fs=0.5;    // Finish quality

rotate([0, 90, 0]) {  // The bridges are better "vertical" though a brim may be needed
    difference() {
        cuboid([l, w, thick], fillet=1, align=V_UP);
        
        // Camera screw hole
        _d2 = cam_screw_head_dia * 1.5;
        translate([(l/2) - (_d2/2) - 4, 0, 0]) {
            cyl(d=cam_screw_hole, h=thick, align=V_UP);
            translate([0, 0, cam_screw_depth])
                cyl(d1=cam_screw_head_dia, d2=_d2, h= thick - cam_screw_depth, align=V_UP);
        }
        
        // Rod hole
        translate([(-l/2)+ (_gmns*1.5), 0, 0]) {
            // Rod hole
            cyl(d=rod*1.25, h=thick, align=V_UP);
            // Nut outline
            translate([0, 0, (thick/2) - (_gmnt/2)]) {
                // Nut
                scale(1.02)
                    metric_nut(size=rod, hole=false);
                // Nut instert slot
                translate([-l*0.125, 0, 0])
                    cuboid([l*0.25, _gmns, _gmnt], align=V_UP);
            }
        }
    }
}