extends Node

func format_number(n: float) -> String:
	if n < 1000:
		return str(n)

	var units = ["K", "M", "B", "T", "Q", "aa", "ab", "ac", "ad"]
	var unit_index = 0

	while n >= 1000 and unit_index < units.size() - 1:
		n /= 1000.0
		unit_index += 1

	# formata com duas casas decimais, sem remover zeros (1.20K)
	var formatted = "%0.2f" % n

	# remove zeros inúteis (1.20K → 1.2K, 1.00K → 1K)
	formatted = formatted.rstrip("0").rstrip(".")

	return formatted + units[unit_index - 1]
