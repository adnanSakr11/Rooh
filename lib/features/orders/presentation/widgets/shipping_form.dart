import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:rooh/features/orders/domain/entity/egypt_governorate.dart';
import 'package:rooh/features/orders/domain/entity/shipping_info_entity.dart';
import 'package:rooh/shared/widgets/app_button.dart';

class ShippingForm extends StatefulWidget {
  const ShippingForm({
    super.key,
    required this.isSubmitting,
    required this.onSubmit,
  });

  final bool isSubmitting;
  final ValueChanged<ShippingInfoEntity> onSubmit;

  @override
  State<ShippingForm> createState() => _ShippingFormState();
}

class _ShippingFormState extends State<ShippingForm> {
  static final RegExp _mobileRegex = RegExp(r'^01[0125]\d{8}$');
  static final RegExp _arabicDigits = RegExp('[٠-٩]');
  static const int _minNameLength = 3;
  static const int _minAddressLength = 10;
  static const int _addressMaxLines = 3;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _backupPhoneController = TextEditingController();
  final _addressController = TextEditingController();
  EgyptGovernorate? _governorate;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _backupPhoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  /// بيحوّل الأرقام العربية (٠١٢) للاتينية، وبيشيل المسافات.
  String _normalize(String value) => value.trim().replaceAllMapped(
    _arabicDigits,
    (m) => (m[0]!.codeUnitAt(0) - 0x0660).toString(),
  );

  String? _validateName(String? value) {
    if (value == null || value.trim().length < _minNameLength) {
      return 'من فضلك أدخل الاسم بالكامل';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (!_mobileRegex.hasMatch(_normalize(value ?? ''))) {
      return 'أدخل رقم موبايل مصري صحيح (11 رقم)';
    }
    return null;
  }

  String? _validateBackupPhone(String? value) {
    final phone = _normalize(value ?? '');
    if (phone.isEmpty) return null; // اختياري
    if (!_mobileRegex.hasMatch(phone)) return 'رقم الموبايل غير صحيح';
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.trim().length < _minAddressLength) {
      return 'اكتب العنوان بالتفصيل (المدينة، الشارع، رقم المبنى)';
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    widget.onSubmit(
      ShippingInfoEntity(
        fullName: _nameController.text.trim(),
        phone: _normalize(_phoneController.text),
        backupPhone: _normalize(_backupPhoneController.text),
        governorate: _governorate!,
        fullAddress: _addressController.text.trim(),
      ),
    );
  }

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final iconColor = colors.onSurface.withValues(alpha: 0.6);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'بيانات الشحن',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: colors.onSurface,
            ),
          ),
          const SizedBox(height: 14),
          AuthTextField(
            controller: _nameController,
            hintText: 'الاسم بالكامل',
            keyboardType: TextInputType.name,
            prefixIcon: Icon(CupertinoIcons.person, color: iconColor, size: 20),
            validator: _validateName,
          ),
          const SizedBox(height: 14),
          AuthTextField(
            controller: _phoneController,
            hintText: 'رقم الموبايل',
            keyboardType: TextInputType.phone,
            prefixIcon: Icon(CupertinoIcons.phone, color: iconColor, size: 20),
            validator: _validatePhone,
          ),
          const SizedBox(height: 14),
          AuthTextField(
            controller: _backupPhoneController,
            hintText: 'رقم احتياطي (اختياري)',
            keyboardType: TextInputType.phone,
            prefixIcon: Icon(CupertinoIcons.phone, color: iconColor, size: 20),
            validator: _validateBackupPhone,
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<EgyptGovernorate>(
            initialValue: _governorate,
            isExpanded: true,
            alignment: Alignment.centerRight,
            dropdownColor: colors.secondary,
            borderRadius: BorderRadius.circular(16),
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: iconColor),
            hint: Text(
              'المحافظة',
              style: TextStyle(
                fontFamily: fontFamily,
                color: colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: colors.secondary,
              errorStyle: const TextStyle(color: Colors.redAccent),
              border: _border(colors.primary.withValues(alpha: 0.3)),
              enabledBorder: _border(colors.primary.withValues(alpha: 0.3)),
              focusedBorder: _border(colors.primary, width: 1.4),
            ),
            items: EgyptGovernorate.values
                .map(
                  (g) => DropdownMenuItem<EgyptGovernorate>(
                    value: g,
                    alignment: Alignment.centerRight,
                    child: Text(
                      g.displayName,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        color: colors.onSurface,
                      ),
                    ),
                  ),
                )
                .toList(),
            validator: (g) => g == null ? 'اختر المحافظة' : null,
            onChanged: (g) => setState(() => _governorate = g),
          ),
          const SizedBox(height: 14),
          AuthTextField(
            controller: _addressController,
            hintText: 'العنوان بالتفصيل',
            keyboardType: TextInputType.multiline,
            maxLines: _addressMaxLines,
            prefixIcon: Icon(CupertinoIcons.location, color: iconColor, size: 20),
            validator: _validateAddress,
          ),
          const SizedBox(height: 26),
          AppButton(
            text: 'تأكيد الطلب',
            isLoading: widget.isSubmitting,
            onTap: _submit,
          ),
        ],
      ),
    );
  }
}