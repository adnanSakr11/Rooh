import 'package:rooh/features/orders/domain/entity/egypt_governorate.dart';
import 'package:rooh/features/orders/domain/entity/shipping_info_entity.dart';

class ShippingInfoModel extends ShippingInfoEntity {
  const ShippingInfoModel({
    required super.fullName,
    required super.phone,
    required super.backupPhone,
    required super.governorate,
    required super.fullAddress,
  });

  factory ShippingInfoModel.fromEntity(ShippingInfoEntity entity) {
    return ShippingInfoModel(
      fullName: entity.fullName,
      phone: entity.phone,
      backupPhone: entity.backupPhone,
      governorate: entity.governorate,
      fullAddress: entity.fullAddress,
    );
  }

  factory ShippingInfoModel.fromMap(Map<String, dynamic> map) {
    return ShippingInfoModel(
      fullName: map['fullName'] as String,
      phone: map['phone'] as String,
      backupPhone: map['backupPhone'] as String,
      // بنخزّن اسم الـ enum (مثلًا "cairo") مش النص العربي.
      governorate: EgyptGovernorate.values.byName(map['governorate'] as String),
      fullAddress: map['fullAddress'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phone': phone,
      'backupPhone': backupPhone,
      'governorate': governorate.name,
      'fullAddress': fullAddress,
    };
  }
}