extends Timer

var mod = preload("res://loots/salt.tscn")

func _on_timeout():
	var modTmp = mod.instantiate()
	var rmg = RandomNumberGenerator.new()
	var randint = randi_range(50,500)
	modTmp.position = Vector2(randint,400)
	add_child(modTmp)
	
