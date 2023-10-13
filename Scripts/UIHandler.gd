extends Control

@onready var line = $Line2D
@onready var colorPicker = $ColorPicker
var sliders

func _ready():
	sliders = $SliderHolder.get_children()
	
	for s in sliders:
		if(s is Slider):
			s.value_changed.connect(_update_line)
			

func _update_line(_value):
	for s in range(0,sliders.size()):
		line.set_point_position(s,Vector2(line.get_point_position(s).x,175 - (sliders[s].value)))
	var outputColor = get_bytes_to_color()
	line.default_color = outputColor
#	colorPicker.color = outputColor

func get_curve_from_color(c : Color) -> Array:
	var values = Array([])
	var r = c.r8;
	var g = c.g8;
	var b = c.b8;
	var rB = ""
	var gB = ""
	var bB = ""
	for i in range(0,8):
		rB += str(r % 2)
		r/= 2
		gB += str(g % 2)
		g/= 2
		bB += str(b % 2)
		b/= 2
	
	var bits = rB + gB +bB
	
	for i in range(0,8):
		var convertedVal = get_value_from_3_bit(bits.substr(i,3))
		values.append(convertedVal)
		sliders[i].value = convertedVal
	_update_line(0)
	return values

func get_bytes_to_color() -> Color:
	var bytes = ""
	for s in sliders:
		var normalized = int(s.ratio * (s.max_value / s.step))
		bytes += get_3_bit_value(normalized)
	var rB = bytes.substr(0,8)
	var gB = bytes.substr(8,8)
	var bB = bytes.substr(16,8)
	
	var r = 0.0;
	var b = 0.0;
	var g = 0.0;
	
	for i in range(0,8):
		r += float((2^(i+1)) * int(rB.substr(i,1)))
		g += float((2^(i+1)) * int(gB.substr(i,1)))
		b += float((2^(i+1)) * int(bB.substr(i,1)))
	
	#honestly not sure why it needs to be multiplied by 7, by combining bits the way I did it shouldn't have anything to do with 7
	r = r / 255.0 * 7.0
	b = b / 255.0 * 7.0
	g = g / 255.0 * 7.0
	
	return Color(r,g,b)


func get_3_bit_value(value : int) -> String:
	var bits = ""
	for i in range(0,3):
		bits += str(value % 2)
		value /= 2
	#easier to calculate it reversed, then fix it later than just calcluate it correctly
	var invBuffer := bits.to_utf32_buffer().to_int32_array()
	invBuffer.reverse()
	bits = invBuffer.to_byte_array().get_string_from_utf32()
	
	return bits

func get_value_from_3_bit(value : String) -> int:
	var num = 0
	for i in range(0,3):
		num += int(value[i]) * 2^(i+1)
	return num
