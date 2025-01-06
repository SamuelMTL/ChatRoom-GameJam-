extends CanvasLayer

@export_file("res://Dialogue/json/textoIntro.json") var json_file: String = "" 

var dialogue = []
var current_dialogue_id = -1
var d_active = true

@onready var chatbox_scene = preload("res://Dialogue/ChatBox.tscn")

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
		return
	
	#dados do dialogo atual
	var current_data = dialogue[current_dialogue_id]
	var sender = current_data['sender']
	var text = current_data['text']
	
	#intancia
	var chatbox = chatbox_scene.instantiate() 
	if not chatbox:
		print("Falha ao instanciar ChatBox")
		return

	var asset = chatbox.get_node("ChatBox")
	var name_text = chatbox.get_node("Name")
	var text_text = chatbox.get_node("Text")
	if not name_text or not text_text:
		print("Nós internos de chatbox n foram encontrados")
		return
		
	name_text.text = sender
	text_text.text = text
	
	#ajustanfo a posicao dependendo do sender
	if sender == "Max":
		chatbox.rect_min_size = Vector2(400, 0) 
		chatbox.rect_position = Vector2(20, 0)
	elif sender == "Ariel":
		chatbox.rect_min_size = Vector2(400, 0)
		chatbox.rect_position = Vector2(620, 0)
	
	$ScrollContainer/VBoxContainer.add_child(chatbox)
	print("sucesso ao adicionar chatbox:", sender, text)
	
	
	
