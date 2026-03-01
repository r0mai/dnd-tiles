width = 30;
thickness = 2;
height = 8;
hook_height = 2;
hook_width = 10;
margin = 0.2;


module outer_cube() {
    cube([width, width, height], center=true);
}

module inner_cube() {
    cube([width-2*thickness, width-2*thickness, 2*height], center=true);   
}

module hook(x, y, m) {

    translate([x*0.5*width, 0, (hook_height-height)*0.5]) {
        cube([hook_width, 3*thickness, hook_height+m], center=true); // hook bottom cube
        translate([0, thickness, thickness]) {
            cube([hook_width, thickness - margin, 2*hook_height], center=true); // hook side cube
        }
    }
}

module one_by_one() {
    union() {
        difference() { outer_cube(); inner_cube(); }
    }
}



difference() {
    union() {
        difference() { outer_cube(); inner_cube(); }    
        rotate(00) translate([0, width*0.5 + 0.5*thickness, 0]) { hook(0, 1, 0); }
        rotate(90) translate([0, width*0.5 + 0.5*thickness, 0]) { hook(0, 1, 0); }
    }
    rotate(180) translate([0, width*0.5 + 0.5*thickness, 0]) { hook(0, 1, margin); }
    rotate(270) translate([0, width*0.5 + 0.5*thickness, 0]) { hook(0, 1, margin); }
}


// translate([tile_width+0.1, 0, 0]) { one_by_one(); }