extends CanvasLayer

@export_file("res://Dialogue/json/textoIntro.json") var json_file: String = "" 

var dialogue = []
var current_dialogue_id = 0
var d_active = true

func _ready():
	start()

func start():
	dialogue = load_dialogue()
	
func load_dialogue():
	var json_as_text = FileAccess.get_file_as_string(json_file)
	var json_as_dict = JSON.parse_string(json_as_text)
	
	return json_as_dict
		
		
func _input(event):
	if event.is_action_pressed("ui_accept"):
		next_script()
		
func next_script():
	current_dialogue_id += 1
	
	if current_dialogue_id >= len(dialogue):
		d_active = false
		$ChatBox.visible = false
		return
	
	$ChatBox/Name.text = dialogue[current_dialogue_id]['sender']
	$ChatBox/Text.text = dialogue[current_dialogue_id]['text']
	
