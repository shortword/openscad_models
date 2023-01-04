include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

rod_dia = 4;

term_width = 20;
term_gap = 4;
term_cent_len = 5.5;
term_height = 8; // Does not include the screw terminals
term_len = 24;

so239_width = 25.1;

base_thick = 3;
vert_thick = 2;

so239_epoxy_h = 15 - base_thick;

// Rendering values
$fa=1;
//$fs=2;    // Drafting quality
$fs=0.5;    // Finish quality

module outer_hole(offset, dia) {
    translate([offset, offset, 0]) {
        cyl(d=dia, h=base_thick+1, align=V_UP);
    }
}

module SO239_cutout() {
    // Center
    cyl(d=14.7, h=base_thick+1, align=V_UP);

    // Outside
    outer_hole(9, 3.5);
    mirror ([1,0,0]) outer_hole(9, 3.5);
    mirror ([1,1,0]) outer_hole(9, 3.5);
    mirror ([0,1,0]) outer_hole(9, 3.5);
}

/*module SO239_whole() {
    difference() {
        cuboid([so239_width, so239_width, base_thick], fillet=2, align=V_UP, edges=EDGES_Z_ALL);
        SO239_cutout();
    }
}*/

module leg() {
    union() {
        difference() {
            cuboid([(rod_dia * 1.1) + (2 * vert_thick),
                     100,
                     base_thick + (rod_dia * 1.1)],
                    align=V_BACK+V_UP);
            translate([0, 0, base_thick])
                cuboid([rod_dia * 1.1, 100, rod_dia * 1.1 + 1],
                       align=V_BACK+V_UP);
        }
    }
}

module term_block() {
    x_space = term_width * 1.1;
    y_space = term_len * 1.1;   // If you change here, change in main()
    z_space = term_height;
    
    tot_x = x_space + (2 * vert_thick);
    tot_y = y_space;
    tot_z = z_space + base_thick;
    
    indiv_width = (x_space / 2) - (term_gap * 0.45);
    
    difference() {
        // Outer wall
        cuboid([tot_x, tot_y, tot_z], align=V_UP);
        // Middle
        translate([0, 0, base_thick]) cuboid([x_space, term_cent_len * 1.2, z_space + 1], align=V_UP);
        // Each terminal
        translate([(x_space - indiv_width) / 2, 0, base_thick]) cuboid([indiv_width, y_space + 1, z_space + 1], align=V_UP);
        translate([(x_space - indiv_width) / -2, 0, base_thick]) cuboid([indiv_width, y_space + 1, z_space + 1], align=V_UP);
    }
}

module base() {
    difference(){
        union() {
            // Round base with cutouts
            intersection() {
                cyl(h=base_thick, r=60, align=V_UP);
                up(base_thick/2) yrot(90)
                    sparse_strut(h=120, l=120, max_bridge=vert_thick * 4);
                    //sparse_strut(h=120, l=120, thick=base_thick+1, maxang=45, max_bridge=vert_thick * 3, strut=vert_thick);
            }
            // Base for the SO-239 chassis mount PLUS walls for epoxy well
            translate([0, (term_block_y + (so239_width / 2) + vert_thick) * -1, 0]) {
                difference() {
                    cuboid([so239_width + (2 * vert_thick), so239_width + (2 * vert_thick), base_thick + so239_epoxy_h], align=V_UP, edges=EDGES_Z_ALL);
                    back(vert_thick / 2) up(base_thick)
                        cuboid([so239_width, so239_width + vert_thick, so239_epoxy_h + 1], align=V_UP);
                }
            }
            // Ring around the platform
            tube(h=base_thick, or=60, wall=5, align=V_UP);
        }
    translate([0, (term_block_y + (so239_width / 2)) * -1, 0])
        SO239_cutout();
    }
}

term_block_y = term_len * 1.1;  // If you change here, change in term_block()

union() {
    base();
    // Legs
    translate([-term_width / 2, (rod_dia/2) + vert_thick, 0]) zrot(60) leg();
    translate([term_width / 2, (rod_dia/2) + vert_thick, 0]) zrot(-60) leg();
    // Terminal Block
    translate([0, term_len * -0.55, 0]) term_block();
}