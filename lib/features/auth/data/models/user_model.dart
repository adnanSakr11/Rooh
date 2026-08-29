import 'package:rooh/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
    super.phoneNumber, {
    required super.uId,
    required super.userName,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['phoneNumber'],
      uId: map['uId'],
      userName: map['userName'],
    );
  }
  Map<String, dynamic> toMap() {
    return {'uId': uId, 'userName': userName, 'phoneNumber': phoneNumber};
  }
}
