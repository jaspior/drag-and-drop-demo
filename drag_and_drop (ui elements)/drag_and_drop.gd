@tool
extends TextureRect

## chave que será usada para confirmar se pode depositar no espaço ou não
@export var key : String = ""
@export var text : String = ""
@export_enum("drag", "container", "locked") var type 

@onready var label : Label = $Name
@onready var texture_used : Texture = texture

signal droped(key_to_use : String)

func _ready() -> void:
	label.text = text

func _get_drag_data(at_position):
	## obtém a textura
	if type == 0:
		var preview_texture = TextureRect.new()
		
		preview_texture.texture = texture
		preview_texture.expand_mode = 1
		preview_texture.size = Vector2(30,30)
		
		var preview = Control.new()
		preview.add_child(preview_texture)
		
		set_drag_preview(preview)
		
		#some com a textura
		#texture = null
		
	
		return [preview_texture.texture, key]
	
func _can_drop_data(_pos, data):
	if data[1] == key and type == 1:
		return data[0] is Texture
	
func _drop_data(_pos,data):
	## recebe a textura e o texto
	texture = data[0]
	#emit_signal("droped",key)
	get_tree().call_group("drag", "on_droped", key)
	self_modulate = 909090
	type = 2
	#text.text = text_new
	##gambiarra para atualizar, tem como deixar elegante
	if get_parent().get_parent().has_method("right_call"):
		get_parent().get_parent().right_call()
	


func on_droped(key_to_use: String) -> void:
	if key == key_to_use and type == 0:
		self_modulate = 909090
		type = 2
