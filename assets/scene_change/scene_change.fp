varying mediump vec2 var_texcoord0;

uniform highp sampler2D texture_sampler0;
uniform highp sampler2D texture_sampler1;
uniform highp vec4 u_in;

const float PI = 3.14159265;

float hash12(vec2 p)
{
    return step(0.45, texture2D(texture_sampler0, p).x);
}


void main()
{
    float iTime = u_in.x;
    // bg texture
    vec4 texColor = vec4(0.0);

    float random = hash12(var_texcoord0 * iTime);
    
    if (random <= u_in.y){
        gl_FragColor = texture2D(texture_sampler1, var_texcoord0.xy) * 1.0;
    }

    else{
        gl_FragColor = texture2D(texture_sampler1, var_texcoord0.xy) * 0.0;
    }
}