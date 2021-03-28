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
    time: '5:30 AM',
    text: 'Kak, barangnya baru sampai kok uda rusak?',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '6:30 PM',
    text: 'Barang sudah dikirim yah :)',
    unread: true,
  ),
  Message(
    sender: jerry,
    time: '5:45 PM',
    text: 'Kk, apakah barangnya sudah dikirim?',
    unread: true,
  ),
  Message(
    sender: jerry,
    time: '3:15 PM',
    text: 'Sudah saya trf ya ka!',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:31 PM',
    text: 'Tolong transfer dulu!',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Bisa di transfer melalui e-money',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Untuk pembayaran',
    unread: true,
  ),
  Message(
    sender: jerry,
    time: '2:00 PM',
    text: 'cara pesannya bagaimana kk?',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '1:30 PM',
    text: 'ada ka!',
    unread: true,
  ),
  Message(
    sender: jerry,
    time: '1:00 PM',
    text: 'Kk, apakah barangnya ada?',
    unread: true,
  ),
];
