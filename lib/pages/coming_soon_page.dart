import 'package:fluent_ui/fluent_ui.dart';

class ComingSoonPage extends StatefulWidget {
  const ComingSoonPage({super.key});

  @override
  State<ComingSoonPage> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Coming Soon',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ProgressRing(),
          SizedBox(height: 8),
          Text(
            'This progress ring is not ending',
            style: TextStyle(fontSize: 10),
          ),
          Text(
            'This page is under construction',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
