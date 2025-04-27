draw_self();

draw_set_color(image_blend);

if (is_hovered) {
    draw_set_color(c_white);
    draw_set_alpha(0.2);
    draw_rectangle(bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1, false);
}

draw_set_alpha(1);
draw_set_color(text_color);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_Info);
draw_text(x + sprite_width div 2, y + sprite_height div 2, text);

draw_set_color(c_white);
