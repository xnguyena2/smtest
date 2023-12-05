import 'package:flutter/material.dart';

abstract class BarMedium extends StatelessWidget
    implements PreferredSizeWidget {
  const BarMedium({super.key});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
