extends Control
@export var playerTank : Node
var upgradePos = 0
var upgrades = [
	[
		{
			"name":"Burst Fire",
			"links":1
		},
		{
			"name":"Tank Speed",
			"links":3
		}
	],
	[
		{
			"name":"Multiple Projectiles",
			"links":2
		},
		{
			"name":"Penetrating Missiles",
			"links":2
		}
	],
	[
		{
			"name":"Fully Automatic",
			"links":-1
		},
		{
			"name":"More Projectiles",
			"links":-1
		},
		{
			"name":"Homing Missiles",
			"links":-1
		}
	],
	[
		{
			"name":"Tank Armour",
			"links":4
		},
		{
			"name":"Missile Speed",
			"links":4
		}
	],
	[
		{
			"name":"Multiple Projectiles",
			"links":-1
		},
		{
			"name":"Fast Reload",
			"links":-1
		},
		{
			"name":"Missile Size",
			"links":-1
		}
	]
]

func _ready():
	render_treenode(upgradePos)
	pass

func render_treenode(position: int):
	$ItemList.clear()
	if upgradePos == -1:
		$ItemList.add_item("FULLY UPGRADED!")
		return
	for n in range(len(upgrades[upgradePos])):
		$ItemList.add_item(upgrades[upgradePos][n]["name"])

func _on_item_list_item_selected(index: int) -> void:
	if upgradePos == -1:
		return
	var selectedUpgrade = upgrades[upgradePos][index]
	upgradePos = selectedUpgrade["links"]
	render_treenode(upgradePos)
	match selectedUpgrade["name"]:
		"Burst Fire":
			playerTank.reload_pattern = [0.1,0.1,0.1,1]
		"Tank Speed":
			playerTank.top_speed = playerTank.top_speed + 300
			playerTank.acceleration = playerTank.acceleration + 300
		"Multiple Projectiles":
			playerTank.projectile_count = 3
		"Penetrating Missiles":
			playerTank.penetrating_bullets = true
		"Fully Automatic":
			playerTank.reload_pattern = [0.1]
		"Homing Missiles":
			playerTank.homing_missiles = true
		"Tank Armour":
			playerTank.health = 3
		"Missile Speed":
			playerTank.missile_speed = 800
		"Fast Reload":
			playerTank.reload_pattern = [0.5]
		"Missile Size":
			playerTank.missile_size = 3
