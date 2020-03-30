l=25;
h=5;

cent_dia=15;
out_dia=3.5;
off=9.1;

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
                translate([0, 7, -h/2 + 2]) {
                    linear_extrude(h) {
                        text("SO-239", size=5, halign="center", valign="center");
                    }
                }
                translate([0, 0,-h/2 + 2]) {
                    linear_extrude(h){
                        text("15-16.5", size=5, halign="center", valign="center");
                    }
                }
                translate([0, -7, -h/2+2]) {
                    linear_extrude(h){
                        text("3.5mm", size=5, halign="center", valign="center");
                    }
                }
            }
        }
    }
}