extends RigidBody2D

func _ready() -> void:
    var spriteindex: int = randi_range(0,2)
    $AnimatedSprite2D.set_frame(spriteindex)
    #use a radom range to better generate randomness
    linear_velocity.y = - 150.0 - (spriteindex*100 )
    linear_velocity.x = 70.0 * (spriteindex*2 -1)

    angular_velocity = randf_range(-15.0,15.0)