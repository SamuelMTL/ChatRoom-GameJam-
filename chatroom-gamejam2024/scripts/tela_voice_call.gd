extends Control

@export_file("res://Dialogue/json/textoVoiceIntro.json") var json_file1: String = "" 
@export_file("res://Dialogue/json/textoVoice1Op1.json") var json_file2: String = ""
@export_file("res://Dialogue/json/textoVoice1Op2.json") var json_file3: String = ""
@export_file("res://Dialogue/json/textoVoice2Op1.json") var json_file4: String = ""
@export_file("res://Dialogue/json/textoVoice2Op2.json") var json_file5: String = ""

var dialogue = []
var current_dialogue_id = -1
var d_active = true
