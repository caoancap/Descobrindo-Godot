extends Node

onready var painelInimigos = get_node("Painel/Inimigos")
onready var painelSubMenuItens = get_node("Painel/SubMenuItens")
onready var painelSubMenuMagias = get_node("Painel/SubMenuMagias")


func _ready():
	pass



func _on_Atacar_pressed():
	painelInimigos.show()
	painelSubMenuItens.hide()
	painelSubMenuMagias.hide()



func _on_Defender_pressed():
	painelInimigos.show()
	painelSubMenuItens.hide()
	painelSubMenuMagias.hide()



func _on_Especial_pressed():
	painelInimigos.hide()
	painelSubMenuItens.hide()
	painelSubMenuMagias.show()



func _on_Fugir_pressed():
	var raiz  = get_tree().get_root()
	var mundo = Global.buscaReservado("Mundo")
	
	painelInimigos.show()
	painelSubMenuItens.hide()
	painelSubMenuMagias.hide()
	
	raiz.add_child(mundo)
	raiz.remove_child(self)
	Global.removeReservado("Mundo")
	
	
	self.queue_free()



func _on_Item_pressed():
	painelInimigos.hide()
	painelSubMenuItens.show()
	painelSubMenuMagias.hide()
