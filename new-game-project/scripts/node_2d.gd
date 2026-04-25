extends Node

const coin_node = preload("res://scenes/coin.tscn")

const coins_to_create = [
	Vector2(0, 0),
	Vector2(100, 200),
	Vector2(400, 300),
	Vector2(123, 456),
	Vector2(456, 789),
	Vector2(-100, -200),
	Vector2(350, 800),
	Vector2(30, 800),
	Vector2(-25, 700),
		]
		# add a bunch of places to create coins at
		
var coin_nodes = []

func _ready() -> void:
		for coin in coins_to_create:
			var coin_instance = coin_node.instantiate()
			coin_instance.position = coin
			add_child(coin_instance)
			coin_nodes.append(coin_instance)
		_connect_signals()
			
func _connect_signals():
	for coin in coin_nodes:
			# this refers to the coin nodes we've instantiated
		coin.collected.connect(_coin_collected)
			# connect the "collected" signal to the function below
			# (we haven't created the "collected" signal yet)
			
func _coin_collected(type):
	$Player.increase_score(type)
		# we also haven't created this function in the player's script yet
