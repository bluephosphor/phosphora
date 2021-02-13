//
// color replacement fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float range;
uniform vec4  color_match_1;
uniform vec4  color_match_2;
uniform vec4  color_match_3;
uniform vec4  color_replace_1;
uniform vec4  color_replace_2;
uniform vec4  color_replace_3;

void main(){
	vec4  pixel_color = v_vColour * texture2D(gm_BaseTexture,v_vTexcoord);
	float new_range = range / 255.0;
	
	if (abs(pixel_color.r - color_match_1.r) <= new_range) {
		if (abs(pixel_color.g - color_match_1.g) <= new_range) {
			if (abs(pixel_color.b - color_match_1.b) <= new_range) {
				pixel_color.rgb = color_replace_1.rgb;
			}
		}
	}
	
	if (abs(pixel_color.r - color_match_2.r) <= new_range) {
		if (abs(pixel_color.g - color_match_2.g) <= new_range) {
			if (abs(pixel_color.b - color_match_2.b) <= new_range) {
				pixel_color.rgb = color_replace_2.rgb;
			}
		}
	}
	
	if (abs(pixel_color.r - color_match_3.r) <= new_range) {
		if (abs(pixel_color.g - color_match_3.g) <= new_range) {
			if (abs(pixel_color.b - color_match_3.b) <= new_range) {
				pixel_color.rgb = color_replace_3.rgb;
			}
		}
	}
	
	gl_FragColor = pixel_color;

}