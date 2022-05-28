import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:netninja_training_session/size_config.dart';
import 'package:netninja_training_session/constants.dart';
import 'package:netninja_training_session/HomeScreen/components/IconBtnWithCounter.dart';

import 'Categories.dart';
import 'DiscountBanner.dart';
import 'HomeHeader.dart';
import 'Popular Products.dart';
import 'SearchField.dart';
import 'Special Offer.dart';


class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().initState(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenHeight(20)),
            DiscountBanner(),
            SizedBox(height: getProportionateScreenHeight(20)),
            Categories(),
            SpecialOffers(),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),

    );
  }
}




