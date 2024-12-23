extends Area2D

var entered = false


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	if entered == true and $"../player".actiom == true:
		$RichTextLabel.text = 'принеси [wave amp=50]пивы[/wave] из бара'
		$AnimationPlayer.play("show")
		$ui.hide()

func _on_body_entered(body):
	if body.name == "player":
		entered = true
		$ui.show()

func _on_body_exited(body):
	if body.name == "player":
		entered = false
		$ui.hide()
		$RichTextLabel.text = ' '
