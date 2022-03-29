varying mediump vec2 var_texcoord0;

uniform lowp sampler2D texture_sampler;
uniform lowp vec4 tint;
uniform lowp vec4 u_in;

void main()
{
    float PI = 3.14159;

    vec2 fragCoord = var_texcoord0;
    float iTime = u_in.x;

    vec2 uv = fragCoord.xy -0.5;
    float z = sqrt(1.0 - uv.x * uv.x - uv.y * uv.y);
    float t = 1.0+abs(sin(-PI+iTime/PI));
    float a = 1.0;
    if(t < 2.0)
    	a = 1.0 / 2.5*(t)*(z*tan(90.0/0.5));
    if(t >= 2.0)
        a = 1.0 / (1.0)*(z*tan(90.0/0.5));
    
    vec4 tex = texture2D(texture_sampler, (uv * a) + 0.5);
    gl_FragColor = tex;
}