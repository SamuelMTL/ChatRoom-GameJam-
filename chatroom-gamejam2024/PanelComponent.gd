@tool
extends Panel
@onready
var style_box: StyleBoxFlat = _get_style_box()

@export_category("Border Radius")
var _corner_radius: Vector4 = Vector4()
var _border_radius: Vector4 = Vector4()

func _ready() -> void:
	pass
	
func _get_style_box():
	var original_style_box = self.get_theme_stylebox("panel").duplicate()
	self.add_theme_stylebox_override("panel", original_style_box)
	return original_style_box
	
func _process(delta: float) -> void:
	pass
