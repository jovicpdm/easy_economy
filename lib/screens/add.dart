// ignore_for_file: prefer_const_constructors
import 'package:easy_economy/controller/GeneralController.dart';
import 'package:easy_economy/style/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';

class Add extends StatefulWidget {
  const Add({Key? key, required this.item}) : super(key: key);
  final String item;

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final BannerAd myBanner = BannerAd(
    adUnitId: "ca-app-pub-2745538740370134/8728314287",
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

  GeneralController generalController = GeneralController();

  String pageTitle = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item == "gain") {
      setState(() {
        pageTitle = "Registrar ganhos";
      });
    } else if (widget.item == "spent") {
      setState(() {
        pageTitle = "Registrar gasto";
      });
    }
    TextEditingController title = TextEditingController();
    TextEditingController value = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Pallete().primary,
        ),
        backgroundColor: Pallete().primary,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Título"),
              controller: title,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Valor"),
              keyboardType: TextInputType.number,
              controller: value,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancelar",
                        style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1.25,
                            color: Pallete().primary),
                      )),
                  Container(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Pallete().primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      onPressed: () {
                        if (title.text == "" && value.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Pallete().primary,
                              content: Text(
                                "Erro, campos vazios",
                                style: TextStyle(color: Pallete().secondary),
                              )));
                        } else if (value.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Pallete().primary,
                              content: Text(
                                "Erro, campo VALOR vazio",
                                style: TextStyle(color: Pallete().secondary),
                              )));
                        } else if (title.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Pallete().primary,
                              content: Text(
                                "Erro, campo TITULO vazio",
                                style: TextStyle(color: Pallete().secondary),
                              )));
                        } else {
                          generalController.createItem({
                            "date": DateTime.now(),
                            "title": title.text,
                            "value":
                                double.parse(value.text.replaceAll(',', '.')),
                          }, context, widget.item);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Salvar",
                        style: TextStyle(fontSize: 16, letterSpacing: 1.25),
                      ))
                ],
              ),
            ),
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
    );
  }
}
