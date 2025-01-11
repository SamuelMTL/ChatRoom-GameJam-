@tool
class_name OptionsContainer extends ScrollContainer


@onready var option_component = preload("res://components/UI/OptionItem.tscn")
@onready var options_list_node = find_child("OptionsList")

@export
var options: Array[String] = []:
	set(val):
		options = val
		print(options_list_node)
		if (options_list_node != null):
			_render_options(val)

func _render_options(options: Array[String]):
	var children = options_list_node.get_children()

	for node in children:
		node.queue_free()

	for option in options:
		var option_node: OptionItem = option_component.instantiate()
		options_list_node.add_child(option_node)
		option_node.content = option
