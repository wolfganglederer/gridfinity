include <gridfinity/src/core/gridfinity-rebuilt-utility.scad>

// This usses the  gridfinity rebuilt openscad library//
// you can find it  at:
//  https://github.com/kennetek/gridfinity-rebuilt-openscad //

// ===== INFORMATION ===== //
/*
 IMPORTANT: rendering will be better for analyzing the model if fast-csg is enabled. As of writing, this feature is only available in the development builds and not the official release of OpenSCAD, but it makes rendering only take a couple seconds, even for comically large bins. Enable it in Edit > Preferences > Features > fast-csg
 the magnet holes can have an extra cut in them to make it easier to print without supports
 tabs will automatically be disabled when gridz is less than 3, as the tabs take up too much space
 base functions can be found in "gridfinity-rebuilt-utility.scad"
 examples at end of file

 BIN HEIGHT
 the original gridfinity bins had the overall height defined by 7mm increments
 a bin would be 7*u millimeters tall
 the lip at the top of the bin (3.8mm) added onto this height
 The stock bins have unit heights of 2, 3, and 6:
 Z unit 2 -> 7*2 + 3.8 -> 17.8mm
 Z unit 6 -> 7*6 + 3.8 -> 45.8mm

https://github.com/kennetek/gridfinity-rebuilt-openscad

*/

// ===== PARAMETERS ===== //

/* [Setup Parameters] */
$fa = 8;
$fs = 0.25; // .01

/* [General Settings] */

gridz = 6; //.1
gridx = 1;
gridy = 1;

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

difference(){
union(){
        gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), height_internal, sl=style_lip){}
        gridfinityBase([gridx, gridy], hole_options=hole_options, only_corners=only_corners, thumbscrew=enable_thumbscrew);
    }

// Olfa negative

#translate([-12.6,4,4.8])difference(){
    union(){
        translate([0,0,-2])cube([22,6.2,19]);
        translate([-5,-4,17])cube([35,15.2,30]);
        }
    translate([-5,-5,17])rotate([0,65,0])cube([20,5,40]);
    translate([-5,6.2,17])rotate([0,65,0])cube([20,8,40]);
    translate([22,-1,29.6])rotate([0,65,0])cube([10,30,20]);
    translate([22,-5,9.5])cube([10,30,20]);
    }
    translate([-5,-15,1])cube([9.5,4.5,80]);
}


