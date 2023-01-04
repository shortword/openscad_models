include <BOSL/shapes.scad>

base_od=37;
base_ht=50;

ant_mount_od=21;
ant_mount_ht=140;

thickness=6;

// Rendering values
$fa=1;
//$fs=2;    // Drafting quality
$fs=0.5;    // Finish quality

union() {
    // base
    difference() {
        cyl(l=base_ht + thickness, d=base_od + (2*thickness), align=V_UP);
        cyl(l=base_ht, d=base_od, align=V_UP);
    }
    
    // Antenna mount
    translate([0, 0, base_ht + thickness]) {
        difference() {
            cyl(l=ant_mount_ht, d1=base_od + (2*thickness), d2=ant_mount_od + (2*thickness), align=V_UP);
            cyl(l=ant_mount_ht, d=ant_mount_od, align=V_UP);
        }
    }
    
    /*l=base_ht + thickness + ant_mount_ht;
    wh=max(base_od, ant_mount_od) + (2*thickness);
    
    difference() {
        cuboid([l, wh, wh], align=V_RIGHT);
        
        cyl(l=ant_mount_ht, d=ant_mount_od, align=ALIGN_POS, orient=ORIENT_X);
        
        #translate([ant_mount_ht + thickness, 0, 0])
            cyl(l=base_ht, d=base_od, align=ALIGN_POS, orient=ORIENT_X);
    }*/
    
}