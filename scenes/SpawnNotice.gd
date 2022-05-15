extends PanelContainer

func init(wave: Wave):
	$Label.text = "Spawning %s wave." % [wave.id]
