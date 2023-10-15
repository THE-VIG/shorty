import 'package:fluent_ui/fluent_ui.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '404',
            style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
          ),
          Text(
            'Page not found',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
