// ignore_for_file: must_be_immutable

import 'package:easy_economy/controller/GeneralController.dart';
import 'package:easy_economy/controller/SpentController.dart';
import 'package:easy_economy/style/pallete.dart';
import 'package:easy_economy/utils/Formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../controller/GainController.dart';
import 'add.dart';

class History extends StatefulWidget {
  History({Key? key, required this.item}) : super(key: key);
  String item;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final BannerAd myBanner = BannerAd(
    adUnitId: "ca-app-pub-2745538740370134/6659472570",
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
  GeneralController generalController = GeneralController();
  Formatter formatter = Formatter();

  final _spentBox = Hive.box("spent");
  final _gainBox = Hive.box("gain");

  List _history = [];
  double _totalValue = 0;

  late Color color;
  String sinal = "";
  List<Color> colors = [];

  @override
  void initState() {
    myBanner.load();
    super.initState();
    _defineList();
    _getTotalValue();
  }

  @override
  Widget build(BuildContext context) {
    String screenTitle = "";

    if (widget.item == "gain") {
      setState(() {
        screenTitle = "Histórico de ganhos";
        color = Pallete().green;
        colors = [Pallete().green, Pallete().greenLight];
      });
    } else {
      setState(() {
        screenTitle = "Histórico de despesas";
        color = Pallete().red;
        sinal = "- ";
        colors = [Pallete().red, Pallete().redLight];
      });
    }
    _defineList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(screenTitle),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: color,
            systemNavigationBarIconBrightness: Brightness.light),
        actions: [
          IconButton(
              onPressed: () {
                navigateToAdd(widget.item);
              },
              icon: Icon(
                Icons.add_circle_outline,
                size: 32,
              ))
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: colors)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("Total",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Pallete().whiteText)),
                  ),
                  Text(
                    sinal + formatter.getCurrency(_totalValue),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Pallete().whiteText,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 1,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _history.length,
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  child: Text(
                                    _history[index]["title"],
                                    style: TextStyle(
                                      color: Pallete().primary,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 2),
                                    child: Text(
                                      formatter.getCurrency(
                                          _history[index]["value"]),
                                      style: TextStyle(
                                          color: color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800),
                                    )),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  child: Text(
                                    formatter.percentageFormat(_history[index]
                                                ["value"] /
                                            _totalValue) +
                                        "% do total ",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Pallete().blackText),
                                  ),
                                )
                              ],
                            ),
                            IconButton(
                              onPressed: () =>
                                  _deleteItem(_history[index]["key"]),
                              icon: Icon(
                                Icons.delete,
                                color: Pallete().red,
                              ),
                            )
                          ]),
                    )),
          ),
          Container(
            height: 50,
            width: double.maxFinite,
            child: AdWidget(
              ad: myBanner,
            ),
          ),
        ],
      ),
    );
  }

  void _defineList() {
    if (widget.item == "gain") {
      setState(() {
        _history = gainController.getAll();
      });
    } else if (widget.item == "spent") {
      setState(() {
        _history = spentController.getAll();
      });
    }
  }

  void _deleteItem(int key) async {
    generalController.deleteItem(key, widget.item);
    _defineList();
    _getTotalValue();
  }

  void _getTotalValue() async {
    setState(() {
      _totalValue = generalController.getTotalValue(_history);
    });
  }

  _update(dynamic value) {
    _defineList();
    _getTotalValue();
  }

  void navigateToAdd(item) {
    Route route = MaterialPageRoute(builder: (context) => Add(item: item));
    Navigator.push(context, route).then(_update);
  }
}
