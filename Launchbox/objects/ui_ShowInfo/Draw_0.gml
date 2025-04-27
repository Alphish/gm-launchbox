draw_set_color(c_black);
draw_set_alpha(0.9);
draw_rectangle(x, y, room_width, room_height, false);

draw_set_color(c_white);
draw_set_alpha(1);
draw_set_font(fnt_Info);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text_ext(
    x + 30,
    y + 30,
    "This is a little showcase of the Launchbox functionality.\n" +
    "\n" +
    "There are several orbs bouncing around, ready to create specific effects upon launches.\n" +
    "You can request the following launch actions:\n" +
    "- all orbs emit a puff of smoke matching their current colour\n" +
    "- a random orb changes to the given colour\n" +
    "- all orbs emit a firework matching their current colour\n" +
    "\n" +
    "Upon launch, all requested actions since the last launch are executed.\n" +
    "Regardless of the requests order, smoke puff requests are always launched before colour change requests, and colour change requests are always processed before the firework request.\n" +
    "That's because of the launch order: puffs launch box is processed first, then the colours launch box, then finally the fireworks launch box.\n" +
    "In practice, it means if the orb change colour in a single launch cycle, its smoke will match the previous colour and its fireworks will match the new colour.\n" +
    "\n" + 
    "You can read more about it in the \"Effects Show\" documentation example.\n" +
    "Click anywhere on the showcase area to hide this explanation.",
    -1,
    room_width - x - 60
    );
