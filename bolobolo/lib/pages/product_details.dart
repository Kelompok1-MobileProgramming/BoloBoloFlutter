import 'package:flutter/material.dart';
import 'package:bolobolo/componets/products.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_picture;
  final product_detail_old_price;
  final product_detail_new_price;

  ProductDetails(
      {this.product_detail_name,
      this.product_detail_picture,
      this.product_detail_old_price,
      this.product_detail_new_price});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.purple[700],
        title: Text(
          "Products",
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
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 250,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.product_detail_picture),
              ),
//              footer: Container(
//                height: 50,
//                color: Colors.white,
//                child: ListTile(
//                  title: Text(widget.product_detail_name, style: TextStyle(fontWeight: FontWeight.bold),),
//                ),
//              ),
            ),
          ),
          new Container(
            color: Colors.purple[700],
            child: ListTile(
              leading: Text(
                widget.product_detail_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              title: new Row(
                children: <Widget>[
                  Expanded(
                    child: Text(""),
                  ),
                  Expanded(
                    child: Text(
                      widget.product_detail_new_price,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //=======Buttons functions==============
          new Row(
            children: <Widget>[
              //=======Type button functions==============
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.white,
                  textColor: Colors.purple[700],
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Type"),
                      ),
                      Expanded(
                        child: new Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
              ),

              //=======Quantity button functions==============
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: Text("Quantity"),
                            content: Text("Choose the quantity"),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: new Text("Cancel"),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.purple[700],
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Quantity"),
                      ),
                      Expanded(
                        child: new Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          //=======Buttons functions==============
          new Row(
            children: <Widget>[
              //=======Type button functions==============
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(
                      Icons.chat,
                      color: Colors.purple[700],
                    ),
                    title: Text("Chat"),
                  ),
                ),
              ),

              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.purple[700],
                    ),
                    title: Text("To cart"),
                  ),
                ),
              ),
            ],
          ),

          new Row(
            children: <Widget>[
              //=======Type button functions==============
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: MaterialButton(
                    onPressed: () {},
                    color: Colors.purple[700],
                    elevation: 0.2,
                    child: Text(
                      "Buy Now",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ),

              new IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.purple[700]),
                  onPressed: () {}),

              new IconButton(
                  icon: Icon(Icons.star_border, color: Colors.purple[700]),
                  onPressed: () {})
            ],
          ),

          Divider(),
          //product details
          new ListTile(
            title: Text(
              "Product Details",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Best product ever"),
          ),

          Divider(),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  "Product Name:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(widget.product_detail_name),
              )
            ],
          ),

          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  "Provider Name:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text("Matahari"),
              )
            ],
          ),

          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  "Provider Location:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text("Indonesia"),
              )
            ],
          ),

          Divider(),

          //Related products
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Text(
              "Related products",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),

          new Container(
            height: 420,
            child: Products(),
          ),
        ],
      ),
    );
  }
}
