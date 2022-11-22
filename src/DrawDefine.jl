module DrawDefine

using Luxor, Rotations


function create_drawing(;drawing_width, drawing_height, filename, background_color, font_name)

    Drawing(drawing_width, drawing_height, filename)
	background(background_color)
	fontface(font_name) 

end;

function add_border(;line_width, drawing_width, drawing_height, border_size)

	setline(line_width)
	box(Luxor.Point(drawing_width/2, drawing_height/2), drawing_width - 2*border_size, drawing_height - 2*border_size, action = :stroke)

end;

function add_pointer_label(;line_width, font_size, pointer_location, leader_angle, leader_length, label_angle, label_length, label_text, label_width, label_alignment)

    setline(line_width)
	fontsize(font_size)

	leader_end = (RotZ(leader_angle)*[1.0, 0.0, 0.0])[1:2] * leader_length + pointer_location
	label_end = leader_end + (RotZ(label_angle)*[1.0, 0.0, 0.0])[1:2] * label_length 

	Luxor.arrow(Luxor.Point(leader_end[1], leader_end[2]), Luxor.Point(pointer_location[1], pointer_location[2]), arrowheadangle=π/12)
	Luxor.line(Luxor.Point(leader_end[1], leader_end[2]), Luxor.Point(label_end[1], label_end[2]); action=:stroke)

	label_lines = textlines(label_text, label_width)

	textbox(label_lines, Luxor.Point(label_end[1], label_end[2] - font_size);
    leading = font_size,
    alignment=label_alignment)

end;

function add_title_block(;line_width, drawing_width, drawing_height, border_size, title_block_height, title_block_width, company_name_fontsize, project_fontsize, drawing_title_fontsize, company_name, project_name, edge_padding, leading_size, drawing_title, drawing_title_font, drawing_details_fontsize, drawing_details_font, drawn_by, date)

	setline(line_width)
	box(Luxor.Point(drawing_width - border_size - title_block_width/2,drawing_height-border_size-title_block_height/2), title_block_width, title_block_height, action = :stroke)
	
	fontsize(company_name_fontsize)
	title_block_line_1 = Luxor.textbox(company_name, Luxor.Point(drawing_width-border_size- title_block_width + edge_padding,drawing_height-border_size-title_block_height+ company_name_fontsize/2), leading = leading_size[1])

	fontsize(project_fontsize)
	title_block_line_2 = textbox("PROJECT: "* project_name,
    title_block_line_1,
    leading = leading_size[2])

	fontface(drawing_title_font) 
	fontsize(drawing_title_fontsize)
	title_block_line_3 = textbox(drawing_title,
    title_block_line_2,
    leading = leading_size[3])

	fontface(drawing_details_font) 
	fontsize(drawing_details_fontsize)
	title_block_line_4 = textbox("DRAWN BY: "* drawn_by,
    title_block_line_3,
    leading = leading_size[4])

	title_block_line_5 = textbox("DATE: " * date,
    title_block_line_4,
    leading = leading_size[5])

end;

function add_stamp_box(;drawing_width, drawing_height, border_size, title_block_width, title_block_height, stamp_box_width)

	box(Luxor.Point(drawing_width-border_size- title_block_width - stamp_box_width/2,drawing_height-border_size-title_block_height/2), stamp_box_width, title_block_height, action = :stroke)

end;

function add_section_title(;section_name, section_title_location, drawing_scale)

	fontface("Arial Bold") 
	fontsize(14)
	section_title = textbox(section_name,
	section_title_location,
	leading = 6, alignment=:center)
	
	setline(2.0)
	Luxor.line(Luxor.Point(section_title[1] - textextents(section_name)[3] * 0.6, section_title[2]), Luxor.Point(section_title[1] + textextents(section_name)[3] * 0.6, section_title[2]); action=:stroke)
	
	fontface("Arial Regular") 
	fontsize(10)
	section_title = textbox(string("SCALE: ", floor(Int, drawing_scale/12), "\" = 1'-0\"", )  ,
	Luxor.Point(section_title[1], section_title[2] + textextents(section_name)[4] * 1.0),
	leading = 6, alignment=:center)

end;


end # module DrawDefine
