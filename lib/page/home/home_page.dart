import 'package:flutter/material.dart';
import 'package:sales_management/page/home/child/management.dart';
import 'package:sales_management/utils/constants.dart';

import '../../utils/svg_loader.dart';
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

    return SafeArea(
      child: Scaffold(
        appBar: HomeAppBar(),
        bottomNavigationBar: Container(
          height: 46,
          decoration:
              const BoxDecoration(color: White, boxShadow: [wholeShadow]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadSvg(assetPath: 'svg/home_bar.svg'),
                    const Text(
                      'Quản lý',
                      style: subInfoStySmall,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadSvg(assetPath: 'svg/plus_bar.svg'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadSvg(assetPath: 'svg/in_out_bar.svg'),
                    const Text(
                      'Thu chi',
                      style: subInfoStySmall,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: page,
      ),
    );
  }
}
