extends Node

var player = preload("res://player.tscn")
var playerTmp = player.instantiate()
var death = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if SavePoint.light == false :
		$"../light".visible = false
	else :
		$"../light".visible = true
