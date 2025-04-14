include <gridfinity/src/core/gridfinity-rebuilt-utility.scad>

// This usses the  gridfinity rebuilt openscad library//
// you can find it  at:
//  https://github.com/kennetek/gridfinity-rebuilt-openscad //

// ===== PARAMETERS ===== //

/* [Setup Parameters] */
$fa = 8;
$fs = 0.25; // .01

/* [General Settings] */

gridz = 5; //.1

/* [Linear Compartments] */
// number of X Divisions (set to zero to have solid bin)
divx = 0;
// number of Y Divisions (set to zero to have solid bin)
divy = 0;

/* [Cylindrical Compartments] */
// number of cylindrical X Divisions (mutually exclusive to Linear Compartments)
cdivx = 0;
// number of cylindrical Y Divisions (mutually exclusive to Linear Compartments)
cdivy = 0;
// orientation
c_orientation = 2; // [0: x direction, 1: y direction, 2: z direction]
// diameter of cylindrical cut outs
cd = 10; // .1
// cylinder height
ch = 1;  //.1
// spacing to lid
c_depth = 1;
// chamfer around the top rim of the holes
c_chamfer = 0.5; // .1

/* [Height] */
// determine what the variable "gridz" applies to based on your use case
gridz_define = 0; // [0:gridz is the height of bins in units of 7mm increments - Zack's method,1:gridz is the internal height in millimeters, 2:gridz is the overall external height of the bin in millimeters]
// overrides internal block height of bin (for solid containers). Leave zero for default height. Units: mm
height_internal = 0;
// snap gridz height to nearest 7mm increment
enable_zsnap = false;

/* [Features] */
// the type of tabs
style_tab = 5; //[0:Full,1:Auto,2:Left,3:Center,4:Right,5:None]
// which divisions have tabs
place_tab = 0; // [0:Everywhere-Normal,1:Top-Left Division]
// how should the top lip act
style_lip = 0; //[0: Regular lip, 1:remove lip subtractively, 2: remove lip and retain height]
// scoop weight percentage. 0 disables scoop, 1 is regular scoop. Any real number will scale the scoop.
scoop = 0; //[0:0.1:1]

/* [Base Hole Options] */
// only cut magnet/screw holes at the corners of the bin to save uneccesary print time
only_corners = false;
//Use gridfinity refined hole style. Not compatible with magnet_holes!
refined_holes = false;
// Base will have holes for 6mm Diameter x 2mm high magnets.
magnet_holes = true;
// Base will have holes for M3 screws.
screw_holes = false;
// Magnet holes will have crush ribs to hold the magnet.
crush_ribs = true;
// Magnet/Screw holes will have a chamfer to ease insertion.
chamfer_holes = true;
// Magnet/Screw holes will be printed so supports are not needed.
printable_hole_top = true;
// Enable "gridfinity-refined" thumbscrew hole in the center of each base: https://www.printables.com/model/413761-gridfinity-refined
enable_thumbscrew = false;

hole_options = bundle_hole_options(refined_holes, magnet_holes, screw_holes, crush_ribs, chamfer_holes, printable_hole_top);


// ===== IMPLEMENTATION ===== //

 // https://upload.wikimedia.org/wikipedia/commons/6/6a/Europlug-scheme.svg

module plug_cutout(){
    translate([0,0,17+19.5])
    rotate([180,0,0])
    union(){
        color("tomato")translate([10,0,17])cylinder(d = 5, h = 19.5);
        color("tomato")translate([10,0,17])cylinder(d1 = 8, d2 = 5, h = 3);
        color("tomato")translate([38-10,0,17])cylinder(d = 5, h = 19.5);
        color("tomato")translate([38-10,0,17])cylinder(d1 = 8,d2 = 5, h = 3);

        linear_extrude(17)polygon([[0,0],[8,8], [30,8],[38,0],[30,-8],[8,-8]]);
    }
}

// multi 1x Plugs

// number of bases along x-axis
gridx = 1;  
// number of bases along y-axis   
gridy = 1;  

difference(){
    union(){   
        gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), height_internal, sl=style_lip){}
        gridfinityBase([gridx, gridy], hole_options=hole_options, only_corners=only_corners, thumbscrew=enable_thumbscrew);
    }
    translate([-45,0,0]){
        for(x =[34:4.5:59]) translate([x,-37/2,5])rotate([0,0,90])plug_cutout();
    }
    translate([0,0,gridz*7])cube([gridx*42, gridy*42, 7.3], center = true);
}

// multi 2x

// // number of bases along x-axis
// gridx = 2;  
// // number of bases along y-axis   
// gridy = 1;  

// difference(){
//     union(){   
//         gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), height_internal, sl=style_lip) {}
//         gridfinityBase([gridx, gridy], hole_options=hole_options, only_corners=only_corners, thumbscrew=enable_thumbscrew);
//     }
//     translate([-44,0,0]) for(x =[12.5:4.5:77]) translate([x,-38/2,5])rotate([0,0,90])plug_cutout();
//     translate([0,0,gridz*7])cube([gridx*42, gridy*42, 7.3], center = true);
// }

// // multi 3x

// // number of bases along x-axis
// gridx = 3;  
// // number of bases along y-axis   
// gridy = 1;  

// difference(){
//     union(){
//         gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), height_internal, sl=style_lip) {}
//         gridfinityBase([gridx, gridy], hole_options=hole_options, only_corners=only_corners, thumbscrew=enable_thumbscrew);
//     }
//     translate([-44,0,0]) for(x =[-10:4.5:99]) translate([x,-38/2,5])rotate([0,0,90])plug_cutout();
//     translate([0,0,gridz*7])cube([gridx*42, gridy*42, 7.3], center = true);
// }

// // multi 4x

// // number of bases along x-axis
// gridx = 4;  
// // number of bases along y-axis   
// gridy = 1;  

// difference(){
//     union(){   
//         gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), height_internal, sl=style_lip) {}
//         gridfinityBase([gridx, gridy], hole_options=hole_options, only_corners=only_corners, thumbscrew=enable_thumbscrew);
//     }
//     translate([-45,0,0]) for(x =[-29.5:4.51:122]) translate([x,-38/2,5])rotate([0,0,90])plug_cutout();
//     translate([0,0,gridz*7])cube([gridx*42, gridy*42, 7.3], center = true);
// }
