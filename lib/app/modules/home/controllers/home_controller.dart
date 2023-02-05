import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_list/app/data/models/food_model.dart';
import 'package:food_list/app/data/providers/food_provider.dart';
import 'package:food_list/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin {
  final foodData = <Food>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFoodData();
  }

  void getFoodData() async {
    change(null, status: RxStatus.loading());
    await FoodProvider().getListFood().then((value) {
      foodData.assignAll(value);
      change(null, status: RxStatus.success());
    }).catchError((err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }
}

class HomeSearchDelegate extends SearchDelegate {
  final List<Food> food;

  HomeSearchDelegate(this.food);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var data = food.where((element) => element.name!.contains(query)).toList();
    return data.isNotEmpty
        ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  minLeadingWidth: 0,
                  onTap: () =>
                      Get.toNamed(Routes.DETAIL, arguments: data[index]),
                  contentPadding: const EdgeInsets.all(0),
                  leading: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                    child: CachedNetworkImage(
                      imageUrl: data[index].image.toString(),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(data[index].name.toString()),
                ),
              ).paddingSymmetric(horizontal: 10, vertical: 5);
            },
          )
        : const Center(
            child: Text("Tidak ada data makanan!"),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var data = food
        .where((element) => element.name!.toLowerCase().contains(query))
        .toList();
    return data.isNotEmpty
        ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  minLeadingWidth: 0,
                  onTap: () =>
                      Get.toNamed(Routes.DETAIL, arguments: data[index]),
                  contentPadding: const EdgeInsets.all(0),
                  leading: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                    child: CachedNetworkImage(
                      imageUrl: data[index].image.toString(),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(data[index].name.toString()),
                ),
              ).paddingSymmetric(horizontal: 10, vertical: 5);
            },
          )
        : const Center(
            child: Text("Tidak ada data makanan!"),
          );
  }
}
