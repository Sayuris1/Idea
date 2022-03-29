varying mediump vec2 var_texcoord0;

uniform lowp sampler2D texture_sampler;
uniform lowp vec4 u_in;

const float PI = 3.14159265;

float hash12(vec2 p)
{
	vec3 p3  = fract(vec3(p.xyx) * .1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}


void main()
{
    vec2 fragCoord = var_texcoord0;
    vec2 iResolution = vec2(500, 200);
    float iTime = u_in.x;
    // bg texture
    vec4 texColor = vec4(0.0);

    float random = hash12(var_texcoord0 * iTime);
    
    lowp vec4 tint_pm;
    if (random <= u_in.y){
        tint_pm = vec4(vec3(1.0) * 1.0, 1.0);
    }

    else{
        tint_pm = vec4(vec3(1.0) * 0.0, 0.0);
    }

    gl_FragColor = texture2D(texture_sampler, var_texcoord0.xy) * tint_pm;
}