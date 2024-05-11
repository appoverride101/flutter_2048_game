// lib/models/tile.dart
class Tile {
  int value;
  bool merged;

  Tile({required this.value, this.merged = false});

  bool get empty => value == 0;

  void updateValue(int newValue) {
    value = newValue;
    merged = true;
  }

  void clearMergeStatus() => merged = false;
}