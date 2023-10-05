import 'package:flutter/material.dart';
import '../Models/globalItems.dart';
import '../Models/item.dart';

class EditItemPage extends StatefulWidget {
  final Item item;
  final Function(Item) onUpdateItem;

  const EditItemPage({Key? key, required this.item, required this.onUpdateItem})
      : super(key: key); // callback expression

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  late Item item;
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    item = widget.item; // Item from widget (initializes)
    itemNameController.text = item.Name;
    itemDescriptionController.text = item.Description;
  }

  // Debug for updating item
  void _updateItemPressed() {
    try {
      Item updatedItem = Item(widget.item.Id, itemNameController.text,
          itemDescriptionController.text);
      widget.onUpdateItem(updatedItem); // Updates the item via callback
      print('Updated item with ID: ${updatedItem.Id}');
    } catch (e) {
      print('Error updating item: $e');
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Edit Item Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: itemNameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: itemDescriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            ElevatedButton(
              onPressed: _updateItemPressed,
              child: Text("Update Item"),
            ),
          ],
        ),
      ),
    );
  }
}
