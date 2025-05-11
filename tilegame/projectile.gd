extends Area2D

signal hit_enemy

@export var speed = 400
@export var homing_acc = 250
@export var homing_speed =0
@export var xspeed = 0
@export var explosion : PackedScene
@export var damaged_saucer : PackedScene
@export var damaged_mothership: PackedScene
@export var penetrating = false
@export var homing = false
@export var lock_on_time=0.9


var lock_on : bool

func _ready():
	hit_enemy.connect(get_node('/root/Main/SidebarUi')._ship_destroyed.bind())
	
	lock_on = false
	var _timer = get_tree().create_timer(lock_on_time)
	_timer.timeout.connect(timeout)
	

func timeout() -> void:
	lock_on=true
	speed = 350
	$GPUParticles2D.emitting=true

func explode():
	var p = explosion.instantiate()
	get_parent().add_child(p)
	p.transform = $ExplosionPoint.global_transform
	
func _process(delta):
	if Global.paused:
		return
	

	if homing and !lock_on:
		speed -= 400*delta
		
		#position.y -= speed * delta - 0.5*370*(delta**2)
	

	position.y -= speed * delta
	if homing and lock_on:
		var aliens = get_tree().get_nodes_in_group("aliens")
		if len(aliens) > 0:
			var distance = (aliens[0].position.x - position.x)/3
			homing_speed = homing_acc*delta*distance
			
			clamp(homing_speed,-200,200)
			if roundf(aliens[0].position.x) != roundf(position.x):

				position.x += homing_speed*delta
				rotation= atan2(homing_speed,speed)
				#clamp speed but make roation
			else:

				#position.x -= homing_speed*delta
				rotation_degrees = 0
				#rotation =-atan2(homing_speed,speed)
	

		
	if position.y < -500:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("aliens"):
		var d: Node
		if area.is_in_group('mothership'):
			d = damaged_mothership.instantiate()
		else:
			d = damaged_saucer.instantiate()
		
		get_parent().call_deferred('add_child',d)
		d.transform = $ExplosionPoint.global_transform
		d.rotation =randf_range(-1.0,1.0)
		call_deferred('explode')
		area.queue_free()
		hit_enemy.emit()
		get_node("/root/Main/viewport").add_trauma(0.2)#screen shake

		if !penetrating:
			queue_free()
