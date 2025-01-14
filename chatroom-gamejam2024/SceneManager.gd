extends Node


@onready var animation_player: AnimationPlayer = get_node("Fade/AnimationPlayer")


func change_to_scene_file(file: String):
	animation_player.play("FadeOut")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(file)
	animation_player.play("FadeIn")