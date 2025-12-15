extends Node2D
 
@onready var bg = $DialogBackground3
@onready var camera = $Sprite2D
@onready var dialog_text = $RichTextLabel

@export_file('*json') var scene_text_file : String

var scene_text: Dictionary = {}
var selected_text: Array = []
var in_progress: bool = false

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

func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()
		
func finish():
	dialog_text.text = ""
	self.visible = false
	in_progress = false
	
func on_display_dialog(dialog_key):
	if in_progress:
		next_line()
	else:
		self.visible = true
		in_progress = true
		selected_text = scene_text[dialog_key].duplicate()
		show_text()
