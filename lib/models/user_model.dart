
// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String uId;
  final String name;
  final String phoneNumber;
  final bool isOnline;
  final String profilePicture;
  final List<String> groupId;

  UserModel({
    required this.uId,
    required this.name,
    required this.phoneNumber,
    required this.isOnline,
    required this.profilePicture,
    required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uId': uId,
      'name': name,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'profilePicture': profilePicture,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      isOnline: map['isOnline'] as bool,
      profilePicture: map['profilePicture'] as String,
      groupId: List<String>.from(
        (map['groupId'] ),
      ),
    );
  }


}
