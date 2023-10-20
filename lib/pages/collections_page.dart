import 'package:fluent_ui/fluent_ui.dart';
import 'package:shorty/database/databse_helper.dart';
import 'package:shorty/models/models.dart';
import 'package:shorty/pages/widgets/shortcut_item.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key, required this.title, required this.type});

  final String title;
  final CollectionType type;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    final nameController = TextEditingController();

    return StreamBuilder<List<Collection>>(
      stream: DatabaseHelper().watchCollections(type),
      builder: (context, snapshot) {
        final collections = snapshot.data;

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
                        title,
                        style: FluentTheme.of(context).typography.title,
                      ),
                    ),
                    Tooltip(
                      message: 'Create a Collection',
                      child: IconButton(
                        icon: const Icon(FluentIcons.add),
                        onPressed: () {
                          createCollection(context, nameController);
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
                  collection: collections![index],
                ),
                childCount: collections?.length ?? 0,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> createCollection(
    BuildContext context,
    TextEditingController nameController,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Create a Shortcut'),
        content: InfoLabel(
          label: 'Collection Name',
          child: TextBox(
            controller: nameController,
            placeholder: 'Name',
          ),
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
              DatabaseHelper().addCollection(
                nameController.text.trim(),
                type,
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
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
    final menuController = FlyoutController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(32, 16, 32, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  collection.name,
                  style: FluentTheme.of(context).typography.bodyLarge,
                ),
              ),
              const SizedBox(width: 16),
              FlyoutTarget(
                controller: menuController,
                child: IconButton(
                  icon: const Icon(FluentIcons.more_vertical),
                  onPressed: () {
                    deleteCollection(menuController);
                  },
                ),
              ),
            ],
          ),
        ),
        StreamBuilder<List<Shortcut>>(
          stream: DatabaseHelper().watchShortcuts(collection.id),
          builder: (context, snapshot) {
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
                          showTitles: showTitles,
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

  Future<void> deleteCollection(FlyoutController menuController) async {
    await menuController.showFlyout(
      dismissOnPointerMoveAway: true,
      placementMode: FlyoutPlacementMode.auto,
      autoModeConfiguration: FlyoutAutoConfiguration(
        preferredMode: FlyoutPlacementMode.bottomRight,
      ),
      builder: (context) => MenuFlyout(
        items: [
          MenuFlyoutItem(
            leading: const Icon(FluentIcons.edit),
            text: const Text('Rename'),
            onPressed: () {
              Flyout.of(context).close();
            },
          ),
          const MenuFlyoutSeparator(),
          MenuFlyoutItem(
            leading: const Icon(FluentIcons.delete),
            text: const Text('Delete'),
            onPressed: () async {
              Flyout.of(context).close();
              await menuController.showFlyout(
                placementMode: FlyoutPlacementMode.auto,
                autoModeConfiguration: FlyoutAutoConfiguration(
                  preferredMode: FlyoutPlacementMode.bottomRight,
                ),
                builder: (context) => FlyoutContent(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${collection.name} will be removed. '
                        'Do you want to continue?',
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Button(
                            onPressed: () {
                              DatabaseHelper().deleteCollection(collection.id);

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
            },
          ),
        ],
      ),
    );
  }
}
