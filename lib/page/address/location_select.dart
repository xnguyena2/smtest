import 'package:flutter/material.dart';
import 'package:sales_management/page/address/api/address_api.dart';
import 'package:sales_management/page/address/api/model/address_data.dart';
import 'package:sales_management/page/address/api/model/region.dart';
import 'package:sales_management/page/address/component/location_select_bar.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

enum RegionType {
  region,
  district,
  ward,
}

const String regionRequestTitle = 'Chọn Tỉnh/Thành Phố';
const String districtRequestTitle = 'Chọn Quận/Huyện';
const String wardRequestTitle = 'Chọn Phường/Xã';

Region notSelected = Region(id: -1, name: '');

class LocationSelect extends StatefulWidget {
  final AddressData addressData;
  const LocationSelect({super.key, required this.addressData});

  @override
  State<LocationSelect> createState() => _LocationSelectState();
}

class _LocationSelectState extends State<LocationSelect> {
  final double heighDistance = 70;
  late final AddressData addressData;
  String? currentLocation = regionRequestTitle;
  RegionType currentRegionType = RegionType.region;
  String regionName = regionRequestTitle;
  String districtName = districtRequestTitle;
  String wardName = wardRequestTitle;
  double boxSize = 0;

  Region selectedRegion = notSelected;

  late Future<RegionResult> listRegion;

  Map<String, Future<RegionResult>> mapRegion = {};
  final Map<RegionType, String> titleSelector = {
    RegionType.region: 'Tỉnh/Thành Phố',
    RegionType.district: 'Quận/Huyện',
    RegionType.ward: 'Phường/Xã',
  };

  void switchRegion(RegionType type) {
    switch (type) {
      case RegionType.region:
        boxSize = 0;
        currentLocation = regionName;
        String key = 'fetchRegion';
        mapRegion[key] = listRegion = mapRegion[key] ?? fetchRegion();
        break;
      case RegionType.district:
        boxSize = heighDistance * 1;
        currentLocation = districtName;
        String key = '${addressData.region.id}';
        mapRegion[key] =
            listRegion = mapRegion[key] ?? fetchDistrict(addressData.region);
        break;
      case RegionType.ward:
        boxSize = heighDistance * 2;
        currentLocation = wardName;
        String key = '${addressData.region.id}_${addressData.district.id}';
        mapRegion[key] = listRegion = mapRegion[key] ??
            fetchWard(addressData.region, addressData.district);
        break;
    }
  }

  void doneEnter() {
    addressData.regionTextFormat =
        '${addressData.ward.name}, ${addressData.district.name}, ${addressData.region.name}';
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    addressData = widget.addressData;
    if (addressData.region.id > 0) {
      selectedRegion = addressData.region;
      regionName = selectedRegion.name;
    }
    if (addressData.district.id > 0) {
      districtName = addressData.district.name;
    }
    if (addressData.ward.id > 0) {
      wardName = addressData.ward.name;
    }
    switchRegion(currentRegionType);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AddressSelectBar(
          onBackPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: White,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                locationTree(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        // curve: Curves.bounceOut,
                        child: SizedBox(
                          height: boxSize,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          color: White,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          border: defaultBorder,
                        ),
                        child: locationInfo(currentLocation!, isActive: true),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              margin: const EdgeInsets.symmetric(vertical: 2),
              color: BackgroundColor,
              child: Row(
                children: [
                  Text(
                    titleSelector[currentRegionType] ?? 'null',
                    style: headStyleBigMediumBlackLight,
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<RegionResult>(
                future: listRegion,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    RegionResult listRegion = snapshot.data!;
                    return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          locationItem(listRegion.listResult[index], () {
                        switch (currentRegionType) {
                          case RegionType.region:
                            selectedRegion = listRegion.listResult[index];
                            regionName = selectedRegion.name;
                            if (addressData.region.id != selectedRegion.id) {
                              addressData.district = notSelected;
                              addressData.ward = notSelected;
                              districtName = districtRequestTitle;
                              wardName = wardRequestTitle;
                            }
                            addressData.region = selectedRegion;
                            currentRegionType = RegionType.district;
                            switchRegion(currentRegionType);
                            break;
                          case RegionType.district:
                            selectedRegion = listRegion.listResult[index];
                            districtName =
                                currentLocation = selectedRegion.name;
                            if (addressData.district.id != selectedRegion.id) {
                              addressData.ward = notSelected;
                              wardName = wardRequestTitle;
                            }
                            addressData.district = selectedRegion;
                            currentRegionType = RegionType.ward;
                            switchRegion(currentRegionType);
                            break;
                          case RegionType.ward:
                            selectedRegion = listRegion.listResult[index];
                            wardName = currentLocation = selectedRegion.name;
                            addressData.ward = selectedRegion;
                            doneEnter();
                            break;
                        }
                        setState(() {});
                      }),
                      scrollDirection: Axis.vertical,
                      itemCount: listRegion.listResult.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(height: 1),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget locationItem(Region region, VoidCallback onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        color: White,
        child: Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text(
                  region.name,
                  style: TextStyle(
                    color: selectedRegion.id == region.id ? Red : Black,
                  ),
                ),
              ),
            ),
            selectedRegion.id == region.id
                ? LoadSvg(
                    assetPath: 'svg/checked.svg',
                    colorFilter:
                        ColorFilter.mode(TableHighColor, BlendMode.srcIn),
                  )
                : const SizedBox(),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }

  Padding locationTree() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 21,
          ),
          GestureDetector(
            child: locationInfo(regionName),
            onTap: () {
              currentRegionType = RegionType.region;
              selectedRegion = addressData.region;
              switchRegion(currentRegionType);
              setState(() {});
            },
          ),
          addressData.region.id < 0 ? const SizedBox() : divider(),
          addressData.region.id < 0
              ? const SizedBox()
              : GestureDetector(
                  child: locationInfo(districtName),
                  onTap: () {
                    currentRegionType = RegionType.district;
                    selectedRegion = addressData.district;
                    switchRegion(currentRegionType);
                    setState(() {});
                  },
                ),
          addressData.district.id < 0 ? const SizedBox() : divider(),
          addressData.district.id < 0
              ? const SizedBox()
              : GestureDetector(
                  child: locationInfo(wardName),
                  onTap: () {
                    currentRegionType = RegionType.ward;
                    selectedRegion = addressData.ward;
                    switchRegion(currentRegionType);
                    setState(() {});
                  },
                ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  SizedBox divider() {
    return const SizedBox(
      height: 50,
      child: VerticalDivider(
        width: 20,
        thickness: 1,
        color: Black70,
      ),
    );
  }

  Row locationInfo(String date, {bool isActive = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Center(
            child: isActive ? activeCircle() : nromalCircle(),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          date,
          style: TextStyle(color: isActive ? Red : Black),
        )
      ],
    );
  }

  CircleAvatar nromalCircle() {
    return CircleAvatar(
      radius: 5,
      backgroundColor: Black40,
    );
  }

  CircleAvatar activeCircle() {
    return const CircleAvatar(
      radius: 8,
      backgroundColor: Red,
      child: CircleAvatar(
        radius: 7,
        backgroundColor: BackgroundColorLigh,
        child: CircleAvatar(
          radius: 5,
          backgroundColor: Red,
        ),
      ),
    );
  }
}
