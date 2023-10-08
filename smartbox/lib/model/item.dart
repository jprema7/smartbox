
class Item {

  String id;
  String name;
  String description;

  Item({ required this.id, required this.name, this.description = ''});

  @override
  String toString() {
    return 'Item[id=$id, name=$name, description=$description]';
  }
}