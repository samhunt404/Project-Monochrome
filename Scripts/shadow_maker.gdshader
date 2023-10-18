shader_type spatial;
render_mode cull_disabled;
uniform sampler2D tex;


void fragment() {
	float value = length(texture(tex,UV).rgb);
	ALPHA_SCISSOR_THRESHOLD = 0.5f;
	ALPHA = 1.0 - value;
}
