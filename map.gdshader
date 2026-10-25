shader_type canvas_item;


uniform vec2 mouse_position = vec2(100, 100); //mouse position, update every frame from scene tree
uniform float radius = 100; //radius of flashlight
uniform float power = 1.0; //power of flashlight

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex_read = texture(TEXTURE, UV);
	if (distance(mouse_position, FRAGCOORD.xy) <= radius){
		tex_read.a = 1.0 - power;
	}
	else{
		tex_read.a = 1.0;
	}
	
	//turn it black
	tex_read.r = 0.0;
	tex_read.g = 0.0;
	tex_read.b = 0.0;
	
	//draw
	COLOR = tex_read;
	
		
	
	
	
	//if (UV in UV) {
	//	COLOR = vec4(0.0, 0.0, 0.0, 0.0);
	//}
		
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
