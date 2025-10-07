extends Node2D

func _ready() -> void:
	DiscordRPC.state = "уровень 2"
	DiscordRPC.refresh()
