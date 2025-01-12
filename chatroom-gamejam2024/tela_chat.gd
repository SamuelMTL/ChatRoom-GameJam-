extends Control
@export_file("*.json") var json_file1: String = ""
@export_file("*.json") var json_file2: String = ""
@export_file("*.json") var json_file3: String = ""
@export_file("*.json") var json_file4: String = ""

@onready var messages_list_node: VBoxContainer = find_child("MessagesList", true)
@onready var options_list_node: OptionsContainer = find_child("OptionsContainer", true)
@onready var other_message_container = preload("res://components/UI/OtherMessageContainer.tscn")
@onready var my_message_container_component = preload("res://components/UI/MyMessage.tscn")

func _ready():
	options_list_node.option_chosen.connect(self._on_option_chosen)

	_show_json_dialogue(json_file1)
	
	var options: Array[String] = [
		"Perguntar sobre o jogo",
		"Se apresentar",
	]

	_show_options(options)

func _show_options(options: Array[String]):

	options_list_node.options = options
	options_list_node.visible = true

func _show_json_dialogue(json_path: String):
	var json = JSON.new()
	var error = json.parse(FileAccess.get_file_as_string(json_path))
	var data = json.data
	print(json.get_error_message())
		
	_append_dialogue(data)

func _append_dialogue(data: Array[Variant]):
	for message in data:
		var sender: String = message['sender']
		var content: String = message['text']

		if (sender == "Max"):
			var message_node: MyMessage = my_message_container_component.instantiate()
			messages_list_node.add_child(message_node)
			message_node.config(content)
		else:
			var message_node: OtherMessageContainer = other_message_container.instantiate()
			messages_list_node.add_child(message_node)
			message_node.config(PlaceholderTexture2D.new(), [content])


func _on_option_chosen(option: OptionItem):
	var index = option.index
	
	match (index):
		0:
			_show_json_dialogue(json_file2)
		1:
			_show_json_dialogue(json_file3)
			
	_show_json_dialogue(json_file4)


# func _build_my_message(message: Variant) -> BoxContainer:
	
# 	pass

# func _build_other_message(message: String) -> BoxContainer:
# 	pass
