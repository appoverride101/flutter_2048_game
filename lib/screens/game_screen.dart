import 'package:flutter/material.dart';
import '../models/game.dart';
import '../widgets/tile_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Game game;

  @override
  void initState() {
    super.initState();
    game = Game();
  }

  void _handleSwipe(DismissDirection direction) {
    setState(() {
      switch (direction) {
        case DismissDirection.startToEnd:
          game.slideRight();
          break;
        case DismissDirection.endToStart:
          game.slideLeft();
          break;
        case DismissDirection.up:
          game.slideDown();
          break;
        case DismissDirection.down:
          game.slideUp();
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2048 Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                game.reset();
              });
            },
          )
        ],
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            _handleSwipe(DismissDirection.startToEnd);
          } else if (details.primaryVelocity! < 0) {
            _handleSwipe(DismissDirection.endToStart);
          }
        },
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            _handleSwipe(DismissDirection.down);
          } else if (details.primaryVelocity! < 0) {
            _handleSwipe(DismissDirection.up);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              game.isGameOver() ? 'Game Over' : '',
              style: const TextStyle(fontSize: 32, color: Colors.red),
            ),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: game.size,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                final x = index % game.size;
                final y = index ~/ game.size;
                return TileWidget(tile: game.board[y][x]);
              },
              itemCount: game.size * game.size,
            ),
          ],
        ),
      ),
    );
  }
}
