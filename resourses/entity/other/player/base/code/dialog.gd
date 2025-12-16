extends Node2D
 
@onready var bg = $DialogBackground3
@onready var camera = $Sprite2D
@onready var dialog_text = $RichTextLabel
@onready var anim_text = $RichTextLabel/AnimationPlayer

@export_file('*json') var scene_text_file : String

var scene_text: Dictionary = {}
var selected_text: Array = []
var in_progress: bool = false
var current_dialog_key : String
func _ready() -> void:
	scene_text = load_scene_text()
	Signalbus.connect('display_dialog',Callable(self,'on_display_dialog'))
	
func load_scene_text():
	if FileAccess.file_exists(scene_text_file):
		var file = FileAccess.open(scene_text_file, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()
		
func show_text():
	dialog_text.text = selected_text.pop_front()
	anim_text.play("show")
	await anim_text.animation_finished

func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()
		
func finish():
	dialog_text.text = ""
	self.visible = false
	in_progress = false
	Signalbus.emit_signal('dialog_finish',current_dialog_key)
	
func on_display_dialog(dialog_key):
	current_dialog_key = dialog_key
	if in_progress:
		next_line()
	else:
		self.visible = true
		in_progress = true
		selected_text = scene_text[dialog_key].duplicate()
		show_text()
