extends Node2D

@onready var default_buttons: Control = $"TextureRect/Default Buttons"
@onready var subject_menu: Panel = $"Subject Menu"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	default_buttons.visible = true
	subject_menu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_subjects_pressed():
	default_buttons.visible = false
	subject_menu.visible = true
	
func _on_settings_pressed():
	get_tree().change_scene_to_file("")
	
func _on_quit_pressed():
	get_tree().quit()	
