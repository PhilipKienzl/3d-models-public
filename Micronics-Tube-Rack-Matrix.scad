module hole() {
    hull(){
        union() {
            translate([0,0,6])cube([8, 8, 38]);
            translate([4,4,3]) cylinder(h=3,r1=3,r2=4,$fn=60);
            translate([4, 4, 0]) cylinder(h=3, r1=3, r2=3,$fn=60);
        }
    }
}

module matrix() {
    for (i = [0:7]) {
        for (j = [0:11]) {
            translate([11 + (j * 8 + j), 7 + (i * 8 + i * (8 / 7)), -0.01]) hole();
        }
    }
    alphabet = ["A","B","C","D","E","F","G","H"];
    nummeros = ["1","2","3","4","5","6","7","8","9","10","11","12"];
    //
    for(i = [0:11]) {
        translate([15+9*i, 81.5, 21.5]) linear_extrude(1) text(nummeros[i], size = 4, valign = "center", halign = "center");
    }
    
    for(i = [0:7]) {
        translate([6, 75 - (i * 8 + i * (8 / 7)), 21.5]) linear_extrude(1) text(alphabet[i], size = 4, valign = "center", halign = "center");
    }
    
    // HEB LAB
    translate([65,1,11]) rotate([87,0,0]) linear_extrude(1) text("NAME", size = 10, valign = "center", halign = "center");
    
    translate([65,85,11]) rotate([93,0,180]) linear_extrude(1) text("NAME", size = 10, valign = "center", halign = "center");
    
}

module foot() {
    h = 5;
    b = 3;
    l = 10;
    
    poin1 = [
    [0,l,0],
    [0,0,0],
    [b,0,0],
    [b,l,0],
    [0,l,h],
    [0,0,h],
    [b,0,h],
    [b,l,h]
    ];
    
    poin2 = [
    [0,b,0],
    [0,0,0],
    [l,0,0],
    [l,b,0],
    [0,b,h],
    [0,0,h],
    [l,0,h],
    [l,b,h]
    ];

    translate([0,0,-h]){
        union(){
            hull(){
                for (point = poin1) {
                    translate(point)
                    sphere(d=2,$fn=20);  // Adjust the radius as needed
                }
            }
            hull(){
                for (point = poin2) {
                    translate(point)
                    sphere(d=2,$fn=20);  // Adjust the radius as needed
                }
            }
        }
    }
}

module rack_with_holes() {
    pp = [
    [1, 1, 1],
    [128, 1, 1],
    [128, 85, 1],
    [1, 85, 1],
    [2, 2, 21],
    [127, 2, 21],
    [127, 84, 21],
    [2, 84, 21]
    ];
    
    difference() {
        hull(){
            for (point = pp) {
                translate(point) sphere(d=2,$fn=20);
            }
        }
        matrix();
    }
}

union() {
    rack_with_holes();
    translate([1, 1, 1]) foot();
    translate([128,1,1])rotate([0,0,90]) foot();
    translate([128,85,1]) rotate([0,0,180]) foot();
    translate([1,85,1]) rotate([0,0,270]) foot();
}
