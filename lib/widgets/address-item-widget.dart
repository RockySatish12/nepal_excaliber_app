import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AddressItemWidget extends StatelessWidget {
  const AddressItemWidget({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.home),
              const SizedBox(
                width: 9,
              ),
              Text(
                "Home",
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Anisha Thapa",
            style: theme.textTheme.bodyLarge,
          ),
          Text(
            "9812345670",
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Gandaki Province, Kaski, Pokhara, Lamachaur, Bhaktipath",
            textAlign: TextAlign.justify,
            maxLines: 3,
            style: theme.textTheme.bodyMedium!
                .copyWith(color: AppColors.hintTextColor),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.tertiaryColor,
                  ),
                  label: Text(
                    "Edit",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.tertiaryColor,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.errorColor,
                  ),
                  label: Text(
                    "Remove",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.errorColor,
                        ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
