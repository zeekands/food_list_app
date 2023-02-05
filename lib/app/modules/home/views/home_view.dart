import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_list/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //search bar
              children: [
                Image.asset("assets/images/food.jpg").paddingOnly(right: 10.w),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      showSearch(
                          context: context,
                          delegate: HomeSearchDelegate(controller.foodData));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(10),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 18.r,
                              color: Colors.grey[500],
                            ),
                            20.horizontalSpace,
                            Text(
                              "Search",
                              style: TextStyle(fontSize: 12.sp),
                            )
                          ],
                        ).paddingAll(10.r),
                      ),
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
          ),
        ),
      ),
      body: controller
          .obx(
            (state) => GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.h,
                crossAxisCount: 2,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.DETAIL,
                    arguments: controller.foodData[index],
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setWidth(10),
                    ),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1.h,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            ScreenUtil().setWidth(10),
                          ),
                          topRight: Radius.circular(
                            ScreenUtil().setWidth(10),
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: controller.foodData[index].image ?? "",
                          height: 135.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller.foodData[index].name ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ).paddingOnly(top: 10.h, left: 10.w, right: 10.w),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: controller.foodData.length,
            ),
          )
          .paddingSymmetric(horizontal: 20.w, vertical: 10.h),
    );
  }
}
