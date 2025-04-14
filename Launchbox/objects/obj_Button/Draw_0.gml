draw_self();

draw_set_color(image_blend);

if (is_hovered) {
    draw_set_alpha(0.2);
    draw_rectangle(x, y, x + sprite_width - 1, y + sprite_height - 1, false);
}

draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x + sprite_width div 2, y + sprite_height div 2, text);

draw_set_color(c_white);
