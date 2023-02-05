import 'dart:async';

import 'package:get/get.dart';

import '../models/food_model.dart';

class FoodProvider extends GetConnect {
  Future<List<Food>> getListFood() async {
    return await get(
            'https://playground-rest-api-vk3y7f3hta-et.a.run.app/foods')
        .then((response) {
      if (response.statusCode == 200) {
        final List foods = response.body;
        return foods.map((food) => Food.fromJson(food)).toList();
      } else {
        throw Exception('Failed to load food');
      }
    });
  }
}
