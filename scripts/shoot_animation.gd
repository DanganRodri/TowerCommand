extends AnimatedSprite2D


func _ready():
	connect("animation_finished", Callable(self, "_on_AnimatedSprite_animation_finished"))
	
func _on_AnimatedSprite_animation_finished():
	if animation != "default":
		self.play("default")
