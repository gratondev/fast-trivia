import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final String id;
  final String name;
  final dynamic icon;
  Category(this.id, this.name, {this.icon});
}

final List<Category> categories = [
  Category("computer", "Computador", icon: FontAwesomeIcons.laptopCode),
  Category("math", "Matemática", icon: FontAwesomeIcons.arrowDown19),
];
