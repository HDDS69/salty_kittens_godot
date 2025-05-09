extends Area2D

var entered = false
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	if entered == true :
		if Input.is_action_just_pressed("ui_action_button"):
			$RichTextLabel.text = 'братишка , можешь донести меня до бара ? очень уж хочется [wave] пива				                           '
			$ui.hide()
			$AnimationPlayer.play("show")
			await $AnimationPlayer.animation_finished
			$RichTextLabel.text = 'нажмите [wave]E[/wave] что бы взять телевизор'
			while not Input.is_action_just_pressed("ui_action_button"):
				await get_tree().process_frame  # Ждем следующий кадр
				if $"../player".broke :
					break
			$"../player".animTV()
			$AnimatedSprite2D.play("puf")
			await $AnimatedSprite2D.animation_finished
			queue_free()

func _on_body_entered(body):
	if body.name == "player":
		entered = true
		$ui.show()

func _on_body_exited(body):
	if body.name == "player":
		entered = false
		$ui.hide()
		$RichTextLabel.text = ' '
