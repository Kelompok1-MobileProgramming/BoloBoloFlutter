import '../models/user_model.dart';

class Message {
  final User sender;
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.unread,
  });
}

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: jerry,
    time: '5:30 PM',
    text: 'Kak, barangnya baru sampai kok uda rusak?',
    unread: true,
  ),
  Message(
    sender: tom,
    time: '4:30 PM',
    text: 'Barangnya sudah sampai mana kak?',
    unread: true,
  ),
  Message(
    sender: andrie,
    time: '3:30 PM',
    text: 'Yang ini ready tidak kak?',
    unread: false,
  ),
  Message(
    sender: dian,
    time: '2:30 PM',
    text: 'Biru ready?',
    unread: true,
  ),
  Message(
    sender: spike,
    time: '1:30 PM',
    text: 'Kk, baju polos ada ukuran XL tidak?',
    unread: false,
  ),
  Message(
    sender: marli,
    time: '12:30 PM',
    text: 'Apakah kk menjual tiket keti?',
    unread: false,
  ),
  Message(
    sender: mike,
    time: '11:30 AM',
    text: 'Halo?',
    unread: false,
  ),
  Message(
    sender: bella,
    time: '12:45 AM',
    text: 'Kak',
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: jerry,
    time: '5:30 PM',
    text: 'Hey dude! Event dead I\'m the hero. Love you 3000 guys.',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'We could surely handle this mess much easily if you were here.',
    unread: true,
  ),
  Message(
    sender: jerry,
    time: '3:45 PM',
    text: 'Take care of peter. Give him all the protection & his aunt.',
    unread: true,
  ),
  Message(
    sender: jerry,
    time: '3:15 PM',
    text: 'I\'m always proud of her and blessed to have both of them.',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text:
        'But that spider kid is having some difficulties due his identity reveal by a blog called daily bugle.',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text:
        'Pepper & Morgan is fine. They\'re strong as you. Morgan is a very brave girl, one day she\'ll make you proud.',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Yes Tony!',
    unread: true,
  ),
  Message(
    sender: jerry,
    time: '2:00 PM',
    text: 'I hope my family is doing well.',
    unread: true,
  ),
];
