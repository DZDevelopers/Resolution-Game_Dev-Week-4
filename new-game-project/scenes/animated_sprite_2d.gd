extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_open := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_open_door()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_close_door()

func _open_door() -> void:
	if is_open:
		return
	is_open = true
	animated_sprite.play("open")
	await get_tree().create_timer(0.75).timeout
	animated_sprite.pause()

func _close_door() -> void:
	if not is_open:
		return
	is_open = false
	animated_sprite.play("close")
	await get_tree().create_timer(0.75).timeout
	animated_sprite.pause()
