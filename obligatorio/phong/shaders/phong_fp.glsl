varying vec3 N;
varying vec3 v;
uniform sampler2D tex;
uniform int especular;

void main (void)
{
   vec3 L = normalize(gl_LightSource[0].position.xyz - v);
   vec3 E = normalize(-v);
   vec3 R = normalize(-reflect(L,N));

   //Calculo ambiente
   vec4 Iamb = gl_FrontLightProduct[0].ambient;

   //calculo difuso
   vec4 Idiff = gl_FrontLightProduct[0].diffuse * max(dot(N,L), 0.0);
   Idiff = clamp(Idiff, 0.0, 1.0);

   // Calculo especular:
   vec4 Ispec = gl_FrontLightProduct[0].specular * pow(max(dot(R,E),0.0),0.3*gl_FrontMaterial.shininess);
   Ispec = clamp(Ispec, 0.0, 1.0);

   //resultado:
   if(especular == 1)
      gl_FragColor = (gl_FrontLightModelProduct.sceneColor + Iamb + Idiff + Ispec)*texture2D(tex, gl_TexCoord[0].st);
   else
      gl_FragColor = (gl_FrontLightModelProduct.sceneColor + Iamb + Idiff)*texture2D(tex, gl_TexCoord[0].st);


}


