import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/features/auth/presentation/cubits/update_user_name/update_user_name_cubit.dart';

/// بيفتح dialog لتعديل اسم اليوزر.
///
/// مهم: بناخد الـ cubit من الـ context بتاع اللي نادى الدالة (لازم يكون
/// أب لـ BlocProvider<UpdateUserNameCubit>)، وبعدين بنعديه يدويًا لجوه
/// الـ dialog عن طريق BlocProvider.value. السبب: showDialog بيحط الـ
/// widget الجديد جوه الـ Navigator مباشرة، مش جوه الشجرة اللي احنا فيها،
/// فلو معملناش كده الـ dialog مش هيلاقي الـ cubit.
Future<void> showEditNameDialog({
  required BuildContext context,
  required String currentName,
}) {
  final cubit = context.read<UpdateUserNameCubit>();

  return showDialog(
    context: context,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: _EditNameDialog(currentName: currentName),
    ),
  );
}

class _EditNameDialog extends StatefulWidget {
  const _EditNameDialog({required this.currentName});

  final String currentName;

  @override
  State<_EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<_EditNameDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final newName = _controller.text.trim();
    if (newName.isEmpty) return;
    context.read<UpdateUserNameCubit>().updateUserName(newName);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocListener<UpdateUserNameCubit, UpdateUserNameState>(
      listener: (context, state) {
        if (state is UpdtaeUserNameSucced) {
          Navigator.of(context).pop();
        } else if (state is UpdateUserNameError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: TextStyle(fontFamily: fontFamily),
              ),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      },
      child: AlertDialog(
        backgroundColor: colors.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: Text(
          'تعديل الاسم',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.bold,
            color: colors.onSurface,
          ),
        ),
        content: TextField(
          controller: _controller,
          textAlign: TextAlign.right,
          autofocus: true,
          style: TextStyle(fontFamily: fontFamily, color: colors.onSurface),
          decoration: InputDecoration(
            hintText: 'اكتب اسمك الجديد',
            hintStyle: TextStyle(fontFamily: fontFamily),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.primary.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.primary, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'إلغاء',
              style: TextStyle(fontFamily: fontFamily, color: colors.onSurface),
            ),
          ),
          BlocBuilder<UpdateUserNameCubit, UpdateUserNameState>(
            builder: (context, state) {
              final isLoading = state is UpdateUserNameLoading;
              return TextButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colors.primary,
                        ),
                      )
                    : Text(
                        'حفظ',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.bold,
                          color: colors.primary,
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}