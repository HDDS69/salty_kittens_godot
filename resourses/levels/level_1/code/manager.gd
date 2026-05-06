extends Node


@onready var level = $".."
@onready var light = $"../light"
@onready var ed3 = $"../education/3"
@onready var ed4 = $"../education/4"
@onready var ed5 = $"../education/5"
#@onready var player =  $"../home/player"
@export var granade : PackedScene
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _ready() -> void:
	#player.spawn_pos = Vector2(-1035,380)
	#if DiscordRPC.get_is_discord_working():
		#DiscordRPC.state = "уровень 1"
		#DiscordRPC.refresh()
	#

func check(body,gide,blee):
	if body.name == 'player':
		gide.visible = blee
		

func _on_a_3_body_entered(body: Node2D) -> void:
	check(body,ed3,true)


func _on_a_3_body_exited(body: Node2D) -> void:
	check(body,ed3,false)

func _on_a_body_entered(body: Node2D) -> void:
	check(body,ed4,true)

func _on_a_body_exited(body: Node2D) -> void:
	check(body,ed4,false)
