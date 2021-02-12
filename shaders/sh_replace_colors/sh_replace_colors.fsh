//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 rep1;
uniform vec3 rep2;
uniform vec3 rep3;

uniform vec3 new1;
uniform vec3 new2;
uniform vec3 new3;


void main(){
	//Sample the original pixel
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );

	//Make it easier to compare (out of 255 instead of 1)
	vec3 test = vec3(
	    gl_FragColor.r * 255.0,
	    gl_FragColor.g * 255.0,
	    gl_FragColor.b * 255.0
	);

	//Check if it needs to be replaced
	if (test == rep1) {test = new1;}
	if (test == rep2) {test = new2;}
	if (test == rep3) {test = new3;}

	//return the result in the original format
	gl_FragColor = vec4(
	    test.r / 255.0,
	    test.g / 255.0,
	    test.b / 255.0,
	    gl_FragColor.a
	);
}