import 'package:flutter/material.dart';
import 'package:nepal_excaliber/models/address.dart';

import '../utils/colors.dart';

class AddressItemWidget extends StatelessWidget {
  final Address address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const AddressItemWidget({
    Key? key,
    required this.theme,
    required this.address,
    required this.onEdit,
    required this.onDelete,
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
              const Icon(Icons.location_city_outlined),
              const SizedBox(
                width: 9,
              ),
              Text(
                address.label!,
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            address.contactName!,
            style: theme.textTheme.bodyLarge,
          ),
          Text(
            address.contact!,
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            address.toString(),
            textAlign: TextAlign.justify,
            maxLines: 3,
            style: theme.textTheme.bodyMedium!
                .copyWith(color: AppColors.hintTextColor),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: onEdit,
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
                  onPressed: onDelete,
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
