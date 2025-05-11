extends Area2D

var entered = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var anim = $AnimationPlayer
@onready var player = $"../player"
@onready var ui = $ui
@onready var Rtext = $RichTextLabel
func _physics_process(delta: float) -> void:
	if entered == true :
		if Input.is_action_just_pressed("ui_action_button"):
			Rtext.text = 'братишка , можешь донести меня до бара ? очень уж хочется [wave] пива				                           '
			ui.hide()
			anim.play("show")
			await anim.animation_finished
			Rtext.text = 'нажмите [wave]E[/wave] что бы взять телевизор'
			while not Input.is_action_just_pressed("ui_action_button"):
				await get_tree().process_frame  # Ждем следующий кадр
				if player.broke :
					break
			player.animTV()
			anim.play("puf")
			await anim.animation_finished
			queue_free()

func _on_body_entered(body):
	if body.name == "player":
		entered = true
		ui.show()

func _on_body_exited(body):
	if body.name == "player":
		entered = false
		ui.hide()
		Rtext.text = ' '
