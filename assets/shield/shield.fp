varying mediump vec2 var_texcoord0;

uniform lowp sampler2D texture_sampler;
uniform lowp vec4 u_in;

const float PI = 3.14159265;

vec2 hash2( vec2 p )
{
    // texture based white noise
    // procedural white noise	
    return fract(sin(vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3))))*43758.5453);
}

vec3 voronoi( in vec2 x, float iTime )
{
    vec2 n = floor(x);
    vec2 f = fract(x);

    //----------------------------------
    // first pass: regular voronoi
    //----------------------------------
    vec2 mg, mr;

    float md = 8.0;
    for( int j=-1; j<=1; j++ )
    for( int i=-1; i<=1; i++ )
    {
        vec2 g = vec2(float(i),float(j));
        vec2 o = hash2( n + g );
        o = 0.5 + 0.5*sin( iTime + 6.2831*o );
        vec2 r = g + o - f;
        float d = dot(r,r);

        if( d<md )
        {
            md = d;
            mr = r;
            mg = g;
        }
    }

    //----------------------------------
    // second pass: distance to borders
    //----------------------------------

    md = 8.0;
    for( int j=-2; j<=2; j++ )
    for( int i=-2; i<=2; i++ )
    {
        vec2 g = mg + vec2(float(i),float(j));
        vec2 o = hash2( n + g );
        o = 0.5 + 0.5*sin( iTime + 6.2831*o );
        vec2 r = g + o - f;

        if( dot(mr-r,mr-r)>0.00001 )
        md = min( md, dot( 0.5*(mr+r), normalize(r-mr) ) );
    }


    return vec3( md, mr );
}


float sphere(float t, float k)
{
    float d = 1.0+t*t-t*t*k*k;
    if (d <= 0.0)
    return -1.0;
    float x = (k - sqrt(d))/(1.0 + t*t);
    return asin(x*t);
}


void main()
{
    vec2 fragCoord = var_texcoord0;
    vec2 iResolution = vec2(500, 200);
    float iTime = u_in.x;
    // bg texture
    vec4 texColor = vec4(0.0);

    vec2 uv = fragCoord.xy - 0.5;
    uv *= 3.0;
    float len = length(uv);
    float k = 1.0;
    float len2;

    len2 = sphere(len*k,sqrt(2.0))/sphere(1.0*k,sqrt(2.0));
    uv = uv * len2 * 0.5 / len;
    uv = uv + 0.5;

    vec2 pos = uv;
    float t = iTime/1.0;
    float scale1 = 40.0;
    float scale2 = 20.0;
    float val = 0.0;

    val += sin((pos.x*scale1 + t));
    val += sin((pos.y*scale1 + t)/2.0);
    val += sin((pos.x*scale2 + pos.y*scale2 + sin(t))/2.0);
    val += sin((pos.x*scale2 - pos.y*scale2 + t)/2.0);
    val /= 2.0;


    vec3 c = voronoi(64.0*pos, iTime );

    float glow = 0.020 / (0.015 + distance(len, 1.0));

    val = (cos(PI*val) + 1.0) * 0.5;
    vec4 col2 = vec4(0.3, 0.7, 1.0, 1.0);

    gl_FragColor = step(len, 1.0) * 0.5 * col2 * val + glow * col2 + 0.5 * texColor;
}