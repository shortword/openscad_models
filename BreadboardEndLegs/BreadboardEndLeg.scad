include <BOSL/shapes.scad>

metal_thick=1.05;    // Thickness of the metal base
fil_thick=4;        // Thickness of the filament areas
l=132;              // Length of the metal base at the end
h=11;               // Height of the slot above the bottom

// Rendering settings
$fa=1;
//$fs=2;    // Drafting quality
$fs=0.5;    // Finish quality

th = fil_thick * 2;

difference() {
    // Outer "box"
    cuboid([l + (2*fil_thick),
            h + (2*fil_thick) + metal_thick,
            th],
           fillet=1,
           align=V_BACK);
    
    // "Legs" cutout
    cuboid([l*0.9, h, th], align=V_BACK);
    
    // Metal cutout
    #translate([0, h+fil_thick, th/4]) {
        cuboid([l, metal_thick, th/2], align=V_BACK);
    }
}