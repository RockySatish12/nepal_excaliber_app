import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ProfileTileWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String title;
  const ProfileTileWidget(
      {Key? key,
      required this.onTap,
      required this.iconData,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            leading: Icon(
              iconData,
              color: AppColors.textColor,
            ),
            title: Text(title),
          ),
          const SizedBox(
            height: 4,
          ),
          const Divider()
        ],
      ),
    );
    ;
  }
}
