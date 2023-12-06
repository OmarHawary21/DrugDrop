import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'cart_screen.dart';
import '../widgets/drugs_list.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryDrugsScreen extends StatefulWidget {
  static const routeName = '/category-drugs';

  @override
  State<CategoryDrugsScreen> createState() => _CategoryDrugsScreenState();
}

class _CategoryDrugsScreenState extends State<CategoryDrugsScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Category Title',
          style: TextStyle(
              color: theme.colorScheme.primary,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(CartScreen.routeName),
            icon: Icon(
              Icons.shopping_cart,
              color: theme.colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
      body: SlideInUp(
        child: SizedBox(
          height: media.height,
          child: ListView(
            padding: const EdgeInsets.all(5),
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/Medicine.svg'),
                      const SizedBox(width: 10),
                      Text(
                        'Pills & Tablets',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const DrugList(),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/spoon and syrup.svg'),
                      const SizedBox(width: 10),
                      Text(
                        'Syrup',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const DrugList(),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/eye-dropper.svg'),
                      const SizedBox(width: 10),
                      Text(
                        'Drops',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const DrugList(),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/cream.svg'),
                      const SizedBox(width: 10),
                      Text(
                        'Cream',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const DrugList(),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/Syringe.svg'),
                      const SizedBox(width: 10),
                      Text(
                        'Syringe',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const DrugList(),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/spray-can.svg'),
                      const SizedBox(width: 10),
                      Text(
                        'Sprays',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const DrugList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
