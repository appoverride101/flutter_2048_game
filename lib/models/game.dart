
import 'dart:math';
import 'tile.dart';

class Game {
  final int size;
  late List<List<Tile>> board;

  Game({this.size = 4}) {
    reset();
  }

  void reset() {
    board = List.generate(size, (_) => List.generate(size, (_) => Tile(value: 0)));
    _addRandomTile();
    _addRandomTile();
  }

  void _addRandomTile() {
    final emptyTiles = <Tile>[];
    for (final row in board) {
      for (final tile in row) {
        if (tile.empty) emptyTiles.add(tile);
      }
    }
    if (emptyTiles.isEmpty) return;
    final newTile = emptyTiles[Random().nextInt(emptyTiles.length)];
    newTile.updateValue(Random().nextInt(10) == 0 ? 4 : 2);
  }

  bool _merge(Tile a, Tile b) {
    if (a.value == b.value && !a.merged && !b.merged) {
      a.updateValue(a.value * 2);
      b.value = 0;
      return true;
    }
    return false;
  }

  bool _moveTile(Tile from, Tile to) {
    if (to.empty && !from.empty) {
      to.updateValue(from.value);
      from.value = 0;
      return true;
    }
    return false;
  }

  void _clearMergeStatus() {
    for (final row in board) {
      for (final tile in row) {
        tile.clearMergeStatus();
      }
    }
  }

  void slideLeft() {
    bool moved = false;
    for (final row in board) {
      for (int i = 1; i < size; i++) {
        if (row[i].empty) continue;
        for (int j = i; j > 0; j--) {
          if (_moveTile(row[j], row[j - 1]) || _merge(row[j - 1], row[j])) {
            moved = true;
          } else {
            break;
          }
        }
      }
    }
    _clearMergeStatus();
    if (moved) _addRandomTile();
  }

  void slideRight() {
    bool moved = false;
    for (final row in board) {
      for (int i = size - 2; i >= 0; i--) {
        if (row[i].empty) continue;
        for (int j = i; j < size - 1; j++) {
          if (_moveTile(row[j], row[j + 1]) || _merge(row[j + 1], row[j])) {
            moved = true;
          } else {
            break;
          }
        }
      }
    }
    _clearMergeStatus();
    if (moved) _addRandomTile();
  }

  void slideUp() {
    bool moved = false;
    for (int col = 0; col < size; col++) {
      for (int row = 1; row < size; row++) {
        if (board[row][col].empty) continue;
        for (int i = row; i > 0; i--) {
          if (_moveTile(board[i][col], board[i - 1][col]) ||
              _merge(board[i - 1][col], board[i][col])) {
            moved = true;
          } else {
            break;
          }
        }
      }
    }
    _clearMergeStatus();
    if (moved) _addRandomTile();
  }

  void slideDown() {
    bool moved = false;
    for (int col = 0; col < size; col++) {
      for (int row = size - 2; row >= 0; row--) {
        if (board[row][col].empty) continue;
        for (int i = row; i < size - 1; i++) {
          if (_moveTile(board[i][col], board[i + 1][col]) ||
              _merge(board[i + 1][col], board[i][col])) {
            moved = true;
          } else {
            break;
          }
        }
      }
    }
    _clearMergeStatus();
    if (moved) _addRandomTile();
  }

  bool isGameOver() {
    for (final row in board) {
      for (final tile in row) {
        if (tile.empty) return false;
      }
    }
    for (int i = 0; i < size - 1; i++) {
      for (int j = 0; j < size - 1; j++) {
        if (board[i][j].value == board[i + 1][j].value ||
            board[i][j].value == board[i][j + 1].value) {
          return false;
        }
      }
    }
    return true;
  }
}