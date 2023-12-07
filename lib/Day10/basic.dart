import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBoot Day10',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(background: Colors.black),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const NetflixSelectProfile(),
    );
  }
}

class NetflixSelectProfile extends StatelessWidget {
  const NetflixSelectProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Boot',
          style: GoogleFonts.lobster(
            textStyle: const TextStyle(
              color: Colors.red,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select a profile to start the Flutter Boot.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 250,
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 6 / 7,
                children: List.generate(4, (index) {
                  return _buildProfile(
                      ['jihyukim', 'hakim', 'jaemjung', 'Add profile'][index],
                      index);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfile(String name, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: index == 3
                ? Border.all(color: Colors.grey)
                : Border.all(style: BorderStyle.none),
            color: index == 0
                ? Colors.blue
                : (index == 1
                    ? Colors.yellow
                    : index == 2
                        ? Colors.red
                        : Colors.black),
          ),
          child: index == 3
              ? const Icon(Icons.add, size: 40)
              : CustomPaint(painter: SmilePainter()),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6)),
        ),
      ],
    );
  }
}

class SmilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.3), 7, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.3), 7, paint);

    final Paint mouthPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    final Path mouthPath = Path()
      ..moveTo(size.width * 0.4, size.height * 0.6)
      ..quadraticBezierTo(
        size.width * 0.6,
        size.height * 0.8,
        size.width * 0.8,
        size.height * 0.6,
      );

    canvas.drawPath(mouthPath, mouthPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
