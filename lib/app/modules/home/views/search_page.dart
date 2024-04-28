import 'package:april_store/app/modules/home/controllers/home_controller.dart';
import 'package:april_store/app/modules/home/views/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final HomeController state = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text(
          'Search',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: state.SearchController,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  hintText: "Search",
                  filled: true,
                  fillColor: Colors.blueAccent,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12)),
                ),
                onEditingComplete: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await state.searchProduk();
                  setState(() {});
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.cari.length,
                itemBuilder: (context, index) {
                  if (index < state.cari.length) {
                    return ListTile(
                      onTap: () {
                        Get.to(() => DetailPage(
                              products: state.cari[index],
                            ));
                      },
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(state.cari[index].thumbnail ?? ''),
                      ),
                      title: Text(state.cari[index].title ?? ''),
                      subtitle: Text(state.cari[index].brand ?? ''),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
