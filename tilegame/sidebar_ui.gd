extends Control


@export var default_res = 10
@export var resources ={'people':default_res ,'bricks':default_res ,'metal':default_res }

var score = 0


func _ready():pass


func _ship_destroyed():
	score +=10
	$ScoreLabel.text = 'Score: %s' % score




func update():
	$ScoreLabel.text = 'People: ' + str(resources['people']) + '\n Bricks:  ' + str(resources['bricks']) + '\nMetal:  ' + str(resources['metal'])

func _earned(resource_cost:Dictionary):
	for item in resource_cost.keys():
		resources[item]+= resource_cost[item]
	update()


func _buildingplaced(resource_cost:Dictionary): 
	for item in resource_cost.keys():
		resources[item]-= resource_cost[item]
	update()
    #needs resource type and num input as


