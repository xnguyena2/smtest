import 'package:flutter/material.dart';

abstract class BarXLarge extends StatelessWidget
    implements PreferredSizeWidget {
  const BarXLarge({super.key});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(95);
}
