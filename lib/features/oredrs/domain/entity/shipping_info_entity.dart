import 'package:equatable/equatable.dart';
import 'package:rooh/features/oredrs/domain/entity/egypt_governorate.dart';

class ShippingInfoEntity extends Equatable {
  final String fullName;
  final String phone;
  final String backupPhopne;
  final EgyptGovernorate governorate;
  final String fullAddress;

  const ShippingInfoEntity({
    required this.fullName,
    required this.phone,
    required this.backupPhopne,
    required this.governorate,
    required this.fullAddress,
  });
  
  @override
  List<Object?> get props => [
    fullName,
    phone,
    backupPhopne,
    governorate,
    fullAddress,
  ];
}
