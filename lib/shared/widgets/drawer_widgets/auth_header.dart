import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';

class AuthenticatedHeader extends StatelessWidget {
  const AuthenticatedHeader({super.key, 
    required this.userName,
    required this.colors,
    required this.isMobile,
    required this.onEditName,
  });

  final String userName;
  final ColorScheme colors;
  final bool isMobile;
  final VoidCallback? onEditName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 28,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment,
        children: [
          Expanded(
            child: Text(
              userName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: isMobile ? 20 : 23,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onEditName,
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: colors.onSurface.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.pencil,
                size: isMobile ? 16 : 18,
                color: colors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}