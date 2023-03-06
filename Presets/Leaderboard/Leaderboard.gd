extends VBoxContainer

var leaderboardEntry = load("res://Presets/Leaderboard/Entry.tscn");

func _ready():
	_clearLeaderboard();
	pass # Replace with function body.

func _loadData(leaderboardName):
	_clearLeaderboard();
	yield(SilentWolf.Scores.get_high_scores(10, leaderboardName), "sw_scores_received")
	var position:int = 1;
	for score in SilentWolf.Scores.scores:
		print(score)
		var entry = leaderboardEntry.instance();
		$ScrollContainer/Entries.add_child(entry);
		
		entry._setName(str(score.player_name))
		entry._setScore(score.score)
		entry._setModifiers(score.metadata.modifiers);
		entry._setPosition(position);
		
		position += 1;
	$CenterContainer.visible = false;

func _clearLeaderboard():
	for entry in $ScrollContainer/Entries.get_children():
		entry.free();
