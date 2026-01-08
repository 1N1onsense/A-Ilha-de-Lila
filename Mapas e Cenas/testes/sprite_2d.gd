extends Sprite2D


@onready var interaction_area: AreaInteracao = $AreaInteracao
@onready var sprite = $Sprite2D
#@onready var speech_sound = 

func _ready():
	interaction_area.interagir = Callable(self, "_on_interact")
	
func _on_interact():
	self.rotate(0.5)
	
