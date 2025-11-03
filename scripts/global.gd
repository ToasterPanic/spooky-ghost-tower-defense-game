extends Node


var waves = {
	1: [
		{
			"amount": 10,
			"interval": 1,
			"type": "ghost"
		}
	],
	2: [
		{
			"amount": 15,
			"interval": 0.75,
			"type": "ghost"
		}
	],
	3: [
		{
			"amount": 5,
			"interval": 0.75,
			"type": "ghost"
		},
		{
			"amount": 3,
			"interval": 0.75,
			"type": "fast_ghost"
		},
		{
			"amount": 10,
			"interval": 0.75,
			"type": "ghost"
		},
		{
			"amount": 5,
			"interval": 0.75,
			"type": "fast_ghost"
		},
	],
	4: [
		{
			"amount": 5,
			"interval": 0.75,
			"type": "tanky_ghost"
		},
		{
			"amount": 10,
			"interval": 0.75,
			"type": "ghost"
		},
		{
			"amount": 5,
			"interval": 0.75,
			"type": "fast_ghost"
		},
		{
			"amount": 20,
			"interval": 0.333,
			"type": "ghost"
		},
		{
			"amount": 5,
			"interval": 0.75,
			"type": "tanky_ghost"
		},
	],
	5: [
		{
			"amount": 15,
			"interval": 0.75,
			"type": "tanky_ghost"
		},
		{
			"amount": 10,
			"interval": 0.5,
			"type": "fast_ghost"
		},
		{
			"amount": 10,
			"interval": 0.333,
			"type": "ghost"
		},
		{
			"amount": 10,
			"interval": 0.333,
			"type": "tanky_ghost"
		},
		{
			"amount": 10,
			"interval": 0.5,
			"type": "fast_ghost"
		},
	],
	6: [
		{
			"amount": 10,
			"interval": 1,
			"type": "tanky_ghost"
		},
		{
			"amount": 1,
			"interval": 1,
			"type": "tank_ghost"
		},
		{
			"amount": 5,
			"interval": 1,
			"type": "tanky_ghost"
		},
	],
	7: [
		{
			"amount": 14,
			"interval": 0.333,
			"type": "tanky_ghost"
		},
		{
			"amount": 5,
			"interval": 0.5,
			"type": "fast_ghost"
		},
	],
}

var stats = {
	1: {
		1: {
			"range": 4,
			"fire_rate": 0.333,
			"damage": 1,
			"upgrade_cost": 75,
		},
		2: {
			"range": 4.5,
			"fire_rate": 0.2,
			"damage": 1.5,
			"upgrade_cost": 125,
		},
		3: {
			"range": 5.5,
			"fire_rate": 0.1,
			"damage": 3
		}
	},
	2: {
		1: {
			"range": 1.25,
			"fire_rate": 0.333,
			"damage": 2.5,
			"upgrade_cost": 75,
		},
		2: {
			"range": 1.25,
			"fire_rate": 0.25,
			"damage": 4,
			"upgrade_cost": 125,
		},
		3: {
			"range": 1.25,
			"fire_rate": 0.2,
			"damage": 12
		}
	},
	3: {
		1: {
			"range": 4,
			"fire_rate": 0.75,
			"damage": 8,
			"explosive": true,
			"upgrade_cost": 75,
		},
		2: {
			"range": 5,
			"fire_rate": 0.666,
			"damage": 12,
			"explosive": true,
			"upgrade_cost": 125,
		},
		3: {
			"range": 6,
			"fire_rate": 0.456,
			"damage": 18,
			"explosive": true
		}
	},
	4: {
		1: {
			"range": 7,
			"fire_rate": 1,
			"damage": 7,
			"upgrade_cost": 75,
		},
		2: {
			"range": 8,
			"fire_rate": 0.75,
			"damage": 14,
			"upgrade_cost": 125,
		},
		3: {
			"range": 9,
			"fire_rate": 0.5,
			"damage": 21
		}
	}
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
