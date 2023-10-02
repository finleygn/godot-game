shader_type spatial;
render_mode cull_disabled;

uniform vec3 color : source_color;
uniform vec3 color_to : source_color;
uniform vec2 bounds;
uniform vec2 wind_direction;
uniform sampler2D noise : repeat_enable;
uniform float noise_scale = 20.0;

varying vec3 worldPos;

void vertex() {
	worldPos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	VERTEX.xz += wind_direction * texture(noise, worldPos.xz / bounds * 0.4 + (TIME * 0.1)).r  * UV.y;
}


void fragment() {
	float noise_pow = texture(noise, worldPos.xz / bounds).r;
	// Place fragment code here.
	ALBEDO = mix(color, color_to, UV.y * noise_pow);
	
	if(!FRONT_FACING) {
		NORMAL = -NORMAL;
	}
}
