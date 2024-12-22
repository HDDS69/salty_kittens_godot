extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print($"..".player.position)
	var pos = $"..".player.position
	pos.x +=30
	look_at(pos)
