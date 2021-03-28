import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:bolobolo/componets/horizontal_listview.dart';
import 'package:bolobolo/componets/products.dart';
import 'package:bolobolo/pages/cart.dart';
import 'package:bolobolo/pages/chats.dart';
import 'package:bolobolo/pages/signin.dart';
import 'package:bolobolo/screens/wishlist.dart';

import 'pages/chats.dart';
import 'pages/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 150,
      child: new Carousel(
        boxFit: BoxFit.fitHeight,
        images: [
          //NetworkImage("https://bagule-images.s3.us-east-2.amazonaws.com/1562234993811.jpeg"),
          AssetImage('images/keti.jpg'),
          AssetImage('images/bajupolos.jpg'),
          AssetImage('images/jeans.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 5,
        dotBgColor: Colors.transparent,
        indicatorBgPadding: 2,
      ),
    );

    return Scaffold(
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Colors.purple[700],
          title: Text("BoloBolo"),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => new Cart())))
          ],
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              //Drawer header
              new UserAccountsDrawerHeader(
                accountName: Text("Marli"),
                accountEmail: Text("marleykatz@gmail.com"),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('images/marli.jpg'),
                    /*child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),*/
                  ),
                ),
                decoration: new BoxDecoration(color: Colors.purple[700]),
              ),

              //Drawer body
              new InkWell(
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new HomePage())),
                child: ListTile(
                  title: Text("Home"),
                  leading: Icon(Icons.home),
                ),
              ),

              new InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text("My Orders"),
                  leading: Icon(Icons.shopping_basket),
                ),
              ),

              new InkWell(
                onTap: () => Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => new Cart())),
                child: ListTile(
                  title: Text("Shopping cart"),
                  leading: Icon(Icons.shopping_cart),
                ),
              ),

              new InkWell(
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new Wishlist())),
                child: ListTile(
                  title: Text("My Wishlist"),
                  leading: Icon(Icons.favorite),
                ),
              ),

              Divider(),

              new InkWell(
                onTap: () => Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => MyApps())),
                child: ListTile(
                  title: Text("My Account"),
                  leading: Icon(Icons.person),
                ),
              ),

              new InkWell(
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new SignInScreen())),
                child: ListTile(
                  title: Text("Logout"),
                  leading: Icon(Icons.person),
                ),
              ),

              new InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text("Settings"),
                  leading: Icon(Icons.settings),
                ),
              )
            ],
          ),
        ),
        body: new ListView(
          children: <Widget>[
            image_carousel,

            //padding widget
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Text(
                "All Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),

            //horizontal list for categories
            HorizontalList(),

            //padding widget
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Text(
                "Recent products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),

            //grid_view for products
            new Container(
              height: 420,
              child: Products(),
            ),

            new Container(
              height: 10,
              //child: Products(),
            ),
          ],
        ),
        bottomNavigationBar: new BottomNavigationBar(currentIndex: 0, items: [
          BottomNavigationBarItem(
            icon: InkWell(onTap: () {}, child: Icon(Icons.home)),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: () => Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) => MyApp())),
                child: Icon(Icons.message)),
            title: Text("Chats"),
          ),
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: () => Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => MyApps())),
                child: Icon(Icons.account_circle)),
            title: Text("My Profile"),
          ),
        ]));
  }
}
