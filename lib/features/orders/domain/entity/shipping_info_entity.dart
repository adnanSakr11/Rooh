import 'package:equatable/equatable.dart';
import 'egypt_governorate.dart';

class ShippingInfoEntity extends Equatable {
  final String fullName;
  final String phone;
  final String backupPhone;
  final EgyptGovernorate governorate;
  final String fullAddress;

  const ShippingInfoEntity({
    required this.fullName,
    required this.phone,
    required this.backupPhone,
    required this.governorate,
    required this.fullAddress,
  });

  @override
  List<Object?> get props => [
    fullName,
    phone,
    backupPhone,
    governorate,
    fullAddress,
  ];
}