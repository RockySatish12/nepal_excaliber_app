import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nepal_excaliber/utils/colors.dart';

class EmptyScreen extends StatelessWidget {
  final String image;
  final String title;
  final String message;
  const EmptyScreen(
      {Key? key,
      required this.image,
      required this.title,
      required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            height: MediaQuery.of(context).size.height / 2,
            fit: BoxFit.contain,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontStyle: FontStyle.normal),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.hintTextColor,
                  ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
