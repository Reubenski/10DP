extends Label

var score = 0

func _ship_destroyed():
    score +=10
    text = 'Score: %s' % score
