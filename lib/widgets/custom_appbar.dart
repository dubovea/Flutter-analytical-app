import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        color: Colors.black,
        child: Text(title,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Colors.white)),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/wishlist');
          },
          icon: const Icon(Icons.favorite),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
