
class Item {
  String id;
  String name;
  String description;
  Item({required this.name, required this.id, this.description = ''});
  @override
  String toString() {
    return 'Item[id=$id, name=$name, description=$description]';
  }
}