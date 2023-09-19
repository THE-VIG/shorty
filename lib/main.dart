import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:shorty/pages/coming_soon_page.dart';
import 'package:shorty/pages/home_page.dart';
import 'package:shorty/pages/not_found_page.dart';
import 'package:window_manager/window_manager.dart';

import 'pages/collections_page.dart';

final kIsDesktop = Platform.isWindows || Platform.isMacOS || Platform.isLinux;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsDesktop) {
    await windowManager.ensureInitialized();
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    await windowManager.setMinimumSize(const Size(550, 350));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Shorty',
      theme: FluentThemeData(
        accentColor: Colors.red,
      ),
      darkTheme: FluentThemeData(
        accentColor: Colors.red,
        brightness: Brightness.dark,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NavigationView(
          appBar: NavigationAppBar(
            actions: WindowCaption(
              brightness: FluentTheme.of(context).brightness,
              backgroundColor: Colors.transparent,
            ),
            automaticallyImplyLeading: false,
            title: const DragToMoveArea(
              child: Row(
                children: [
                  FlutterLogo(),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'Shorty',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          pane: NavigationPane(
            displayMode: PaneDisplayMode.compact,
            size: const NavigationPaneSize(
              openMaxWidth: 250,
              openMinWidth: 220,
            ),
            selected: _selectedItem,
            onChanged: (index) => setState(() => _selectedItem = index),
            header: const Text('Menu'),
            items: [
              PaneItem(
                key: const Key('/'),
                icon: const Icon(FluentIcons.home),
                title: const Text('Home'),
                body: const SizedBox(),
              ),
              PaneItem(
                key: const Key('/web_collections'),
                icon: const Icon(FluentIcons.globe),
                title: const Text('Web Collections'),
                body: const SizedBox(),
              ),
              // PaneItem(
              //   key: const Key('/app_collections'),
              //   icon: const Icon(FluentIcons.app_icon_default),
              //   title: const Text('App Collections'),
              //   body: const SizedBox(),
              // ),
              // PaneItem(
              //   key: const Key('/todo'),
              //   icon: const Icon(FluentIcons.checkbox_composite),
              //   title: const Text('To Do'),
              //   body: const SizedBox(),
              // ),
              // PaneItem(
              //   key: const Key('/notes'),
              //   icon: const Icon(FluentIcons.quick_note),
              //   title: const Text('Notes'),
              //   body: const SizedBox(),
              // ),
            ],
            footerItems: [
              PaneItemSeparator(),
              PaneItem(
                key: const Key('/settings'),
                icon: const Icon(FluentIcons.settings),
                title: const Text('Settings'),
                body: const SizedBox.shrink(),
              ),
            ],
          ),
          paneBodyBuilder: (item, body) => PageBuilder(item: item),
        ),
        Positioned(
          child: GestureDetector(
            child: const SizedBox(height: 5),
          ),
        ),
      ],
    );
  }
}

class PageBuilder extends StatelessWidget {
  const PageBuilder({
    super.key,
    this.item,
  });

  final PaneItem? item;

  Widget get page {
    final route = item?.key.toString();
    switch (route?.replaceAll("[<'", '').replaceAll("'>]", '')) {
      case '/':
        return const HomePage();
      case '/web_collections':
        return const CollectionsPage(
          title: 'Web Collections',
        );
      case '/app_collections':
        return const CollectionsPage(
          title: 'App Collections',
        );
      case '/todo':
      case '/notes':
      case '/settings':
        return const ComingSoonPage();
      default:
        return const NotFoundPage();
    }
  }

  @override
  Widget build(BuildContext context) => page;
}
