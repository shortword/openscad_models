pipe_od=32;         // Nominal OD of the pipe (mm)
fudge_factor=0.5;   // Add this much to radius for "fudge factor" (mm)
shelf_l=10;         // Length of the "shelf" for the pipe (mm)
shelf_t=4;          // "Thickness" of the flat area around the pipe mount (mm)

mount_h=7;          // Height of the mount base (mm)
screw_dia=4;        // Diameter of the mounting screws (mm)
screw_head_dia=11;   // Diameter of the screw head (mm)
screw_head_h=5;     // Height of the screw head (mm)

holes = 3;          // Number of screw holes

_od = pipe_od + fudge_factor;
_tot_od = _od + (2*screw_dia) + (2*screw_head_dia);

assert(mount_h > screw_head_h, "ERROR: mount height must be at least the screw head height");

// Rendering values
$fa=1;
//$fs=2;    // Drafting quality
$fs=0.5;    // Finish quality

difference () {

    // The "mount itself"
    union() {
        // Full outer mount
        cylinder(d=_tot_od, h=mount_h);
        
        // Pipe Shelf
        translate([0, 0, mount_h]) {
            cylinder(h=shelf_l, d1=_tot_od, d2=_od+shelf_t);
        }
    }
    
    // Pipe Cutouts
    // Top "drop in" area
    translate ([-_od/2, 0, mount_h]) {
        cube([_od, _tot_od, shelf_l+1]);
    }
    // Bottom cylinder
    translate ([0, 0, mount_h]) {
        cylinder(d=_od, h=shelf_l+1);
    }
    
    // Screw holes
    for (i=[0:holes-1]) {
        rotate(a=i*(360/holes)) {
            c = (_tot_od + _od) / 2;
            translate([0, c/2, 0]) {
                opph = mount_h + shelf_l + 1; // Opportunistic full height
                
                // Screw Hole
                cylinder(d=screw_dia + 0.1, h=opph);
                
                // Screw Head Hole
                head_height = mount_h - screw_head_h;
                translate([0, 0, head_height]) {
                    cylinder(d=screw_head_dia + 0.1, h=opph);
                }
            }
        }
    }
}