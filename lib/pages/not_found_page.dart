import 'package:fluent_ui/fluent_ui.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              '404',
              style: FluentTheme.of(context).typography.display!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Page not found',
              style: FluentTheme.of(context).typography.title!,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Button(
              child: const Text('Go Back'),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacementNamed('/');
                }
              },
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
