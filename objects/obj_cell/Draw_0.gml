draw_self(); // Рисуем фон клетки

if (is_occupied) {
    draw_set_color(c_black); // Черный цвет символа
    
    // Вычисляем центр клетки
    var cx = x + (sprite_width / 2);
    var cy = y + (sprite_height / 2);
    
    draw_set_halign(fa_center); // Центрируем текст по горизонтали
    draw_set_valign(fa_middle); // Центрируем текст по вертикали
    
    draw_text(cx, cy, symbol);
}
