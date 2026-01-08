extends Area2D
class_name AreaInteracao

@export var action_name: String = "interagir"

var interagir: Callable = func():
	pass

func _on_body_entered(body: Node2D) -> void:
	InteracaoManager.registrar_area(self)


func _on_body_exited(body: Node2D) -> void:
	InteracaoManager.excluir_area(self)
