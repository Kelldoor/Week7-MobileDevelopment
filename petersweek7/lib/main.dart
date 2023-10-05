import 'package:flutter/material.dart';
import 'Models/globalItems.dart';
import 'Models/item.dart';
import 'Views/editItemPage.dart';

// Insert delete button on homepage (here)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peters Week 7',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Peters Week 7'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = [
    Item(1, "Doge", "Dogecoin"),
    Item(2, "Test", "Testcoin"),
    Item(3, "New", "Newcoin"),
    Item(4, "Old", "Oldcoin"),
    Item(5, "Trash", "Trashcoin"),
    Item(6, "Pock", "Pockcoin"),
    Item(7, "Lite", "Litecoin"),
    Item(8, "Dumpster", "Dumpstercoin"),
    Item(9, "Chain", "Chaincoin"),
    Item(10, "Some", "Somecoin"),
  ];

  // New handler for pressing the edit button
  void _handleButtonPress(Item item) async {
    final updatedItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditItemPage(
          item: item,
          onUpdateItem: (updatedItem) {
            // Updates the new item index
            final index =
                items.indexWhere((element) => element.Id == updatedItem.Id);
            if (index != -1) {
              setState(() {
                items[index] = updatedItem; // Updates item
              });
            }
          },
        ),
      ),
    );
    // Debugged for issue on not changing item name/description
    if (updatedItem == true) {
      // Deletes old element
      setState(() {
        items.removeWhere((element) => element.Id == item.Id);
      });
    }
  }

  // Delete item (from main page)
  void _handleDeleteItem(Item item) {
    GlobalItems().items.removeWhere((element) => element.Id == item.Id);

    setState(() {
      items.removeWhere((element) => element.Id == item.Id); //
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        // Able to scroll through item index
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            // Contains items on side so Delete Item can be added
            title: Text("Item ID: ${item.Id}"),
            subtitle: Text(
                "Item Name: ${item.Name}\nItem Description: ${item.Description}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => _handleButtonPress(item),
                  child: Text("Edit Item"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _handleDeleteItem(item),
                  child: Text("Delete Item"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
