extends Node

#var player = preload("res://player.tscn")
#var playerTmp = player.instantiate()
@onready var level = $".."
@onready var light = $"../light"
@onready var street = $"../street"
@onready var ed1 = $"../education/1"
@onready var ed2 = $"../education/2"
@onready var ed3 = $"../education/3"
@onready var ed4 = $"../education/4"
@onready var ed5 = $"../education/5"
@onready var stairs1 = $"../TileMapLayer/stairs1"
@onready var stairs2 = $"../TileMapLayer/stairs2"
@onready var gr1 = $gr1
@export var granade : PackedScene
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _ready() -> void:
	#if DiscordRPC.get_is_discord_working():
		#DiscordRPC.state = "уровень 1"
		#DiscordRPC.refresh()
	

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

func _on_a_body_entered(body: Node2D) -> void:
	check(body,ed4,true)

func _on_a_body_exited(body: Node2D) -> void:
	check(body,ed4,false)


func _on_st_1_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		stairs1.collision_enabled = !stairs1.collision_enabled
		if stairs1.collision_enabled == false:
			stairs1.modulate = 'ffffff5b'
		else:
			stairs1.modulate = 'ffffff'


func _on_st_2_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		stairs2.collision_enabled = !stairs2.collision_enabled
		stairs1.collision_enabled = !stairs1.collision_enabled
		if stairs1.collision_enabled == false:
			stairs1.modulate = 'ffffff5b'
		elif stairs1.collision_enabled == true:
			stairs1.modulate = 'ffffff'
		if stairs2.collision_enabled == false:
			stairs2.modulate = 'ffffff5b'
		else:
			stairs2.modulate = 'ffffff'

func _on_gr_1_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		for i in range(3):
			var g = granade.instantiate()
			get_tree().current_scene.call_deferred('add_child',g)
			g.global_position = Vector2(-595,577)
			g.activation = false
		gr1.set_deferred('monitoring',false)


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	light.set_deferred('visible',true)
	street.set_deferred('visible',true)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	light.set_deferred('visible',false)
	street.set_deferred('visible',false)


func _on_а_5_body_entered(body: Node2D) -> void:
	check(body,ed5,true)


func _on_а_5_body_exited(body: Node2D) -> void:
	check(body,ed5,false)
