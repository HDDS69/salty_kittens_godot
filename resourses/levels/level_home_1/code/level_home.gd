extends Node2D
@onready var stairs1 = $TileMapLayer/TileMapLayer/stairs1
@onready var stairs2 = $TileMapLayer/TileMapLayer/stairs2
@onready var gr1 = $trigers/gr1
@onready var ed1 = $"1"
@onready var ed2 = $"2"
@export var granade : PackedScene

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


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		ed1.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == 'player':
		ed1.visible = false


func _on__body_entered(body: Node2D) -> void:
	if body.name == 'player':
		ed2.visible = true


func _on__body_exited(body: Node2D) -> void:
	if body.name == 'player':
		ed2.visible = false


func _on_to_left_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		get_tree().change_scene_to_file("res://resourses/levels/level_left_1/code/level_left.tscn")
