extends Node

var player = preload("res://player.tscn")
var playerTmp = player.instantiate()
var death = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if death == true:
		playerTmp.position = Vector2(1,400)
		add_child(playerTmp)
		death = false
	if SavePoint.light == false :
		$"../light".visible = false
	else :
		$"../light".visible = true


func _on_area_2d_3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventAction:
		print(1) #тут не работает
		if event.action == "ui_action_button" and event.pressed:
			$"../Area2D3/Label".visible = true
	if event is InputEventAction:
		if event.is_action_pressed("ui_action_button"):
			print(11)
