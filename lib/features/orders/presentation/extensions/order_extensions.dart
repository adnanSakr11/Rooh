import 'package:intl/intl.dart';
import 'package:rooh/features/orders/domain/entity/order_entity.dart';

const int _shortIdLength = 6;

String shortOrderId(String id) {
  final start = id.length > _shortIdLength ? id.length - _shortIdLength : 0;
  return id.substring(start).toUpperCase();
}

extension OrderEntityExtensions on OrderEntity {
  String get shortId => shortOrderId(id);

  String get formattedDate =>
      DateFormat('d MMMM yyyy، h:mm a', 'ar').format(createdAt);
}