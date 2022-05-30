import 'dart:io';

import 'package:easy_economy/controller/GainController.dart';
import 'package:easy_economy/controller/SpentController.dart';
import 'package:easy_economy/screens/add.dart';
import 'package:easy_economy/screens/history.dart';
import 'package:easy_economy/style/pallete.dart';
import 'package:easy_economy/utils/Formatter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:easy_economy/widgets/text_legend.dart';
import 'package:easy_economy/widgets/text_value.dart';
import 'package:easy_economy/widgets/white_elevated_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final BannerAd myBanner = BannerAd(
    adUnitId: "ca-app-pub-2745538740370134/2107636435",
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        print('Ad failed to load: $error');
      },
      onAdOpened: (Ad ad) => print('Ad opened.'),
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),
  );

  GainController gainController = GainController();
  SpentController spentController = SpentController();
  Formatter formatter = Formatter();

  List _gainsList = [];
  double _gainsValue = 0;
  List _spentList = [];
  double _spentValue = 0;

  @override
  void initState() {
    myBanner.load();
    super.initState();
    _getAllGain();
    _getTotalGainValue();
    _getAllSpent();
    _getTotalSpentValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Easy Economy"),
        backgroundColor: Pallete().primary,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Pallete().primary,
            systemNavigationBarIconBrightness: Brightness.light),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Pallete().primary, Pallete().primaryLight])),
              child: Column(children: [
                Text(
                  "Você ainda possui",
                  style: TextStyle(color: Pallete().gray, fontSize: 14),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    formatter.getCurrency(_gainsValue - _spentValue),
                    style: TextStyle(color: Pallete().whiteText, fontSize: 36),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    _gainsValue - _spentValue > 0
                        ? "Você gastou " +
                            formatter
                                .percentageFormat(_spentValue / _gainsValue) +
                            "% do seus ganhos"
                        : "Não é possível obter o calculo",
                    style: TextStyle(color: Colors.white60, fontSize: 10),
                  ),
                )
              ]),
            ),
            GestureDetector(
              onTap: () => navigateToList("spent"),
              child: WhiteElevatedContainer(children: [
                TextLegend(text: "Despesas"),
                TextValue(
                    value: formatter.getCurrency(_spentValue),
                    color: Pallete().red),
              ]),
            ),
            GestureDetector(
                onTap: () => navigateToList("gain"),
                child: WhiteElevatedContainer(children: [
                  TextLegend(text: "Ganhos"),
                  TextValue(
                      value: formatter.getCurrency(_gainsValue),
                      color: Pallete().green),
                ])),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 50,
        width: double.maxFinite,
        child: AdWidget(
          ad: myBanner,
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: Pallete().primary,
        foregroundColor: Pallete().whiteText,
        overlayOpacity: 0,
        children: [
          SpeedDialChild(
              backgroundColor: Pallete().primaryLight,
              foregroundColor: Pallete().whiteText,
              child: Icon(Icons.attach_money),
              label: "Adicionar ganhos",
              onTap: () => navigateToAdd("gain")),
          SpeedDialChild(
              backgroundColor: Pallete().primaryLight,
              foregroundColor: Pallete().whiteText,
              child: Icon(Icons.money_off),
              label: "Adicionar despesas",
              onTap: () => navigateToAdd("spent"))
        ],
      ),
    );
  }

  void _getAllGain() async {
    setState(() {
      _gainsList = gainController.getAll();
    });
  }

  void _getTotalGainValue() {
    setState(() {
      _gainsValue = gainController.getTotalValue(_gainsList);
    });
  }

  void _getAllSpent() {
    setState(() {
      _spentList = spentController.getAll();
    });
  }

  void _getTotalSpentValue() {
    setState(() {
      _spentValue = spentController.getTotalValue(_spentList);
    });
  }

  _update(dynamic value) async {
    _getAllGain();
    _getTotalGainValue();
    _getAllSpent();
    _getTotalSpentValue();
  }

  void navigateToAdd(item) {
    Route route = MaterialPageRoute(builder: (context) => Add(item: item));
    Navigator.push(context, route).then(_update);
  }

  void navigateToList(item) {
    Route route = MaterialPageRoute(builder: (context) => History(item: item));
    Navigator.push(context, route).then(_update);
  }
}
