varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float pixel_h;
uniform float pixel_w;

void main()
{
	vec2 offset_x;
	offset_x.x = pixel_w;
	vec2 offset_y;
	offset_y.y = pixel_h;
 
	vec3 outline_c	= vec3(0.4,0.1,0.4);
	vec3 c_add		= vec3(0.0,0.0,0.0);
	
	float alpha	  = texture2D( gm_BaseTexture, v_vTexcoord).a;
	float e_alpha = texture2D( gm_BaseTexture, v_vTexcoord + offset_x).a;
	float w_alpha = texture2D( gm_BaseTexture, v_vTexcoord - offset_x).a;
	float s_alpha = texture2D( gm_BaseTexture, v_vTexcoord + offset_y).a;
	float n_alpha = texture2D( gm_BaseTexture, v_vTexcoord - offset_y).a;
	
	if (alpha == 0.0) {
		c_add += outline_c;
		
		if (alpha != e_alpha){
			alpha += ceil(e_alpha);
		} else if (alpha != w_alpha){
			alpha += ceil(w_alpha);
		} else if (alpha != s_alpha){
			alpha += ceil(s_alpha);
		} else if (alpha != n_alpha){
			alpha += ceil(n_alpha);
		}
		gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
		gl_FragColor.a = alpha;
		gl_FragColor.rgb += c_add;
	}
}