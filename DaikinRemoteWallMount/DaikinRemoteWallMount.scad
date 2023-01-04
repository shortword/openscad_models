include <BOSL/shapes.scad>
include <BOSL/transforms.scad>
include <BOSL/constants.scad>

// Tesa powerstrip
tp_len = 80;
tp_stick = 65;
tp_gap = 1;
tp_tab = tp_len - tp_stick;
tp_wid = 20;

%downcube([tp_wid, tp_stick, 1]);
translate([0, ((tp_stick / 2) + (tp_tab / 2) + 1) * -1, 0]) 
    %downcube([tp_wid, tp_tab, 1]);

// Hook
hook_wid_bot = 17.8;
hook_hi = 23.0;
hook_round_dia = 13.5;
hook_thick = 2;
hook_offset_top = 4.7;
hook_offset_bot = 3.0;

// Pin
pin_dia = 4;
pin_tri_hi = 10.5;
pin_tri_base = 12;
pin_gap = 3.0;

tot_wid = tp_wid + 5;
tot_hi = tp_stick + 2;
base_thick = 5;

// Rendering settings
$fa=1;
//$fs=2;    // Drafting quality
$fs=0.2;    // Finish quality

union () {
    // Base
    cuboid([tot_wid, tot_hi, base_thick],
           align=V_UP,
           fillet=2, edges=EDGES_TOP);
    
    // Pin
    union() {
        translate([0, pin_gap + pin_tri_hi + (pin_dia / 2), base_thick])
            cylinder(h=hook_offset_top, d=pin_dia);
        translate([0, pin_gap + (pin_tri_hi / 2), base_thick])
            rounded_prismoid(size1=[pin_tri_base, hook_offset_top],
                             size2=[pin_dia / 2, hook_offset_top],
                             h=pin_tri_hi + (pin_dia / 2),
                             orient=ORIENT_Y,
                             r=0);
    }
    
    // Hook
    union() {
        translate([0, -(hook_thick / 2), base_thick]) {
            cuboid([hook_wid_bot - 1, hook_thick, hook_offset_bot + hook_thick],
                   align=V_UP,
                   fillet=1, edges=EDGES_TOP);
        translate([0, (hook_hi - (hook_round_dia / 2) - hook_thick) / 2, hook_offset_bot])
            union() {
                    rounded_prismoid(size1=[hook_wid_bot, hook_thick],
                                     size2=[hook_round_dia, hook_thick],
                                     h=hook_hi - (hook_round_dia / 2),
                                     orient=ORIENT_Y, r=1);
                    translate([0, hook_hi - hook_round_dia - hook_thick, 0])
                        cyl(h=hook_thick, d=hook_round_dia, fillet=1,
                            chamfer=0, align=V_UP);
            }
        }
    }
}


