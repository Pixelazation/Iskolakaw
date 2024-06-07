extends Control

signal back_to_main()

func _on_back_button_pressed():
	back_to_main.emit()
	hide()
