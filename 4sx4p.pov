//  4 sphere Chaotic Scattering experiment.
//  Copyright (C) R Radev
//  10.Jan.2002

#version 3.7;

global_settings{
    max_trace_level  256      
    assumed_gamma 2.2
}



#include "colors.inc"


#declare aa = 100.0;
#declare bb = 30.0;

#if (frame_number <= 600)
	#local aaa = aa - (99.9/600 * frame_number);
	#local bbb = 10 + (20/600  * frame_number);
#end

#if (frame_number >  600)
	#local aaa = 0.1;
	#local bbb = bb / pow(2, ((frame_number-600)*0.01));
#end


#if (frame_number <= 600)
	#local ccc = 0.0117633771 * (frame_number)/600 ;
#end


#if ((frame_number >  600)&(frame_number <= 700))
        #local ccc = 0.0117633771 + (0.23503251011-0.0117633771) * (frame_number-600)/100 ;
#end

#if (frame_number >  700)
        #local ccc = 0.23503251011;
#end




#declare CameraLocation = <0,0,aaa> ;


#declare Camera_1 = camera {angle bbb
                            sky y
                            right    -x*image_width/image_height
                            location  <0,0,0>
                            
                            translate CameraLocation
			    look_at   <0.001209241301, ccc, -1>
}

camera{Camera_1}

//background { color rgb < 1.0, 1.0, 1.0 > }

// A back wall 
/*plane { <0,0,1>, 100 
   pigment {
      checker Black, White scale 50
    } 
finish {
  ambient 0.3
  diffuse 0.2 
  reflection 0.01
  brilliance 0.3
  specular 0.4
}
}
*/


#declare DefaultFinish = finish {
  ambient 0.0
  diffuse 0.00
  specular 1.0
  roughness 0.00001
  metallic
  reflection {
	1.00	
  	metallic
  } 
}

#declare PlaneFinish = finish {
  ambient 0.6 
  diffuse 0.2  
  reflection 0.0 
  brilliance 0.3 
  specular 0.4
}

#declare Sphere_Color = color rgb < 1.0, 1.0, 1.0> ;


#declare SphereObject = sphere {
  <0,0,0>, 1
  texture { finish { DefaultFinish } }
}


#declare R = 3.00000;

#declare CRadius = R * 0.866025 ;

union {
	object { SphereObject   // C_1
		pigment { Sphere_Color }
		scale CRadius
		translate <  0.000000 * R, 1.000000 * R, 0.000000 * R > 
	}
	object { SphereObject   // C_2
		pigment { Sphere_Color }
		scale CRadius
		translate <  0.866025 * R,-0.500000 * R, 0.000000 * R > 
	}
	object { SphereObject   // C_3
		pigment { Sphere_Color }
		scale CRadius
		translate < -0.866025 * R,-0.500000 * R, 0.000000 * R > 
	}
	object { SphereObject   // C_4
		pigment { Sphere_Color }
		scale CRadius
		translate <  0.000000 * R, 0.000000 * R,-1.802776 * R > 
	}
}

#declare RR = -10000;
#declare IN = 0.9;


#declare Lightplane1 = plane { < 0.000000 * RR, 1.000000 * RR, 1.802776 * RR >, 1
	//pigment {color rgb <0.75, 0.08, 0.08>} 
	pigment { Scarlet }
	finish { PlaneFinish }
}

#declare Lightplane2 = plane { < 0.866025 * RR,-0.500000 * RR, 1.802776 * RR >, 1
        //pigment {color rgb <0.08, 0.75, 0.08>}
	pigment { BrightGold }
        finish { PlaneFinish }
}

#declare Lightplane3 = plane { < -0.866025 * RR,-0.500000 * RR, 1.802776 * RR >, 1
        //pigment {color rgb <0.08, 0.08, 0.75>}
	pigment { Orange }
        finish { PlaneFinish }
}

#declare Lightplane4 = plane { <  0.0, 0.0, 101.0>, 1
        //pigment {color rgb <0.08, 0.08, 0.75>}
	pigment { OrangeRed }
        finish { PlaneFinish }
}

light_source {
    < 0.000000 * RR, 1.000000 * RR, 1.802776 * RR >
    color rgb < IN, IN, IN >
    looks_like { Lightplane1 }
    photons {refraction off reflection on}
}
light_source {
    < 0.866025 * RR,-0.500000 * RR, 1.802776 * RR >
    color rgb < IN, IN, IN >
    looks_like { Lightplane2 }
    photons {refraction off reflection on}
}
light_source {
    < -0.866025 * RR,-0.500000 * RR, 1.802776 * RR >
    color rgb < IN, IN, IN >
    looks_like { Lightplane3 }
    photons {refraction off reflection on}
}

light_source {
    <0.0,0.0,101.0>
    color rgb < IN, IN, IN >
    looks_like { Lightplane4 }
    photons {refraction off reflection on}
}

