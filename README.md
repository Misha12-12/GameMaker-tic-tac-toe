# GameMaker Tic-Tac-Toe 🎮

A finished prototype of the Tic-Tac-Toe game in GameMaker Studio 2. The project demonstrates basic game logic, working with rooms, objects, and events.

## 🧠 What's implemented

- **Win and Draw Logic**: checking rows, columns, and diagonals after each move.
- **Player Switching**: automatically switching between "X" and "O".
- **Occupied Cell Locking**: you can't place a symbol in an already occupied cell.
- **Game Reset**: a button to restart the game without resetting the room.

## 🛠 Technologies and Stack

- GameMaker Studio 2 (GMS2)
- GML (GameMaker Language)
- Object-oriented structure (separate objects for the board, cells, and interface)

## 📂 Project Structure

- `obj_board` — board state management and victory condition checking.
- `obj_cell` — individual cell logic (clicks, drawing, blocking).
- `room_game` — game room with object placement.
- `scr_game_logic` — auxiliary scripts (combo checking, etc.).

## 🚀 How to Run

1. Open the project in GameMaker Studio 2.
2. Select `room_game`.
3. Click Play.

# GameMaker Tic‑Tac‑Toe 🎮

Готовый прототип игры «Крестики‑нолики» на GameMaker Studio 2. Проект демонстрирует базовую игровую логику, работу с комнатами (Rooms), объектами и событиями.

## 🧠 Что реализовано

- **Логика победы и ничьей**: проверка строк, столбцов и диагоналей после каждого хода.
- **Переключение игроков**: автоматический переход хода между «X» и «O».
- **Блокировка занятых клеток**: нельзя поставить символ в уже заполненную ячейку.
- **Сброс игры**: кнопка для перезапуска без перезагрузки комнаты.

## 🛠 Технологии и стек

- GameMaker Studio 2 (GMS2)
- Язык GML (GameMaker Language)
- Объектно‑ориентированная структура (отдельные объекты для поля, клеток, интерфейса)

## 📂 Структура проекта

- `obj_board` — управление состоянием доски и проверка условий победы.
- `obj_cell` — логика отдельной клетки (клик, отрисовка, блокировка).
- `room_game` — игровая комната с размещением объектов.
- `scr_game_logic` — вспомогательные скрипты (проверка комбинаций и т. п.).

## 🚀 Как запустить

1. Открой проект в GameMaker Studio 2.
2. Выбери комнату `room_game`.
3. Нажми Play.
