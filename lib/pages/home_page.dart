import 'package:fluent_ui/fluent_ui.dart';
import 'package:shorty/database/databse_helper.dart';
import 'package:shorty/models/collection_model.dart';
import 'package:shorty/pages/collections_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //home page that shows most used collections
          const Text(
            'Home Page',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          //web collection
          FutureBuilder(
            future: DatabaseHelper().getCollections(CollectionType.web),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: ProgressRing(),
                );
              }
              return CollectionsCard(
                showTitles: false,
                collection: snapshot.data!.first,
              );
            },
          ),
          //app collection
          FutureBuilder(
            future: DatabaseHelper().getCollections(CollectionType.app),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: ProgressRing(),
                );
              }
              return CollectionsCard(
                showTitles: false,
                collection: snapshot.data!.first,
              );
            },
          ),
        ],
      ),
    );
  }
}
