class Category{
  final String? id;
  final String name;
  final String type;


  Category({required this.id, required this.name, required this.type});

  factory Category.fromJson(Map<String,dynamic> json){
    return Category(
      id: json['_id'],
      name: json['name'],
      type: json['type']);
  }

}
