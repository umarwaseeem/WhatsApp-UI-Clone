// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChatContact {
  final String name;
  final String contactId;
  final String profilePicture;
  final String lastMessage;
  final DateTime timeSent;
  ChatContact({
    required this.name,
    required this.contactId,
    required this.profilePicture,
    required this.lastMessage,
    required this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'contactId': contactId,
      'profilePicture': profilePicture,
      'lastMessage': lastMessage,
      'timeSent': timeSent.millisecondsSinceEpoch,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] as String,
      contactId: map['contactId'] as String,
      profilePicture: map['profilePicture'] as String,
      lastMessage: map['lastMessage'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
    );
  }
}
