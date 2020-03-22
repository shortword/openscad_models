// Copyright 2020 - Michael Bergeron <mikeb.code@gmail.com>
// Released under the terms of the MIT license

// Creates a PVC pipe topper so you can attach stuff to
// the top of a PVC pipe.
// It is designed to be friction fit, but depending on
// your pipe, materials, printer, etc. it is probably
// good to use a little glue.

in_dia = 26;    // Inner diameter
out_dia = 32;   // Outer diameter
wiggle = 0.2;   // How much "wiggle room"; diameter
thick = 6;      // How thick to make the outer shell
height = 40;    // How tall the cap will be
ring_id = 5;    // Attachment ring inner diameter
ring_thick = 7; // How thick to make the ring

// Computed values
id = in_dia - wiggle;
od = out_dia + wiggle;
total_dia= out_dia + (thick*2);

// Rendering values
$fa=1;
//$fs=2;    // Drafting quality
$fs=0.5;    // Finish quality

// Support Functions
module torus(id, t) {
    rotate_extrude () {
        translate([(id+t)/2, 0, 0]) {
            circle(t/2);
        }
    }
}

module half_torus(id, t) {
    difference() {
        // Create the torus / ring
        torus(id, t);
        
        // Cut half of it off
        max_size = ((id + t) * 2) + 1;
        translate([-max_size, -max_size/2, -max_size/2]) {
            cube(max_size, center=false);
        }
    }
}

module translated_half_torus(id, t) {
    // TODO/FIXME: This would be much better done with actual math
    //             to connect the rings. Right now it is just done
    //             with "wiggle"
    translate([total_dia/2 - wiggle, 0, (ring_id/2) + ring_thick]) {
        rotate([90, 0, 0]) {
            half_torus(ring_id, ring_thick);
        }
    }
}

module rings() {
    translated_half_torus(ring_id, ring_thick);
    mirror([1,0,0]) translated_half_torus(ring_id, ring_thick);
    mirror([1,1,0]) translated_half_torus(ring_id, ring_thick);
    mirror([-1,1,0]) translated_half_torus(ring_id, ring_thick);
}

union() {
    // Outer ring
    difference() {
        // Full outer cylinder
        cylinder(d=total_dia, h=height);
        
        // Remove inner shell
        translate([0, 0, thick]) {
            cylinder(d=od, h=height);
        }
    }
    
    // Inner ring
    translate([0, 0, thick]) {
        difference() {
            cylinder(d=id, h=height-thick);
            cylinder(d=id-thick, h=height-thick+1);
        }
    }

    // Rings
    rings();
}