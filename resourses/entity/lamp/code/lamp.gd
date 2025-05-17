extends Area2D
var salty_platform = preload("res://salty_platform.tscn")
var entered = false
var show = false
var sosica = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var salty_platformTMP = salty_platform.instantiate()
	if entered == true and $"../players/player".actiom == true:
		show = !show
		if show == true and sosica == false :
			#salty_platformTMP.position = Vector2(250,-50)
			#add_child(salty_platformTMP)
			$"salty platform".show()
			$"salty platform/CollisionShape2D".disabled = false
			sosica = true
			print(2)
	if show == false and sosica == true:
			#salty_platformTMP.queue_free()
			$"salty platform/CollisionShape2D".disabled = true
			$"salty platform".hide()
			sosica = false
			print(1)


func _on_body_entered(body):
	if body.name == "player":
		entered = true
		$ui.show()


func _on_body_exited(body):
	if body.name == "player":
		entered = false
		$ui.hide()
