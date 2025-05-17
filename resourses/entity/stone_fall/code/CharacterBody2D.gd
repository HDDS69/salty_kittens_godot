extends CharacterBody2D
const SPEED = 400.0
const JUMP_VELOCITY = -600.0
var directionFALL
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	velocity.y += JUMP_VELOCITY
	
	
func _physics_process(delta):
	if not is_on_floor():
		#$CollisionShape2D/Timer.start()
		velocity.y += gravity * delta
	velocity.x = SPEED * directionFALL
	move_and_slide() 


func death():
	$AnimatedSprite2D.play("death")
	await $AnimatedSprite2D.animation_finished
	queue_free()
func _on_area_2d_body_entered(body):
	print(body.name)


func _on_stone_1_body_entered(body):
	print(body.name)
	if body.name != 'TileMapLayer' and body.name != 'player' and body.name != "salty platform":
		body.death()
		death()
	
