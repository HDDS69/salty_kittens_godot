extends Node

var player = preload("res://player.tscn")
var playerTmp = player.instantiate()
var death = false
@onready var light = $"../light"
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if SavePoint.light == false :
		light.visible = false
	else :
		light.visible = true
		

func check(body,gide,blee):
	if body.name == 'player':
		gide.visible = blee
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	check(body,$"../education/1",true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	check(body,$"../education/1",false)


func _on__body_exited(body: Node2D) -> void:
	check(body,$"../education/2",false)


func _on__body_entered(body: Node2D) -> void:
	check(body,$"../education/2",true)


func _on_a_3_body_entered(body: Node2D) -> void:
	check(body,$"../education/3",true)


func _on_a_3_body_exited(body: Node2D) -> void:
	check(body,$"../education/3",false)

func _on_а_body_entered(body: Node2D) -> void:
	check(body,$"../education/4",true)

func _on_а_body_exited(body: Node2D) -> void:
	check(body,$"../education/4",false)


func _on_а_5_body_exited(body: Node2D) -> void:
	check(body,$"../education/5",false)


func _on_а_5_body_entered(body: Node2D) -> void:
	check(body,$"../education/5",true)


func _on_а_6_body_exited(body: Node2D) -> void:
	check(body,$"../education/6",false)


func _on_а_6_body_entered(body: Node2D) -> void:
	check(body,$"../education/6",true)


func _on_а_8_body_exited(body: Node2D) -> void:
	check(body,$"../education/8",false)


func _on_а_8_body_entered(body: Node2D) -> void:
	check(body,$"../education/8",true)
