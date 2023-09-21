import 'package:fluent_ui/fluent_ui.dart';
import 'package:shorty/database/databse_helper.dart';
import 'package:shorty/models/models.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key, required this.title});

  final String title;

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  List<Collection> collections = [];
  final controller = ScrollController();

  Future<void> getCollections() async {
    final newCollections = await DatabaseHelper().getCollections();
    setState(() {
      collections = newCollections;
    });
  }

  @override
  void initState() {
    getCollections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: FluentTheme.of(context).typography.title,
                  ),
                ),
                Tooltip(
                  message: 'Add Collection',
                  child: IconButton(
                    icon: const Icon(FluentIcons.add),
                    onPressed: () async {
                      await DatabaseHelper().addCollection('new');
                      getCollections();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => CollectionsCard(
              collection: collections[index],
            ),
            childCount: collections.length,
          ),
        ),
      ],
    );
  }
}

class CollectionsCard extends StatelessWidget {
  const CollectionsCard({
    super.key,
    required this.collection,
    this.showTitles = true,
  });

  final Collection collection;
  final bool showTitles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 32, top: 16),
          child: Text(
            'Collection',
            style: FluentTheme.of(context).typography.bodyLarge,
          ),
        ),
        StreamBuilder<List<Shortcut>>(
          stream: DatabaseHelper().watchShortcuts(collection.id),
          builder: (context, snapshot) {
            print(snapshot.data?.toList());
            return Card(
              borderRadius: BorderRadius.circular(5),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SizedBox(
                width: double.maxFinite,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (snapshot.data?.isNotEmpty ?? false)
                      for (var shortcut in snapshot.data!)
                        ShortcutItem(
                          collection: collection,
                          shorcut: shortcut,
                        ),
                    ShortcutItem(
                      collection: collection,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ShortcutItem extends StatefulWidget {
  const ShortcutItem({
    super.key,
    required this.collection,
    this.shorcut,
    this.showTitles = true,
  });

  final Collection collection;
  final Shortcut? shorcut;
  final bool showTitles;

  @override
  State<ShortcutItem> createState() => _ShortcutItemState();
}

class _ShortcutItemState extends State<ShortcutItem> {
  bool hovering = false;
  bool clicking = false;

  final nameController = TextEditingController();
  final urlController = TextEditingController();
  final deleteFlyoutController = FlyoutController();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'shourcut_${widget.shorcut?.id}_${widget.collection.id}',
      child: FlyoutTarget(
        controller: deleteFlyoutController,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: ColoredBox(
            color: clicking
                ? Colors.black.withOpacity(0.3)
                : hovering
                    ? Colors.black.withOpacity(0.1)
                    : Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: 60,
                child: GestureDetector(
                  onSecondaryTap: () {
                    if (widget.shorcut == null) return;

                    deleteShortcut();
                  },
                  onTap: () {
                    if (widget.shorcut != null) return;

                    createShortcut();
                  },
                  child: Listener(
                    onPointerDown: (event) {
                      setState(() {
                        clicking = true;
                      });
                    },
                    onPointerUp: (event) {
                      setState(() {
                        clicking = false;
                      });
                    },
                    child: MouseRegion(
                      onEnter: (event) {
                        setState(() {
                          hovering = true;
                          clicking = false;
                        });
                      },
                      onExit: (event) {
                        setState(() {
                          hovering = false;
                        });
                      },
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: Tooltip(
                              message: widget.shorcut != null
                                  ? '${widget.shorcut!.name} ${widget.shorcut!.url}'
                                  : 'Add shortcut',
                              useMousePosition: false,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: ColoredBox(
                                  color: Colors.black.withOpacity(0.3),
                                  child: Center(
                                    child: widget.shorcut != null
                                        ? const Icon(FluentIcons.user_window)
                                        : const Icon(FluentIcons.add),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (widget.shorcut != null && widget.showTitles) ...[
                            const SizedBox(height: 8),
                            Text(
                              widget.shorcut!.name,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              style: FluentTheme.of(context)
                                  .typography
                                  .bodyStrong!
                                  .copyWith(fontSize: 12),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> deleteShortcut() {
    return deleteFlyoutController.showFlyout(
      builder: (context) => FlyoutContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.shorcut!.name} will be removed. Do you want to continue?',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.shorcut!.url,
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Button(
                  onPressed: () {
                    DatabaseHelper().deleteShortcut(widget.shorcut!.id);
                    Flyout.of(context).close();
                  },
                  child: const Text('Remove'),
                ),
                const SizedBox(width: 8.0),
                FilledButton(
                  onPressed: Flyout.of(context).close,
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Object?> createShortcut() {
    return showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Create a Shortcut'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InfoLabel(
              label: 'Shortcut Name',
              child: TextBox(
                controller: nameController,
                placeholder: 'Name',
              ),
            ),
            const SizedBox(height: 8),
            InfoLabel(
              label: 'Shortcut Url',
              child: TextBox(
                controller: urlController,
                placeholder: 'Url',
              ),
            ),
          ],
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FilledButton(
            child: const Text('Create'),
            onPressed: () {
              DatabaseHelper().addShortcut(
                nameController.text.trim(),
                urlController.text.trim(),
                widget.collection.id,
                null,
                null,
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
