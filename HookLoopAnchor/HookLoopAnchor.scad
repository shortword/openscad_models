include <BOSL/shapes.scad>
include <BOSL/constants.scad>

strap_w = 20;
strap_h = 2;
wiggle = 0.1 * 2;   // 0.1mm on each width & height

thick = 3;          // Thickness of printed parts
fillet_r = 1;       // Fillet radius

total_w = strap_w + wiggle + (thick * 2);
total_h = (thick * 2) + strap_h + wiggle;

qrtr = total_w / 2 - (thick / 2);

// Rendering settings
$fa=1;
//$fs=2;    // Drafting quality
$fs=0.5;    // Finish quali


union() {
    // Base
    cuboid([total_w, total_w, thick],
            align=V_UP,
            fillet = fillet_r);
    
    // Design choice: I wanted to fillet all of the edges
    // so I've done away with the "difference" approach.
    
    // Arms
    translate([qrtr, qrtr, 0])
        cuboid([thick, thick, total_h],
                align=V_UP,
                fillet= fillet_r);
    translate([qrtr, -qrtr, 0])
        cuboid([thick, thick, total_h],
                align=V_UP,
                fillet= fillet_r);
    translate([-qrtr, qrtr, 0])
        cuboid([thick, thick, total_h],
                align=V_UP,
                fillet= fillet_r);
    translate([-qrtr, -qrtr, 0])
        cuboid([thick, thick, total_h],
                align=V_UP,
                fillet=fillet_r);
    
    // Top
    translate([qrtr, 0, thick + strap_h + wiggle])
        cuboid([thick, total_w, thick],
                align=V_UP,
                fillet=fillet_r);
    translate([-qrtr, 0, thick + strap_h + wiggle])
        cuboid([thick, total_w, thick],
                align=V_UP,
                fillet=fillet_r);
    translate([0, qrtr, thick + strap_h + wiggle])
        cuboid([total_w, thick, thick],
                align=V_UP,
                fillet=fillet_r);
    translate([0, -qrtr, thick + strap_h + wiggle])
        cuboid([total_w, thick, thick],
                align=V_UP,
                fillet=fillet_r);
};