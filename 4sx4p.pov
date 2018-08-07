//  4 sphere Chaotic Scattering experiment.
//  Copyright (C) R Radev
//  10.Jan.2002

#version 3.7;

global_settings{
    max_trace_level  256      
    assumed_gamma 2.2
}



#include "colors.inc"


#declare R = 3.00000;  // sphere radius

#declare aa = 100.0;
#declare bb = 30.0;


#if (frame_number <= 600)    // Sphere rotation
    #local RRR = 180*(600-frame_number)/600;
#end

#if (frame_number > 600)
    #local RRR = 0;
#end


#if (frame_number <= 600)
	#local aaa = 40; // camera location
	#local bbb = 10 + (20/600  * frame_number);  // camera zoom 
	#local ccc = 0 ;                             // look_at point
	#local vvv = 0 ;                             // look_at point
#end



#if ((frame_number >  600)&(frame_number <= 800))  // Change numbers below to find interesting points.
	#local aaa = 40 - 32*(frame_number-600)/200;
	#local bbb = bb / pow(2, ((frame_number-600)*0.01));
    #local ccc = 0.0;
    #local vvv = 0.0;
#end

#if ((frame_number > 800)&(frame_number <=1000))
    #local aaa = 8 - 7.5*(frame_number-800)/200;
    #local bbb = bb / 4;
    #local ccc = -0.490784467761 * (frame_number-800)/200;
    #local vvv = -1.002277127387 * (frame_number-800)/200;
#end 

#if (frame_number > 1000)
    #local aaa = 0.5;
    #local bbb = bb / pow(2, ((frame_number-800)*0.01));
    //#local bbb = bb/0.8;
    #local ccc = -0.490784467761;       // magic points
    #local vvv = -1.002277127387;
#end


            
#declare TT  = 1.414213562373095048801688724209;   // sqrt(2)          
#declare CRadius = R * TT;


#declare CameraLocation = <-aaa,-aaa,-aaa> ;


#declare Camera_1 = camera {
                angle bbb
                sky z
                right    -x*image_width/image_height
                location  CameraLocation
			    look_at   <-vvv, vvv, ccc>  // First sphere center.
}

camera{Camera_1}



#declare DefaultFinish = finish {
  ambient 0.0
  diffuse 0.00
  //specular 1.0
  roughness 0.000001
  metallic
  reflection {1.0 metallic 1.0} ambient 0 diffuse 0
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
    rotate <0,RRR,0>
}




#declare RR = 10000;
#declare IN = 0.9;
                                  

#declare Lightplane1 = plane { <-RR,-RR,-RR>, 1
	pigment { Scarlet }
	finish { PlaneFinish }
}

#declare Lightplane2 = plane { <-RR,RR,RR> , 1
	pigment { BrightGold }
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
              
