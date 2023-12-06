import 'package:drugdrop/providers/categories_provider.dart';
import 'package:drugdrop/providers/drugs_provider.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

import '../widgets/drugs_list.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryDrugsScreen extends StatefulWidget {
  static const routeName = '/category-drugs';

  @override
  State<CategoryDrugsScreen> createState() => _CategoryDrugsScreenState();
}

class _CategoryDrugsScreenState extends State<CategoryDrugsScreen> {
  var catId = 1;
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      Provider.of<DrugsProvider>(context, listen: false)
          .fetchAndSetDrugs(catId)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    var media = MediaQuery.of(context).size;
    catId = ModalRoute.of(context)!.settings.arguments as int; // is the id!
    final loadedCategory =
        Provider.of<CategoriesProvider>(context, listen: false).findById(catId);
    // final categoryData = Provider.of<CategoriesProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loadedCategory.name,
          style: TextStyle(
              color: theme.primary,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: theme.primary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: theme.primary,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.35,
                  horizontal: MediaQuery.of(context).size.width * 0.32),
              child: LiquidCircularProgressIndicator(
                value: 0.4,
                backgroundColor: theme.secondary,
                valueColor: AlwaysStoppedAnimation(theme.primary),
                center: Text(
                  "Loading...",
                  style: TextStyle(color: theme.primary),
                ),
              ),
            )
          : SlideInUp(
              child: Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 20),
                height: media.height,
                child: ListView(
                  //padding: const EdgeInsets.all(5),
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/images/Medicine.svg'),
                              const SizedBox(width: 15),
                              Text(
                                'Pills & Tablets',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: theme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DrugList(),
                      ],
                    ),
                    Divider(),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                  'assets/images/spoon and syrup.svg'),
                              const SizedBox(width: 15),
                              Text(
                                'Syrup',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: theme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DrugList(),
                      ],
                    ),
                    Divider(),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/images/eye-dropper.svg'),
                              const SizedBox(width: 15),
                              Text(
                                'Drops',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: theme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DrugList(),
                      ],
                    ),
                    Divider(),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/images/cream.svg'),
                              const SizedBox(width: 15),
                              Text(
                                'Cream',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: theme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DrugList(),
                      ],
                    ),
                    Divider(),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/images/Syringe.svg'),
                              const SizedBox(width: 15),
                              Text(
                                'Syringe',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: theme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DrugList(),
                      ],
                    ),
                    Divider(),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/images/spray-can.svg'),
                              const SizedBox(width: 15),
                              Text(
                                'Sprays',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: theme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DrugList(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
