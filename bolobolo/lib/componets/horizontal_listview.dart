import 'package:flutter/material.dart';
import '../componets/products.dart';
import 'package:bolobolo/componets/rec_products.dart';
import 'package:bolobolo/componets/pop_products.dart';
import 'package:bolobolo/componets/all_products.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      height: 110,
      child: new ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          new Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (context) => RecProducts())),
                    child: Image.asset(
                      'images/recomended.jpg',
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                Text(
                  '    Recommended',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          new Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (context) => PopProducts())),
                    child: Image.asset(
                      'images/popular.jpg',
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                Text(
                  '    Popular',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          new Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (context) => AllProducts())),
                    child: Image.asset(
                      'images/allproduct.jpg',
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                Text(
                  '     All Products',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Categories({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: new InkWell(
        onTap: () {},
        child: Container(
          width: 100,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 80,
              height: 60,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption),
            ),
          ),
        ),
      ),
    );
  }
}
