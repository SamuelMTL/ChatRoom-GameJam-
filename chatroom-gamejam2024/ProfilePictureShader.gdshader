shader_type canvas_item;

uniform float border_width = 0.1;
uniform vec4 border_color: source_color = vec4(1.0);

void fragment() {

	vec2 uv = UV * 2.0 - 1.0;

	float circle = float(length(uv) < 1.0);
	float circle2 = float(length(uv) + border_width < 1.0);
	vec4 tex = texture(TEXTURE, UV) * circle2;
	vec4 border = (circle - circle2) * border_color;
	COLOR = tex + border;

}
