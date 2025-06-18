import 'package:flutter/widgets.dart';

class NoNotes extends StatelessWidget {
  const NoNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Nope.jpg',
            width: MediaQuery.sizeOf(context).width * 0.5e0,
          ),
          const SizedBox(height: 32),
          const Text(
            'You have no notes yet!\nStart creating by pressing the + button below!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Fredoka',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
