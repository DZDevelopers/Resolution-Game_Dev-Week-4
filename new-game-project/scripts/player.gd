extends CharacterBody2D

@export var speed: float = 150.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
const scorescene = preload("res://scenes/player/label.tscn")
var icon1 = preload("res://coin.png")

var scores = [
	{"name": "coins",  "start": 0,  "icon": icon1, "pos": Vector2(-550, -300)}
]

var score_labels: Array[Node] = []

func _ready() -> void:
	for score in scores:
		var score_label = scorescene.instantiate()

		score_label.whatitscounting = score["name"]
		score_label.val = score["start"]
		score_label.text = str(score["start"])
		score_label.get_node("TextureRect").texture = score["icon"]
		score_label.get_node("TextureRect").scale = Vector2(0.005, 0.005)
		score_label.position = score["pos"]

		add_child(score_label)
		score_labels.append(score_label)

func _physics_process(_delta: float) -> void:
	var input := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	if input != Vector2.ZERO:
		input = input.normalized()
		velocity = input * speed
		_play_directional_animation(input)
	else:
		velocity = Vector2.ZERO
		animated_sprite.stop()

	move_and_slide()


func _play_directional_animation(direction: Vector2) -> void:
	var angle := direction.angle()
	var anim := _angle_to_animation(angle)
	if animated_sprite.animation != anim or not animated_sprite.is_playing():
		animated_sprite.play(anim)


func _angle_to_animation(angle: float) -> String:
	# Convert angle to degrees and normalize to 0–360
	var deg := fmod(rad_to_deg(angle) + 360.0, 360.0)

	# Each of 8 directions covers a 45° arc
	# Right = 0°, Down = 90°, Left = 180°, Up = 270°
	if deg < 22.5 or deg >= 337.5:
		return "Right"
	elif deg < 67.5:
		return "DownRight"
	elif deg < 112.5:
		return "Down"
	elif deg < 157.5:
		return "DownLeft"
	elif deg < 202.5:
		return "Left"
	elif deg < 247.5:
		return "UpLeft"
	elif deg < 292.5:
		return "Up"
	else:
		return "UpRight"
func increase_score(label_counting):
	for label in score_labels:
			# goes through every label and checks if it counts the score we want to change
		if label.whatitscounting == label_counting:
			label.val += 1
			label.text = str(label.val)
