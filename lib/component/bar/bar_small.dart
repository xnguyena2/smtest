import 'package:flutter/material.dart';

abstract class BarSmall extends StatelessWidget implements PreferredSizeWidget {
  const BarSmall({super.key});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(47);
}
