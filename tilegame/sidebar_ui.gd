extends Control


@export var default_res = 10
@export var resources ={'people':default_res ,'bricks':default_res ,'metal':default_res }
@export var countdowntime = 5
var buildingDetails ={}
var score = 0
var selected
var wavenum


func _ready():
	$ItemList.set_item_tooltip(0,'Provides housing for people, costs 1 Brick and 1 People resource.')
	#### Use make_custom_tooltip to use a scene for tooltip
	update()
	$ResourceList.modulate=Color.WHITE

		



func _ship_destroyed():
	Global.score += 10 *get_parent().waveNo
	$ScoreLabel.text = 'Score: %s' % Global.score
	###Add score multiplier dependent on wave number




func earned(resource_earned:Dictionary):
	for item in resource_earned.keys():
		resources[item] = resources[item] + resource_earned[item]
	var tween = create_tween()
	$ResourceList.modulate=Color.GREEN
	tween.tween_property($ResourceList, "modulate", Color.WHITE, 1)
	update()

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("pause"):
		Global.paused = not Global.paused
		if Global.paused:
			$PauseIndicator.text ='PAUSED'
		else:
			$PauseIndicator.text =''
			

func _costcheck(resources_used:Dictionary): 
	
	for item in resources_used.keys():
		if resources[item] - resources_used[item] <=0:
			return null
		resources[item]-=  resources_used[item]
	var tween = create_tween()
	$ResourceList.modulate=Color.RED
	tween.tween_property($ResourceList, "modulate", Color.WHITE, 1)

	update()
	return true
	#needs resource type and num input as

func update():
	$ResourceList.text = 'People: ' + str(resources['people']) + '\n Bricks:  ' + str(resources['bricks']) + '\nMetal:  ' + str(resources['metal'])

func _on_main_next_wave(wavenum):
	get_tree().paused = true
	PhysicsServer2D.set_active(true)
	$StatusText.text ='Wave : '+str(wavenum-1)
	$StatusText/Counter.text = str('Get Ready for the next wave in..')
	$StatusText.self_modulate= Color.LIGHT_GOLDENROD
	$StatusText/Counter.self_modulate=Color.WHITE

	await get_tree().create_timer(0.5).timeout
	for count in range(countdowntime,-1,-1):
		await get_tree().create_timer(1).timeout
		while Global.paused:
			await get_tree().create_timer(0.1).timeout
		$StatusText/Counter.text = str(count)
	var tween = create_tween()
	tween.tween_property($StatusText/Counter, "self_modulate", Color.TRANSPARENT, 1)
	$StatusText.text ='Wave : '+str(wavenum)
	
	#RESTART MAIN
	get_tree().paused = false

	tween.tween_property($StatusText, "self_modulate", Color.TRANSPARENT, 2)
