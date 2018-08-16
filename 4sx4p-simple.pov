//  4 sphere Chaotic Scattering experiment.
//  Copyright (C) R Radev
//  10.Jan.2002

#version 3.7;

global_settings{
    max_trace_level  256      
    assumed_gamma 2.0
}



#include "colors.inc"


#declare R = 3.00000;  // sphere radius

#declare bb = 20.0;
                       
#local aaa = -40;
#local bbb = bb / pow(2, ((frame_number+1)*0.005));
#local xxx = 0.819614759043;
#local yyy = 0.276269539925;
#local zzz = 0.000000;

            
#declare TT  = 1.414213562373095048801688724209;   // sqrt(2)          
#declare CRadius = R * TT;


#declare CameraLocation = <aaa,aaa,aaa*0.9> ;


#declare Camera_1 = camera {
                angle bbb
                sky z
                right    -x*image_width/image_height
                location  CameraLocation
			    look_at   <xxx,yyy,zzz>
}

camera{Camera_1}



#declare DefaultFinish = finish {
  ambient 0
  diffuse 0
  metallic
  reflection {1 metallic 1} ambient 0 diffuse 0
}

#declare PlaneFinish = finish {
  ambient 0.6 
  diffuse 0.2  
  reflection 0.0 
  brilliance 0.3 
  specular 0.4
}

#declare Sphere_Color = color rgb <1.0, 1.0, 1.0> ;
                                                         
                                                 
union {
    sphere {
       <0,0,0>, CRadius translate <R,R,R> 
    }
    sphere {
       <0,0,0>, CRadius translate <R,-R,-R> 
    }
    sphere {
       <0,0,0>, CRadius translate <-R,R,-R> 
    }
    sphere {
       <0,0,0>, CRadius translate <-R,-R,R> 
    }
    pigment { Sphere_Color } finish { DefaultFinish }
}




#declare RR = 50000;
#declare IN = 0.9;
                                  

#declare Lightplane1 = plane { <-RR,-RR,-RR>, 1
	pigment { Scarlet }
	finish { PlaneFinish }
}

#declare Lightplane2 = plane { <-RR,RR,RR> , 1
	pigment { Gold }
    finish { PlaneFinish }
}

#declare Lightplane3 = plane {<RR,-RR,RR>, 1
	pigment { Orange }
    finish { PlaneFinish }
}

#declare Lightplane4 = plane { <RR,RR,-RR>, 1
	pigment { OrangeRed }
    finish { PlaneFinish }
}

union {
    light_source {
        <-RR,-RR,-RR>
        color rgb < IN, IN, IN > 
        looks_like { Lightplane1 }
        photons {refraction off reflection on}
    }
    light_source {
        <-RR,RR,RR>
        color rgb < IN, IN, IN >
        looks_like { Lightplane2 }
        photons {refraction off reflection on}
    }
    light_source {
        <RR,-RR,RR>
        color rgb < IN, IN, IN >
        looks_like { Lightplane3 }
        photons {refraction off reflection on}
    }
    light_source {
        <RR,RR,-RR>
        color rgb < IN, IN, IN >
        looks_like { Lightplane4 }
        photons {refraction off reflection on}
    }
}
              