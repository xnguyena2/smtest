import 'package:flutter/material.dart';

abstract class BarLarge extends StatelessWidget implements PreferredSizeWidget {
  const BarLarge({super.key});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(64);
}
