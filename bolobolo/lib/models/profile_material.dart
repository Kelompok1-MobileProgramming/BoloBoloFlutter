/*{
  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
Container(height: 50, width: 50 ,child: Icon(Icons.arrow_back_ios, size: 24,color: Colors.black54,), decoration: BoxDecoration(border: Border.all(color: Colors.black54), borderRadius: BorderRadius.all(Radius.circular(10))),),
Text('Profiles details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
Container(height: 24,width: 24)
]
,
)
,

  Stack(children: <Widget>[CircleAvatar(radius: 70,child: ClipOval(child: Image.asset('images/marli.jpg', height: 150, width: 150, fit: BoxFit.cover,),),),
Positioned(bottom: 1, right: 1 ,child: Container(
height: 40, width: 40,
child: Icon(Icons.add_a_photo, color: Colors.white,),
decoration: BoxDecoration(
color: Colors.deepOrange,
borderRadius: BorderRadius.all(Radius.circular(20))
),
))
],
),

Column(children: <Widget>[Padding(padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),child: Container(height: 60,
child: Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.all(8.0),
child: Text('Name', style: TextStyle(color: Colors.white70),),),), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),),),
Padding(padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),child: Container(height: 60,
child: Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.all(8.0),
child: Text('Email', style: TextStyle(color: Colors.white70),),),),
decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),),),
Padding(padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),child: Container(height: 60,
child: Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.all(8.0),
child: Text('Type something about yourself', style: TextStyle(color: Colors.white70),),
),), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),),),
Padding(padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),child: Container(height: 60,
child: Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.all(8.0),
child: Text('Phone number', style: TextStyle(color: Colors.white70),),),
), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),),),
Expanded(child: Align(alignment: Alignment.bottomRight,child: Container( height: 70, width: 200,
child: Align(child: Text('Save', style: TextStyle(color: Colors.white70, fontSize: 20),),),
decoration: BoxDecoration(color: Colors.deepOrange,borderRadius: BorderRadius.only(topLeft: Radius.circular(30),)),),),)
],
),
))
],
);

}*/
