extends Control

@export_file("res://Dialogue/json/textoChat1Intro.json") var json_file: String = "" 

var dialogue = []
var current_dialogue_id = -1
var d_active = true

@onready var chatboxother_scene = preload("res://Dialogue/ChatBoxOther.tscn")
@onready var chatboxprot_scene = preload("res://Dialogue/ChatBoxProt.tscn")

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
	
	#intancia do chatbox do other character (com ctz tem um nome melhor, mas n pensei em um)
	var chatboxother = chatboxother_scene.instantiate() 
	if not chatboxother:
		print("Falha ao instanciar ChatBox")
		return

	var asset_other = chatboxother.get_node("ChatBox")
	var name_text_other = chatboxother.get_node("Name")
	var text_text_other = chatboxother.get_node("Text")
	if not name_text_other or not text_text_other:
		print("Nós internos de chatbox n foram encontrados")
		return
		
	name_text_other.text = sender
	text_text_other.text = text
	
	#instancia do chatbox do protagonista 
	var chatboxprot = chatboxprot_scene.instantiate() 
	if not chatboxprot:
		print("Falha ao instanciar ChatBoxProt")
		return

	var asset_prot = chatboxprot.get_node("ChatBox")
	var name_text_prot = chatboxprot.get_node("Name")
	var text_text_prot = chatboxprot.get_node("Text")
	if not name_text_prot or not text_text_prot:
		print("Nós internos de chatbox n foram encontrados")
		return
		
	name_text_prot.text = sender
	text_text_prot.text = text
	
	chatboxprot.visible = true
	
	var alignment_container = HBoxContainer.new()
	alignment_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	#ajustanfo a posicao dependendo do sender
	if sender == "Ariel" || sender == "Teodoro" || sender == "Hannah":
		#lado esquerdo
		alignment_container.add_child(chatboxother)
		alignment_container.alignment = BoxContainer.ALIGNMENT_BEGIN
		print("Ariel Adicionado")
	elif sender == "Max":
		#lado direito
		alignment_container.add_child(chatboxprot)
		alignment_container.alignment = BoxContainer.ALIGNMENT_END
		print("Max Adicionado")
	
	$Main/Chat/Chat/ScrollContainer/MarginContainer/VBoxContainer.add_child(alignment_container)
	print("sucesso ao adicionar chatbox:", sender, text)
	
	
	
	
