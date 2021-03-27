import 'package:flutter/material.dart';
import 'package:bolobolo/pages/product_details.dart';
import 'package:bolobolo/home.dart';

class AllProducts extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<AllProducts> {
  var product_list = [
    {
      "name": "Masker",
      "picture": "images/masker.jpg",
      "old_price": "IDR 3,9k",
      "price": "IDR 3,9k",
    },
    {
      "name": "Jeans",
      "picture": "images/jeans.jpg",
      "old_price": "IDR 88k",
      "price": "IDR 88k",
    },
    {
      "name": "Momogi",
      "picture": "images/momogi.jpg",
      "old_price": "IDR 20k",
      "price": "IDR 20k",
    },
    {
      "name": "Samsung",
      "picture": "images/samsung.jpg",
      "old_price": "IDR 2500k",
      "price": "IDR 2500k",
    },
    {
      "name": "Sunsilk",
      "picture": "images/sunsilk.jpg",
      "old_price": "IDR 20k",
      "price": "IDR 20k",
    },
    {
      "name": "Kotak Bekal",
      "picture": "images/kotak.jpg",
      "old_price": "IDR 10k",
      "price": "IDR 10k",
    },
    {
      "name": "Spidol",
      "picture": "images/spidol.jpg",
      "old_price": "IDR 8k",
      "price": "IDR 8k",
    },
    {
      "name": "Pensil",
      "picture": "images/pensil.jpg",
      "old_price": "IDR 1k",
      "price": "IDR 1k",
    },
    {
      "name": "Airpods",
      "picture": "images/airpods.jpg",
      "old_price": "IDR 750k",
      "price": "IDR 750k",
    },
    {
      "name": "Baju Polos Putih",
      "picture": "images/bajupolos.jpg",
      "old_price": "IDR 8k",
      "price": "IDR 8k",
    },
    {
      "name": "Beat",
      "picture": "images/beat.jpg",
      "old_price": "IDR 12000k",
      "price": "IDR 12000k",
    },
    {
      "name": "Beras",
      "picture": "images/beras.jpg",
      "old_price": "IDR 19k",
      "price": "IDR 19k",
    },
    {
      "name": "KETI SHOW",
      "picture": "images/keti.jpg",
      "old_price": "IDR 1000k",
      "price": "IDR 1000k",
    },
    {
      "name": "Kue",
      "picture": "images/kue.jpg",
      "old_price": "IDR 150k",
      "price": "IDR 150k",
    },
    {
      "name": "Maechee",
      "picture": "images/maichi.jpg",
      "old_price": "IDR 6k",
      "price": "IDR 6k",
    },
    {
      "name": "Sari Roti",
      "picture": "images/sariroti.jpg",
      "old_price": "IDR 13k",
      "price": "IDR 13k",
    },
    {
      "name": "Mainan",
      "picture": "images/toys.jpg",
      "old_price": "IDR 35,5k",
      "price": "IDR 35,5k",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "All Products",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple,
        ),
        body: GridView.builder(
            itemCount: product_list.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return Single_prod(
                prod_name: product_list[index]['name'],
                prod_picture: product_list[index]['picture'],
                prod_old_price: product_list[index]['old_price'],
                prod_price: product_list[index]['price'],
              );
            }));
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Single_prod(
      {this.prod_name,
      this.prod_picture,
      this.prod_old_price,
      this.prod_price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new ProductDetails(
                        //passing product content to product_details page
                        product_detail_name: prod_name,
                        product_detail_picture: prod_picture,
                        product_detail_old_price: prod_old_price,
                        product_detail_new_price: prod_price,
                      ))),
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        prod_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        prod_price,
                        style: TextStyle(
                            color: Colors.purple[700],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  child: Image.asset(
                    prod_picture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
