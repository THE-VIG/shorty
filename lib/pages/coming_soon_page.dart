
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
        children: <Widget>[
          Text(
            'Coming Soon',
            style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
          ),
          Text(
            'This page is under construction',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}