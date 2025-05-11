extends Control
@export var playerTank : Node
var upgradePos = 0
var upgrades = [
	[
		{
			"name":"Burst Fire",
			"links":1,
			"cost": 3
		},
		{
			"name":"Tank Speed",
			"links":3,
			"cost": 3
		}
	],
	[
		{
			"name":"Multiple Projectiles",
			"links":2,
			"cost": 4
		},
		{
			"name":"Penetrating Missiles",
			"links":2,
			"cost": 4
		}
	],
	[
		{
			"name":"Fully Automatic",
			"links":-1,
			"cost": 5
		},
		{
			"name":"More Projectiles",
			"links":-1,
			"cost": 5
		},
		{
			"name":"Homing Missiles",
			"links":-1,
			"cost": 5
		}
	],
	[
		{
			"name":"Tank Armour",
			"links":4,
			"cost": 4
		},
		{
			"name":"Missile Speed",
			"links":4,
			"cost": 4
		}
	],
	[
		{
			"name":"Multiple Projectiles",
			"links":-1,
			"cost": 5
		},
		{
			"name":"Fast Reload",
			"links":-1,
			"cost": 5
		},
		{
			"name":"Missile Size",
			"links":-1,
			"cost": 5
		}
	]
]

func _ready():
	render_treenode()
	pass

func render_treenode():
	$ItemList.clear()
	if upgradePos == -1:
		$ItemList.add_item("FULLY UPGRADED!")
		return
	for n in range(len(upgrades[upgradePos])):
		$ItemList.add_item(upgrades[upgradePos][n]["name"]+"\nCost: "+str(upgrades[upgradePos][n]["cost"]))

func _on_item_list_item_selected(index: int) -> void:
	if upgradePos == -1:
		return
	var selectedUpgrade = upgrades[upgradePos][index]

	if !(get_node('../SidebarUi')._costcheck({'metal':selectedUpgrade["cost"]})):
		print('Too poor for upgrade')
		$ItemList.deselect_all()
		return

	
	upgradePos = selectedUpgrade["links"]
	render_treenode()
	match selectedUpgrade["name"]:
		"Burst Fire":
			playerTank.reload_pattern = [0.1,0.1,0.1,1]
		"Tank Speed":
			playerTank.top_speed = playerTank.top_speed*2
			playerTank.acceleration = playerTank.acceleration *1.5
			playerTank.immediate_speed = playerTank.immediate_speed*2
			playerTank.speed_slowdown = playerTank.speed_slowdown**2
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
