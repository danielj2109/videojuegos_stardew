extends Control

var tool_enum: int

func setup(new_tool_enum, main_texture: Texture2D):
	tool_enum = new_tool_enum
	$TextureRect.texture = main_texture
	
func highlight(selected: bool):
	var tween = create_tween()
	var target_scale = Vector2(1.25, 1.25) if selected else Vector2.ONE
	tween.tween_property($TextureRect,"scale",target_scale,0.15)
