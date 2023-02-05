import 'package:food_list/app/data/models/food_model.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final foodData = Get.arguments as Food;
}
