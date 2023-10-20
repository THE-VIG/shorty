import 'package:fluent_ui/fluent_ui.dart';
import 'package:shorty/database/databse_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/models.dart';

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
                  onTap: () async {
                    if (widget.shorcut == null) createShortcut();

                    final url = Uri.parse(widget.shorcut!.url);
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    } else {
                      showErrorDialog();
                    }
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
                                  ? '${widget.shorcut!.name} at "${widget.shorcut!.url}"'
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

  void showErrorDialog() => showDialog(
        context: context,
        builder: (context) => ContentDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Could not launch ${widget.shorcut!.url}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              const Text('do you wanna delete this shortcut'),
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

  Future<void> deleteShortcut() async {
    await deleteFlyoutController.showFlyout(
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

  Future<void> createShortcut() async {
    await showDialog(
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
