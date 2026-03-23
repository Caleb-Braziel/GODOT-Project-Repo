extends Panel

@onready var icon: TextureRect = $TextureRect

var submitted := false

func _get_drag_data(_at_position: Vector2) -> Variant:
	if submitted == false:
		if icon.texture == null:
			return
			
		var preview = duplicate()
		var c = Control 	.new()
		c.add_child(preview)
		preview.position -= Vector2(25, 25)
		preview.self_modulate = Color.TRANSPARENT
		c.modulate = Color(c.modulate, 0.5)
		set_drag_preview(c)
		return icon
	else:
		return	

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:	
	var temp = icon.texture
	icon.texture = data.texture
	data.texture = temp
