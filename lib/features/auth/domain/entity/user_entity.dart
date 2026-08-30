import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uId;
  final String userName;
  final String? phoneNumber;

  const UserEntity(
    this.phoneNumber,{
    required this.uId,
    required this.userName,
     
  });

  @override
  List<Object?> get props => [uId, userName, ];
}
