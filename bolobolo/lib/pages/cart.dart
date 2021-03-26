import 'package:flutter/material.dart';
import 'package:flutter_demo/componets/cart_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.purple[700],
        title: Text(
          "Shopping cart",
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),

      //Body
      body: Cart_products(),

      // ========BottomNavigationBar=============
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
              title: Text("Total"),
              subtitle: Text("IDR 100,000"),
            )),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: new MaterialButton(
                    onPressed: () {},
                    child: new Text(
                      "Check out",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.purple[700],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
