// @brief    Render a synthetic image of Saturn and its rings under specific geometry conditions
// @author   B.Seignovert (univ-reims@seignovert.fr)
// @date     2016/09/30
//----------------------------------------------------

#version 3.5;

#include "colors.inc"

#local SC_lon =          0; // Observer longitude [deg_W]
#local SC_lat =         15; // Observer latitude  [deg_N]
#local D_Obs  =    4500000; // Observer distance [km]

#local SS_lon =        290; // Subsolar longitude [deg_W]
#local SS_lat =         20; // Subsolar latitude  [deg_N]

#local D_Sun  = 1500000000; // Sun  distance [km]
#local Inst_Angle =   3.52; // ISS Wide Angle Camera

#declare Map_Surface = "maps/Saturn_Jonsson_Cassini.jpg"

// Convert Latitude/Longitude coordinates in XYZ
#macro XYZ(lon,lat)
  <cos(radians(-lon))*cos(radians(lat)),sin(radians(lat)),sin(radians(-lon))*cos(radians(lat))>
#end

// Sub-solar point
#local SS = XYZ(SS_lon,SS_lat);
#local SC = XYZ(SC_lon,SC_lat);

camera {
   angle Inst_Angle
   location SC * D_Obs
   look_at <0,0,0>
   right x*image_width/image_height
}            
        
light_source{ 
   SS * D_Sun
   color White
} 
   
#include "src/Saturn.inc"
object { Saturn }
