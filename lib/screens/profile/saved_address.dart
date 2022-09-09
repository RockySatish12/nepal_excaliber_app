import 'package:flutter/material.dart';
import 'package:nepal_excaliber/utils/colors.dart';

import '../../widgets/address-item-widget.dart';

class SavedAddressScreen extends StatelessWidget {
  static const routeName = "/saved-address";
  const SavedAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Address"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 6),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return AddressItemWidget(theme: theme);
            },
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                top: 12,
                right: 12,
                left: 12,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.tertiaryColor),
                  borderRadius: BorderRadius.circular(8)),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Add Address",
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: AppColors.tertiaryColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
