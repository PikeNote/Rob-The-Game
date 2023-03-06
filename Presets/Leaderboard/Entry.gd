extends VBoxContainer


func _setName(n):
	$NamePlace/Name.text = n;

func _setPosition(p):
	$NamePlace/Position.text = "#" + str(p);

"""
"VowelDecrease":false,
"LetterSpeedup":false,
"TimeDecrease": false
"""
func _setModifiers(m):
	for modifier in m:
		print(modifier)
		$ModifiersScore/Modifiers.get_node(modifier).visible = m[modifier];

func _setScore(s):
	$ModifiersScore/Score.bbcode_text="[right]%s[/right]" % str(s);
