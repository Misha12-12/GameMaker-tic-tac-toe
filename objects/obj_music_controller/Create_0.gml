// Проверяем, существует ли переменная global.bgm_handle
if (!variable_instance_exists(global, "bgm_handle")) {
    // Если не существует — значит, музыка ещё не играла. Запускаем её.
    global.bgm_handle = audio_play_sound(Sound1, 80, true);
} else {
    // Если переменная существует, проверяем, играет ли звук прямо сейчас.
    // Это нужно на случай, если звук вдруг остановился (например, из-за ошибки или stop_sound),
    // но переменная осталась.
    if (!audio_is_playing(global.bgm_handle)) {
        global.bgm_handle = audio_play_sound(Sound1, 80, true);
    }
}
