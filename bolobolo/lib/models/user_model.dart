class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User({
    this.id,
    this.name,
    this.imageUrl,
    this.isOnline,
  });
}

// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'Nick',
  imageUrl: 'images/cartoon.png',
  isOnline: true,
);

// USERS
final User jerry = User(
  id: 1,
  name: 'Jerry',
  imageUrl: 'images/jerry.jpg',
  isOnline: true,
);
final User tom = User(
  id: 2,
  name: 'Thomas',
  imageUrl: 'images/tom.jpg',
  isOnline: true,
);
final User marli = User(
  id: 3,
  name: 'MarleyKatz',
  imageUrl: 'images/keti.jpg',
  isOnline: false,
);
final User mike = User(
  id: 4,
  name: 'Mike',
  imageUrl: 'images/mike.jpg',
  isOnline: false,
);
final User spike = User(
  id: 5,
  name: 'Spike',
  imageUrl: 'images/spike.jpg',
  isOnline: true,
);
final User bella = User(
  id: 6,
  name: 'Bella',
  imageUrl: 'images/cartoon.png',
  isOnline: false,
);
final User dian = User(
  id: 7,
  name: 'Dian sama',
  imageUrl: 'images/cartoon.png',
  isOnline: false,
);
final User andrie = User(
  id: 8,
  name: 'Andrie Cahyaningtyas',
  imageUrl: 'images/sadcat.jpg',
  isOnline: false,
);
