extends Area2D
var entered = false
@export var stone : PackedScene
var he = true

@onready var player = $"../player"
@onready var ui = $ui
@onready var anim = $CollisionShape2D/AnimatedSprite2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered == true and player.hit == true and he == true:
			var stone_1 = stone.instantiate()
			stone_1.directionFALL = player.direction
			add_child(stone_1)
			he = false
	if he == false:
		anim.hide()
		ui.hide()
func _on_body_entered(body):
	if body.name == "player":
		entered = true
		ui.show()

func _on_body_exited(body):
	if body.name == "player":
		entered = false
		ui.hide()
