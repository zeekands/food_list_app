class Food {
  String? name;
  String? image;
  String? desc;

  Food({this.name, this.image, this.desc});

  Food.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['desc'] = desc;
    return data;
  }
}
