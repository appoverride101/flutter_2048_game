// lib/widgets/tile_widget.dart
import 'package:flutter/material.dart';
import '../models/tile.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;

  const TileWidget({Key? key, required this.tile}) : super(key: key);

  Color _getTileColor(int value) {
    switch (value) {
      case 2:
        return Colors.blue[100]!;
      case 4:
        return Colors.blue[200]!;
      case 8:
        return Colors.orange[100]!;
      case 16:
        return Colors.orange[200]!;
      case 32:
        return Colors.red[100]!;
      case 64:
        return Colors.red[200]!;
      case 128:
        return Colors.purple[100]!;
      case 256:
        return Colors.purple[200]!;
      case 512:
        return Colors.green[100]!;
      case 1024:
        return Colors.green[200]!;
      case 2048:
        return Colors.yellow[200]!;
      default:
        return Colors.grey[300]!;
    }
  }

  TextStyle _getTextStyle(int value) {
    return TextStyle(
      fontSize: value < 100 ? 24 : 20,
      fontWeight: FontWeight.bold,
      color: value < 8 ? Colors.black : Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getTileColor(tile.value),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          tile.value == 0 ? '' : '${tile.value}',
          style: _getTextStyle(tile.value),
        ),
      ),
    );
  }
}