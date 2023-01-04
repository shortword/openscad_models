include <BOSL/shapes.scad>
include <BOSL/constants.scad>

max_dim=180; // Maximum of width or depth
zip_width=10; // Ziptie slot witdth
zip_thick=1; // Ziptie slot "thickness"

sma_hole=6.7;

mount_od=33;
mount_ht=50;

thick=4;

// Rendering values
$fa=1;
//$fs=2;    // Drafting quality
$fs=0.5;    // Finish quality

module zip_hole() {
    translate([thick, 0, 0])
        slot([0,0,0], [0, zip_thick, 0], r=zip_thick/2, h=thick+0.1);
}

module zip_slot() {
    translate([thick/2, 0, 0])
        slot([0,0,0], [0, zip_thick, 0], r=zip_thick/2, h=thick+0.1);
    
    translate([-thick/2, 0, 0])
        slot([0,0,0], [0, zip_thick, 0], r=zip_thick/2, h=thick+0.1);
}

module arm() {
    sq_leg = max_dim/2;
    l = sq_leg/(sin(60));
    
    difference() {
        // Main arm
        cuboid([thick*2, l, thick], align=V_BACK);
        
        // slots for attach (zip ties)
        translate([0, l*0.4, 0])
            zip_slot();
        
        translate([0, l*0.9, 0])
            zip_slot();
    }
}

module arms() {
    difference() {
        union() {
            translate([0, 0, thick/2])
                rotate([0,0,60])
                    arm();
            translate([0, 0, thick/2])
                rotate([0,0,-60])
                    arm();
        }
        
        /*translate([0, 0, thick/2])
            cyl(d=sma_hole, h=thick);*/
    }
}

module pvc_mount() {
    difference() {
        cyl(d=mount_od + (2*thick), h=mount_ht + thick, align=V_UP);
        translate([0, 0, thick])
            cyl(d=mount_od, h=mount_ht, align=V_UP);
        
        zip_slot();
        
        //cyl(d=sma_hole, h=thick*2);
    }
}

union() {
    arms();
    pvc_mount();
}