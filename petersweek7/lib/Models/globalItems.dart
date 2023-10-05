import 'item.dart';


class GlobalItems {
  static final GlobalItems _item = GlobalItems._instance();


  factory GlobalItems() {
    return _item;
  }


  GlobalItems._instance();


  List<Item> items = [];
}
