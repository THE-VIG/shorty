import 'package:fluent_ui/fluent_ui.dart';
import 'package:shorty/Data/database.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage(
      {super.key, required this.title, required this.collections});

  final String title;
  final List<Collection> collections;

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              widget.title,
              style: FluentTheme.of(context).typography.title,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => CollectionsCard(
              collection: widget.collections[index],
            ),
            childCount: widget.collections.length,
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
        Card(
          borderRadius: BorderRadius.circular(5),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: const SizedBox(
            width: double.maxFinite,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 8,
              children: []
            ),
          ),
        ),
      ],
    );
  }
}

class ShortcutItem extends StatefulWidget {
  const ShortcutItem({
    super.key,
    this.shortcut,
    this.showTitles = true,
  });

  final Shortcut? shortcut;
  final bool showTitles;

  @override
  State<ShortcutItem> createState() => _ShortcutItemState();
}

class _ShortcutItemState extends State<ShortcutItem> {
  bool hovering = false;
  bool clicking = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
                        message: widget.shortcut != null
                            ? '${widget.shortcut!.name} ${widget.shortcut!.url}'
                            : 'Add shortcut',
                        useMousePosition: false,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: ColoredBox(
                            color:Colors.black.withOpacity(.3),
                            child: Center(
                              child: widget.shortcut != null
                                  ? const Icon(FluentIcons.user_window)
                                  : const Icon(FluentIcons.add),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (widget.shortcut != null && widget.showTitles) ...[
                      const SizedBox(height: 8),
                      Text(
                        '',
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
    );
  }
}
