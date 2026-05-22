extends Sprite2D

func flash(start_duration: float = 0.2, end_duration: float = 0.2):
	var tween = create_tween()
	tween.tween_property(material,'shader_parameter/Parameter', 1.0, start_duration)
	tween.tween_property(material,'shader_parameter/Parameter', 0.0, end_duration)
