// import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedexapp/app/ui/pages/pokedex_page.dart';
import 'package:pokedexapp/app/ui/widgets/pokeball_widget.dart';

import '../models/colors_model.dart';
import '../models/images_model.dart';

// main class
class HomeController extends StatelessWidget {
  const HomeController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          Positioned(
            top: -70.0,
            right: -85.0,
            child:
                PokeballWidget(ImagesModel.iconPokeballGrey, 0.2, 250.0, 250.0),
          ),
          _listView(context),
        ],
      ),
    );
  }

  Widget _listView(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      children: <Widget>[
        const SizedBox(height: 60.0),
        Container(
          margin: const EdgeInsets.only(left: 20.0),
          child: const Text("Pokedex",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
        ),
        const SizedBox(height: 30.0),
        _wrap(context),
        const SizedBox(height: 20.0),
      ],
    );
  }

  Widget _wrap(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      alignment: WrapAlignment.center,
      children: <Widget>[
        _inkWell(
            context, ImagesModel.imageKanto, "I Geração", "Kanto", 0, 151, 20),
        _inkWell(context, ImagesModel.imageJohto, "II Geração", "Johto", 152,
            251, 173),
        _inkWell(context, ImagesModel.imageHoenn, "III Geração", "Hoenn", 252,
            386, 273),
        _inkWell(context, ImagesModel.imageSinnoh, "IV Geração", "Sinnoh", 387,
            494, 408),
        _inkWell(context, ImagesModel.imageUnova, "V Geração", "Unova", 495,
            649, 516),
        _inkWell(context, ImagesModel.imageKalos, "VI Geração", "Kalos", 650,
            721, 671),
        _inkWell(context, ImagesModel.imageAlola, "VII Geração", "Alola", 722,
            809, 743),
        _inkWell(context, ImagesModel.imageGalar, "VIII Geração", "Galar", 810,
            905, 831),
      ],
    );
  }

  Widget _inkWell(BuildContext context, String image, String generation,
      String region, int start, int end, int limit) {
    return InkWell(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: ColorsModel.grey,
              blurRadius: 6.0,
              spreadRadius: 4.0,
              offset: Offset(3, 3),
            ),
          ],
        ),
        width: 180.0,
        height: 150.0,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.contain),
                ),
                width: 175.0,
                height: 100.0,
              ),
            ),
            Positioned(
              top: 20.0,
              left: 20.0,
              child: Text(generation,
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.black,
                        blurRadius: 7.0,
                        offset: Offset(2, 2),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
      onTap: () {
        // actived void
        _setData(context, region, start, end, limit);
      },
    );
  }

  // void
  void _setData(
      BuildContext context, String region, int start, int end, int limit) {
    // navigator
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => PokedexPage(region, start, end, limit)));
  }
}