#version 3.5;

#include "colors.inc"
#include "textures.inc"

// Observation of Saturn a 2015-016T00:00:00.000
// X = 19166.97039158
// Y = 52606.29063610
// Z = 20118.41574244
// R = 59494.07718813

#declare SS_lon =  290; // Subsolar longitude [deg_W]
#declare SS_lat =   20; // Subsolar latitude  [deg_N]
#declare D_Sun  = 1500000000; // Sun      distance [km]

#declare SC_lon =       0; // Observer longitude [deg_W]
#declare SC_lat =      15; // Observer latitude  [deg_N]
#declare D_Obs  = 4547001; // Observer distance [km]

#declare Inst_Angle = 3.5179608621032543; // ISS Wide Angle Camera

#declare R_Saturn = 59494; // Saturn Radius [km]

// Convert Latitude/Longitude coordinates in XYZ
#macro XYZ(lon,lat)
  <cos(radians(-lon))*cos(radians(lat)),sin(radians(lat)),sin(radians(-lon))*cos(radians(lat))>
#end

#macro ring(rmin,rmax,op)
   disc { 
      <0,0,0> // center position 
      y, // normal vector 
      rmax, // outer radius 
      rmin // optional hole radius 
      pigment {
         rgb<1.,.88,.78> filter op
      }
      finish {
         ambient 0
         diffuse 2
      }
   } 
#end

// Sub-solar point
#declare SS = XYZ(SS_lon,SS_lat);
#declare SC = XYZ(SC_lon,SC_lat);

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

sphere {
   <0,0,0> R_Saturn
   texture {
      pigment{
         image_map {
            jpeg "saturnmap.jpg"
            map_type 1
            interpolate 4
         }
      }
      finish { 
         ambient .001
         diffuse 1
         phong .01
      }
   }
}

#include "src/C_Ring.dat"
#include "src/B_Ring.dat"
#include "src/C_Div.dat"
#include "src/A_Ring.dat"
