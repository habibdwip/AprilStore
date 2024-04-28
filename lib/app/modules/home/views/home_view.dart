import 'package:april_store/app/modules/home/views/detail_page.dart';
import 'package:april_store/app/modules/home/views/search_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final HomeController state = Get.put(HomeController());
    state.getProduk();

    Future onRefresh() async {
      state.refreshData();
    }

    void onScroll() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;

      if (maxScroll == currentScroll && state.hasMore.value) {
        state.getProduk();
      }
    }

    scrollController.addListener(onScroll);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'April Store',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () => Get.to(() => SearchPage()),
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Obx(() => ListView.builder(
            controller: scrollController,
            itemCount: state.hasMore.value
                ? state.produk.length + 1
                : state.produk.length,
            itemBuilder: (context, index) {
              if (index < state.produk.length) {
                return ListTile(
                  onTap: () {
                    Get.to(() => DetailPage(
                          products: state.produk[index],
                        ));
                  },
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(state.produk[index].thumbnail ?? ''),
                  ),
                  title: Text(state.produk[index].title ?? ''),
                  subtitle: Text(state.produk[index].brand ?? ''),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                );
              }
            })),
      ),
    );
  }
}
