shader_type spatial;

uniform sampler2D wave;

void vertex() {
	float height = texture(wave, UV * (TIME / 10.0)).r;
	VERTEX += normalize(VERTEX) * (height / 3.0);
}

void fragment() {
	ALBEDO = vec3(0,0.3,1);
}
