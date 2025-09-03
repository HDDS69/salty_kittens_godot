extends Node2D

var mod = preload("res://salty_platform.tscn") 
var modTmp = mod.instantiate()
var timer_salt_platform = false
# Called when the node enters the scene tree for the first time.
#func _ready():
	#print(timer_salt_platform)
	#if timer_salt_platform == true :
		#timer_salt_platform = false
		#$Timer1.start() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func  _physics_process(delta):
	#if $"../players/player".action == true and $"../players/player".salt > 0 :
		#$"../players/player".salt -= 1
		#modTmp = mod.instantiate()
		#modTmp.position = Vector2(100,450)
		#add_child(modTmp)
		#timer_salt_platform = true
		#_ready()

#func _on_timer_1_timeout():
	#$"../players/player".salty_platform = false
	#timer_salt_platform = false
	#modTmp.queue_free()
	#
