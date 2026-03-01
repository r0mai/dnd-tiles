tile_width=30;
tile_border_width=2;
tile_height=5;
notch_size=3;
notch_margin=0.2;

module external_world(x, y) {
    translate([x*tile_width, y*tile_width]) {
        cube([tile_width, tile_width, 2*tile_height], center=true);
    }
}

module outer_cube() {
    cube([tile_width, tile_width, tile_height], center=true);
}

module inner_cube() {
    cube([tile_width-tile_border_width, tile_width-tile_border_width, 2*tile_height], center=true);   
}

module notch(x, y, size, height) {         
    translate([x, y]) rotate([0, 0, 45]) { cube([size, size, height], center=true); }   
    
}

module one_by_one() {
    union() {
        difference() {
            union() {
                difference() { outer_cube(); inner_cube(); }
                difference() { notch(+tile_width*0.5, 0, notch_size-notch_margin, tile_height); inner_cube(); }
                difference() { notch(0, +tile_width*0.5, notch_size-notch_margin, tile_height); inner_cube(); }
            }
            notch(-tile_width*0.5, 0, notch_size*1.8, tile_height*2);
            notch(0, -tile_width*0.5, notch_size*1.8, tile_height*2);
        }
        difference() {
            notch(0, -tile_width*0.5, 2*notch_size, tile_height);
            external_world(0, -1);
            notch(0, -tile_width*0.5, notch_size, 2*tile_height);
        }
        difference() {
            notch(-tile_width*0.5, 0, 2*notch_size, tile_height);
            external_world(-1, 0);
            notch(-tile_width*0.5, 0, notch_size, 2*tile_height);
        }
    }
}

one_by_one();

// translate([tile_width+0.1, 0, 0]) { one_by_one(); }