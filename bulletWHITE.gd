extends Area2D

var SPEED = 25
var whitelist = [
	'mob',
	'mob2',
	'mob3',
	'mob4',
	'mob5',
	'mob6',
	'TileMap',
	'salty platform',
]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += SPEED * transform.x


func _on_body_entered(body):
	#if body.name not in whitelist:	
	#queue_free()
	if body.name == 'player':
		body.health -=1
	if body.name == 'TileMapLayer':
		queue_free()
