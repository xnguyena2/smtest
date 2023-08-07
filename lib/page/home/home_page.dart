import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_management/page/home/child/management.dart';
import 'package:sales_management/utils/constants.dart';

import 'compoment/home_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget page = Management();

    return Scaffold(
      appBar: HomeAppBar(),
      bottomNavigationBar: Container(
        height: 46,
        decoration: const BoxDecoration(color: White, boxShadow: [
          BoxShadow(
            color: ShowdownColor,
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'svg/home_bar.svg',
                    semanticsLabel: 'Quản lý',
                  ),
                  Text(
                    'Quản lý',
                    style: TextStyle(fontSize: 9),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'svg/plus_bar.svg',
                    semanticsLabel: 'plus',
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'svg/in_out_bar.svg',
                    semanticsLabel: 'Thu chi',
                  ),
                  Text(
                    'Thu chi',
                    style: TextStyle(fontSize: 9),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: page,
    );
  }
}
