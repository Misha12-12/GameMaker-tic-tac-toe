// Если игра уже закончена, ничего не делаем
if (game_state != 0) exit;

// --- ХОД ИГРОКА ---
if (current_turn == 1 && mouse_check_button_pressed(mb_left)) {
    var clicked = false;
    
    with (obj_cell) {
        if (point_in_rectangle(mouse_x, mouse_y, x, y, x + sprite_width, y + sprite_height)) {
            if (!is_occupied) {
                is_occupied = true;
                symbol = "X";
                clicked = true;
                break; // Выходим только из цикла with, это ОК
            }
        }
    }
    
    if (clicked) {
        current_turn = 2; // Передаем ход боту
        
        // --- ПРОВЕРКА ПОБЕДЫ ИГРОКА ---
        var board = array_create(9, "");
        with (obj_cell) {
            var col = floor(x / 96);
            var row = floor(y / 96);
            var idx = row * 3 + col;
            if (idx >= 0 && idx <= 8) board[idx] = symbol;
        }
        
        var win = false;
        if (board[0]!="" && board[0]==board[1] && board[1]==board[2]) win = true;
        else if (board[3]!="" && board[3]==board[4] && board[4]==board[5]) win = true;
        else if (board[6]!="" && board[6]==board[7] && board[7]==board[8]) win = true;
        else if (board[0]!="" && board[0]==board[3] && board[3]==board[6]) win = true;
        else if (board[1]!="" && board[1]==board[4] && board[4]==board[7]) win = true;
        else if (board[2]!="" && board[2]==board[5] && board[5]==board[8]) win = true;
        else if (board[0]!="" && board[0]==board[4] && board[4]==board[8]) win = true;
        else if (board[2]!="" && board[2]==board[4] && board[4]==board[6]) win = true;

        if (win) { 
            show_message("🎉 ПОБЕДА ИГРОКА! 🎉");
            game_state = 1;
			room_goto(rm_menu);
        } else {
            // --- ПРОВЕРКА НА НИЧЬЮ ---
            var empty_count = 0;
            with (obj_cell) if (!is_occupied) empty_count++;
            
            if (empty_count == 0) { 
                show_message("🤝 НИЧЬЯ!");
                game_state = 3;
				room_goto(rm_menu);
            } else {
                // ==========================================
                // 🔥 УМНЫЙ ХОД БОТА (ИСПРАВЛЕННЫЙ) 🔥
                // ==========================================
                
                var free_cells = [];
                with (obj_cell) { 
                    if (!is_occupied) array_push(free_cells, id); 
                }
                
                if (array_length(free_cells) > 0) {
                    // Создаем карту поля: 0=пусто, 1=X, 2=O
                    var field = array_create(9, 0);
                    with (obj_cell) {
                        var col = floor(x / 96);
                        var row = floor(y / 96);
                        var idx = row * 3 + col;
                        if (idx >= 0 && idx <= 8) {
                            if (symbol == "X") field[idx] = 1;
                            else if (symbol == "O") field[idx] = 2;
                        }
                    }

                    var lines = [
                        [0,1,2], [3,4,5], [6,7,8], 
                        [0,3,6], [1,4,7], [2,5,8], 
                        [0,4,8], [2,4,6]           
                    ];
                    
                    var move_index = -1; 

                    // 1. Пытаемся выиграть
                    for (var i = 0; i < array_length(lines); i++) {
                        var l = lines[i];
                        if (field[l[0]] == 2 && field[l[1]] == 2 && field[l[2]] == 0) move_index = l[2];
                        else if (field[l[0]] == 2 && field[l[2]] == 2 && field[l[1]] == 0) move_index = l[1];
                        else if (field[l[1]] == 2 && field[l[2]] == 2 && field[l[0]] == 0) move_index = l[0];
                        if (move_index != -1) break;
                    }

                    // 2. Блокируем игрока
                    if (move_index == -1) {
                        for (var i = 0; i < array_length(lines); i++) {
                            var l = lines[i];
                            if (field[l[0]] == 1 && field[l[1]] == 1 && field[l[2]] == 0) move_index = l[2];
                            else if (field[l[0]] == 1 && field[l[2]] == 1 && field[l[1]] == 0) move_index = l[1];
                            else if (field[l[1]] == 1 && field[l[2]] == 1 && field[l[0]] == 0) move_index = l[0];
                            if (move_index != -1) break;
                        }
                    }

                    // 3. Центр
                    if (move_index == -1 && field[4] == 0) move_index = 4;

                    // 4. Углы
                    if (move_index == -1) {
                        var corners = [0, 2, 6, 8];
                        for (var c = 0; c < array_length(corners); c++) {
                            if (field[corners[c]] == 0) {
                                move_index = corners[c];
                                break;
                            }
                        }
                    }

                    // 5. Случайный ход
                    if (move_index == -1) {
                        var r = irandom(array_length(free_cells) - 1);
                        with (free_cells[r]) {
                            is_occupied = true;
                            symbol = "O";
                        }
                    } else {
                        // ВАЖНО: Здесь была ошибка! Убрали exit, поставили break
                        with (obj_cell) {
                            var col = floor(x / 96);
                            var row = floor(y / 96);
                            var current_idx = row * 3 + col;
                            
                            if (current_idx == move_index && !is_occupied) {
                                is_occupied = true;
                                symbol = "O";
                                break; // <-- ЭТО ВАЖНО! break выходит из with, а не останавливает всю игру
                            }
                        }
                    }
                }

                current_turn = 1; // ВОТ ЗДЕСЬ ход возвращается ТЕБЕ!
                
                // --- ПРОВЕРКА ПОБЕДЫ БОТА ---
                var board_bot = array_create(9, "");
                with (obj_cell) {
                    var col_b = floor(x / 96);
                    var row_b = floor(y / 96);
                    var idx_b = row_b * 3 + col_b;
                    if (idx_b >= 0 && idx_b <= 8) board_bot[idx_b] = symbol;
                }
                
                var win_bot = false;
                if (board_bot[0]!="" && board_bot[0]==board_bot[1] && board_bot[1]==board_bot[2]) win_bot = true;
                else if (board_bot[3]!="" && board_bot[3]==board_bot[4] && board_bot[4]==board_bot[5]) win_bot = true;
                else if (board_bot[6]!="" && board_bot[6]==board_bot[7] && board_bot[7]==board_bot[8]) win_bot = true;
                else if (board_bot[0]!="" && board_bot[0]==board_bot[3] && board_bot[3]==board_bot[6]) win_bot = true;
                else if (board_bot[1]!="" && board_bot[1]==board_bot[4] && board_bot[4]==board_bot[7]) win_bot = true;
                else if (board_bot[2]!="" && board_bot[2]==board_bot[5] && board_bot[5]==board_bot[8]) win_bot = true;
                else if (board_bot[0]!="" && board_bot[0]==board_bot[4] && board_bot[4]==board_bot[8]) win_bot = true;
                else if (board_bot[2]!="" && board_bot[2]==board_bot[4] && board_bot[4]==board_bot[6]) win_bot = true;
                
                if (win_bot) {
                    show_message("🤖 БОТ ПОБЕДИЛ!");
                    game_state = 2;
					room_goto(rm_menu);
                } else {
                    var empty_after = 0;
                    with (obj_cell) if (!is_occupied) empty_after++;
                    if (empty_after == 0) { 
                        show_message("🤝 НИЧЬЯ ПОСЛЕ ХОДА БОТА!");
                        room_goto(rm_menu);
						game_state = 3; 
                    }
                }
            }
        }
    }
}
