
extends Panel

var original = "Pressione o botão"
var agradecimento = "Obrigado por pressionar o botão"

func _on_button_pressed():
	var label = get_node("Label")
	if label.get_text() == original:
		label.set_text(agradecimento)
	else:
		label.set_text(original)

func _ready():
	get_node("Button").connect("pressed",self,"_on_button_pressed")

