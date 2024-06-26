import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            width: size.width,
            height: size.height * 0.37,
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
                image: AssetImage(
                  'assets/images/star_home.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            itemCount: 3,
            separatorBuilder: (context, index) => SizedBox(height: 5.0),
            itemBuilder: (context, index) {
              Widget icon;
              String title;
              VoidCallback? onTap;

              switch (index) {
                case 0:
                  icon = SvgPicture.asset(
                    'assets/images/darth-vader.svg',
                    width: 50,
                    height: 50,
                  );
                  title = "Personagens";
                  onTap = () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PersonPage(),
                    ));
                  };
                  break;
                case 1:
                  icon = Image.asset(
                    'assets/images/venus.png',
                    height: 50.0,
                    width: 50.0,
                  );
                  title = "Planetas";
                  onTap = () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PlanetPage(),
                    ));
                  };
                  break;
                case 2:
                  icon = SvgPicture.asset(
                    'assets/images/bb-8.svg',
                    width: 50,
                    height: 50,
                  );
                  title = "Filmes";
                  onTap = () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MoviesPage(),
                    ));
                  };
                  break;
                default:
                  icon = SizedBox();
                  title = "";
                  onTap = () {};
                  break;
              }

              return InkWell(
                onTap: onTap,
                child: Card(
                  elevation: 9,
                  color: ColorsScheme.greyLight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        icon,
                        SizedBox(width: 20.0),
                        Text(
                          title,
                          style: TextStyle(
                            color: ColorsScheme.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
