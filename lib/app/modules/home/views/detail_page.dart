import 'package:april_store/app/model/produk_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.products});
  final Products products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          title: Text(
            products.title!,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            FlutterCarousel(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                disableCenter: true,
                viewportFraction:
                    MediaQuery.of(context).size.width > 800.0 ? 0.8 : 1.0,
                height: MediaQuery.of(context).size.height * 0.45,
                indicatorMargin: 12.0,
                enableInfiniteScroll: true,
                slideIndicator: const CircularSlideIndicator(),
              ),
              items: List.generate(
                products.images!.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    child: Container(
                      child:
                          Center(child: Image.network(products.images![index])),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              products.title!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            Text(products.description!)
          ],
        ));
  }
}
