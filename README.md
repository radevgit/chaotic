# chaotic
Chaotic Scattering with POV-Ray


This project was created somewhere around 2000 to reproduce the 
[Chaotic Scattering](https://en.wikipedia.org/wiki/Chaotic_scattering) experiment with the help of POV-Ray raytracer.

The .pov file constructs a scene with 4 reflecting spheres and 4 light emitting planes arranged in pyramid, 
where each sphere touches each other. When ray cast from camera enters the space between the spheres it can scatter infinitely 
or exit in any direction. This creates fractal like structure.

The .ini file sets some parameters that provide tradeoff between performance and quality.
POV-Ray produces .png files that can be combined with the help of [avconv](https://libav.org/avconv.html) to create animation.

I use the following command in avconv:


```
avconv -framerate 60 -f image2 -i img/img%04d.png -c:v h264 -crf 1 -pix_fmt yuv444p movie.mp4
```

You can try to change the antialias settings for better quality:
Antialias_Depth=9
Antialias_Threshold=0.001




<a href="http://www.youtube.com/watch?feature=player_embedded&v=qRlseI1eBm0
" target="_blank"><img src="http://img.youtube.com/vi/qRlseI1eBm0/0.jpg" 
alt="Chaotic Scattering" width="240" height="180" border="10" /></a>


![Chaotic Scattering](https://github.com/rradev/chaotic/raw/master/img0091.png "Frame 0091")


![Chaotic Scattering](https://github.com/rradev/chaotic/raw/master/img0564.png "Frame 0564")


![Chaotic Scattering](https://github.com/rradev/chaotic/raw/master/img1309.png "Frame 1309")

