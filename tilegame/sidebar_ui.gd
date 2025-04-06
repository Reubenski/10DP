extends Control


@export var default_res = 10
@export var resources ={'people':default_res ,'bricks':default_res ,'metal':default_res }
@export 
var buildingDetails ={}
var score = 0
var selected






func _ready():
	pass
		


func _ship_destroyed():
	score +=10
	$ScoreLabel.text = 'Score: %s' % score


func _earned(resource_name:Dictionary):
	resources[resource_name]+= 1
	update()


func _buildingplaced(resources_used:Dictionary): 
	
	for item in resources_used.keys():
		resources[item]-=  resources_used[item]
	update()
	#needs resource type and num input as

func update():
	$ResourceList.text = 'People: ' + str(resources['people']) + '\n Bricks:  ' + str(resources['bricks']) + '\nMetal:  ' + str(resources['metal'])
