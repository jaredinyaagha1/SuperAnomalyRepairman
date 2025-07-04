shader_type canvas_item;


uniform sampler2D palette;

//const vec3 dark = vec3(0.36862,0.36862,0.36862);
//uniform vec3 color1 : source_color;
//uniform vec3 color2 : source_color;
//uniform vec3 color3 : source_color;
//uniform vec3 color4 : source_color;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(palette,1.0-texture(TEXTURE,UV).rg);

	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
