import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';

class PlanetDetailsScreen extends StatelessWidget {
  const PlanetDetailsScreen({super.key, required this.planetModel});

  final PlanetModel planetModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorsScheme.background,
      appBar: AppBarStar(
        title: 'Detalhes dos planetas',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                width: size.width,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  color: ColorsScheme.greyDark,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/images/planets.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Card(
                color: ColorsScheme.greyLight,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDetailItem('Nome', planetModel.name),
                      buildDetailItem('População', planetModel.population),
                      buildDetailItem('Clima', planetModel.climate),
                      buildDetailItem('Tamanho', planetModel.diameter),
                      buildDetailItem(
                          'Período orbital', planetModel.orbitalPeriod),
                      buildDetailItem(
                          'Período rotacional', planetModel.rotationPeriod),
                      buildDetailItem(
                          'Água superficial', planetModel.surfaceWater),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: ColorsScheme.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.0,
                color: ColorsScheme.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
