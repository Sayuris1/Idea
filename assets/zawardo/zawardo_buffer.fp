varying mediump vec2 var_texcoord0;

uniform lowp sampler2D texture_sampler;
uniform lowp vec4 tint;
uniform highp vec4 u_in;

float PI = 3.14159;

void main()
{
    //vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 fragCoord = var_texcoord0;
    vec2 iResolution = vec2(1280, 720);
    float iTime = u_in.x;

    vec2 center = iResolution * 0.5;
    vec2 maximum = vec2(100.0,100.0);
    vec2 uv = fragCoord.xy;

    maximum.x =1.33*sin(1.0+iTime/PI)/PI*500.0+6.0*sin(0.10*fragCoord.x);
    maximum.y = 1.33*sin(1.0+iTime/PI)/PI*500.0+6.0*cos(0.10*fragCoord.x);
    float r = (0.25*distance(fragCoord,center))/abs(distance(center,maximum)*sin(iTime/PI-PI));
    vec3 v1 = vec3(0,0,0);
    if(r < 0.70)
    v1 = vec3(r,r,r*4.0);

    maximum.x = 1.33*sin(0.90+iTime/PI/PI)/PI*500.0+8.0*sin(0.15*fragCoord.x);
    maximum.y = 1.33*sin(0.90+iTime/PI)/PI*500.0+8.0*cos(0.15*fragCoord.y);
    r = (0.25*distance(fragCoord,center))/abs(distance(center,maximum)*sin(iTime/PI-PI));

    vec3 v2 = vec3(0,0,0);
    if(r < 0.70)
    v2 = vec3(r,r,r*3.5);

    maximum.x = 1.33*sin(0.85+iTime/PI)/PI*500.0+12.0*sin(0.20*fragCoord.x);
    maximum.y = 1.33*sin(0.85+iTime/PI)/PI*500.0+12.0*cos(0.20*fragCoord.y);
    r = (0.25*distance(fragCoord,center))/abs(distance(center,maximum)*sin(iTime/PI-PI));

    vec3 v3 = vec3(0,0,0);
    if(r < 0.68)
    v3 = vec3(r*2.5,r,r);

    maximum.x = 1.33*sin(0.80+iTime/PI)/PI*500.0+14.0*sin(0.25*fragCoord.x)+5.0;
    maximum.y = 1.33*sin(0.80+iTime/PI)/PI*500.0+14.0*cos(0.25*fragCoord.x)+5.0;
    r = (0.25*distance(fragCoord,center))/abs((distance(center,maximum)*sin(iTime/PI-PI)));

    vec3 v4 = vec3(0,0,0);
    if(r < 0.65)
    v4 = vec3(r*2.0,r,r);

    vec3 bubble = mix(mix(v1,v2,0.5),mix(v3,v4,0.5),0.5);

    vec4 tex = texture2D(texture_sampler, uv);
    if(r < 0.75)
    tex = vec4(1.0,1.0,1.0,1.0) - texture2D(texture_sampler, uv);
    gl_FragColor = mix(vec4(bubble,1.0),tex,0.5);
}