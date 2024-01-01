import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';
import '../providers/tags_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/drug_card.dart';

class SeeAllScreen extends StatefulWidget {
  static const routeName = '/see-all';

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  bool _isInit = false;
  bool _isLoading = false;
  late final tagId = ModalRoute.of(context)?.settings.arguments as int;

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      setState(() => _isLoading = true);
      await Provider.of<TagsProvider>(context).fetchAndSetTags(tagId);
      setState(() => _isLoading = false);
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final tag =
        Provider.of<TagsProvider>(context).findTagById(tagId.toString());
    final drugs = tag.drugs;

    return Scaffold(
      appBar: AppBar(
        title: Text(tag.name),
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              backgroundColor: Colors.transparent,
              offset: const Offset(-2, 4),
              label: Text(cart.items.length.toString()),
              child: ch,
            ),
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemBuilder: (_, index) => DrugCard(
                drugs[index].id,
                drugs[index].tradeName,
                drugs[index].price,
                drugs[index].imageUrl,
                drugs[index].isFavorite,
              ),
              itemCount: drugs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
    );
  }
}
