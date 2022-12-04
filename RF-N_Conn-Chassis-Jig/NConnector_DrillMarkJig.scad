thick=3;

cent_dia=14; // Measured with calipers

out_dia=3.5; // From datasheet of .126"; convert to 3.2 mm; measure 3.4. 3.5 selected for drill bit size

// Data sheet indicates 0.719" between mounting screw holes
// Converts to 18.2626mm
// Split in half to as one "x" and one "y" translation from center
off=9.1313;

// This identifies the jig / stencil
l=25;
h=2;
with_tab=true;

// Rendering values
$fa=1;
//$fs=2;    // Drafting quality
$fs=0.5;    // Finish quality

module out_hole(off, dia) {
    translate([off, off, 0]) {
        cylinder(d=dia, h=h+1, center=true);
    }
}

union () {
    difference () {
        cube([l, l, h], center=true);
        
        // Center
        cylinder(d=cent_dia, h=h+1, center=true);
        
        // Outside
        out_hole(off, out_dia);
        mirror ([1,0,0]) out_hole(off, out_dia);
        mirror ([1,1,0]) out_hole(off, out_dia);
        mirror ([0,1,0]) out_hole(off, out_dia);
    }
    
    // Reminder / grip side tab
    if (with_tab) {
        translate([l, 0, 0]) {
            difference () {
                cube([l,l,h], center=true);
                
                // Reminder Text
                translate([0, 7, -h/2 + h*0.5]) {
                    linear_extrude(h) {
                        text("RF N", size=5, halign="center", valign="center");
                    }
                }
                translate([0, 0,-h/2 + h*0.5]) {
                    linear_extrude(h){
                        text("14mm", size=5, halign="center", valign="center");
                    }
                }
                translate([0, -7, -h/2+ h*0.5]) {
                    linear_extrude(h){
                        text("3.5mm", size=5, halign="center", valign="center");
                    }
                }
            }
        }
    }
}