extends Node

var player = preload("res://player.tscn")
var playerTmp = player.instantiate()
var death = false
@onready var light = $"../light"
@onready var ed1 = $"../education/1"
@onready var ed2 = $"../education/2"
@onready var ed3 = $"../education/3"
@onready var ed4 = $"../education/4"
@onready var ed5 = $"../education/5"
@onready var ed6 = $"../education/6"
@onready var ed8 = $"../education/8"
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if SavePoint.light == false :
		light.visible = false
	else :
		light.visible = true
		

func check(body,gide,blee):
	if body.name == 'player':
		gide.visible = blee
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	check(body,ed1,true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	check(body,ed1,false)


func _on__body_exited(body: Node2D) -> void:
	check(body,ed2,false)


func _on__body_entered(body: Node2D) -> void:
	check(body,ed2,true)


func _on_a_3_body_entered(body: Node2D) -> void:
	check(body,ed3,true)


func _on_a_3_body_exited(body: Node2D) -> void:
	check(body,ed3,false)

func _on_а_body_entered(body: Node2D) -> void:
	check(body,ed4,true)

func _on_а_body_exited(body: Node2D) -> void:
	check(body,ed4,false)


func _on_а_5_body_exited(body: Node2D) -> void:
	check(body,ed5,false)


func _on_а_5_body_entered(body: Node2D) -> void:
	check(body,ed5,true)


func _on_а_6_body_exited(body: Node2D) -> void:
	check(body,ed6,false)


func _on_а_6_body_entered(body: Node2D) -> void:
	check(body,ed6,true)


func _on_а_8_body_exited(body: Node2D) -> void:
	check(body,ed8,false)


func _on_а_8_body_entered(body: Node2D) -> void:
	check(body,ed8,true)
