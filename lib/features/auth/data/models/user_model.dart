import 'package:rooh/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
    super.phoneNumber, {
    required super.uId,
    required super.userName,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['phoneNumber'] as String?,
      uId: map['uId'] as String,
      userName: map['userName'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'userName': userName,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
    };
  }
}
