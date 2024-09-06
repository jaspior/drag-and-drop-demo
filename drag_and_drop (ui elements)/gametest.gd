extends Control

#inicializando com um número alto para garantir que não dara problema
var total : int = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	total = $Texts.get_child_count()
	print(total)

func right_call():
	total-=1
	if total == 0:
		#aqui fecha o jogo mas dá para fazer outras coisas
		queue_free()
