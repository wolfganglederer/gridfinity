include <gridfinity/src/core/gridfinity-rebuilt-utility.scad>

// This usses the  gridfinity rebuilt openscad library//
// you can find it  at:
//  https://github.com/kennetek/gridfinity-rebuilt-openscad //

// ===== PARAMETERS ===== //

/* [Setup Parameters] */
$fa = 8;
$fs = 0.25; // .01

/* [General Settings] */

gridx = 1;
gridy = 1;
gridz = 4; //.1

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

// Pritt glue-stick

difference(){
    union(){
        gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), height_internal, sl=style_lip){}
        gridfinityBase([gridx, gridy], hole_options=hole_options, only_corners=only_corners, thumbscrew=enable_thumbscrew);
    }
    #translate([0,0,5+12])cylinder(r=31.2/2, h=14, center=true, $fn = 70);
    #translate([0,0,5+14+7])cylinder(r1=31.2/2, r2 = 34/2, h=4, center=true, $fn = 70);
}
