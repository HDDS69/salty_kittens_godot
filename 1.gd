extends RichTextLabel

func check(body,gide,blee):
	if body.name == 'player':
		gide.visible = blee
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	check(body,$".",true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	check(body,$".",false)


func _on__body_exited(body: Node2D) -> void:
	check(body,$"../2",false)


func _on__body_entered(body: Node2D) -> void:
	check(body,$"../2",true)


func _on_a_3_body_entered(body: Node2D) -> void:
	check(body,$"../3",true)


func _on_a_3_body_exited(body: Node2D) -> void:
	check(body,$"../3",false)

func _on_а_body_entered(body: Node2D) -> void:
	check(body,$"../4",true)

func _on_а_body_exited(body: Node2D) -> void:
	check(body,$"../5",false)


func _on_а_5_body_exited(body: Node2D) -> void:
	check(body,$"../5",false)


func _on_а_5_body_entered(body: Node2D) -> void:
	check(body,$"../5",true)


func _on_а_6_body_exited(body: Node2D) -> void:
	check(body,$"../6",false)


func _on_а_6_body_entered(body: Node2D) -> void:
	check(body,$"../6",true)


func _on_а_8_body_exited(body: Node2D) -> void:
	check(body,$"../8",false)


func _on_а_8_body_entered(body: Node2D) -> void:
	check(body,$"../8",true)
