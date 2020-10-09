varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
	vec3 white	= vec3(1.0,1.0,1.0);
	vec3 col	= texture2D( gm_BaseTexture, v_vTexcoord).rgb;
	float alpha	= texture2D( gm_BaseTexture, v_vTexcoord).a;
	
	if (col == white){
		alpha = 0.0;
	}
	
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor.a = alpha;
}