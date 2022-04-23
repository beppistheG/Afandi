import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:netninja_training_session/size_config.dart';
import 'package:netninja_training_session/constants.dart';



class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key,
    required this.svgSrc,
    this.numOfItems=0,
    required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfItems;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        clipBehavior: Clip.none, children: [
        Container(
          padding: EdgeInsets.all(getProportionateScreenWidth(12)),
          height: getProportionateScreenWidth(46),
          width: getProportionateScreenWidth(46),
          decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              shape: BoxShape.circle
          ),
          child: SvgPicture.asset(svgSrc),
        ),
        if(numOfItems != 0)
          Positioned( ///this is for the notifications
            top: -3,
            right: 0,
            child: Container(
              height: getProportionateScreenHeight(16),
              width: getProportionateScreenWidth(16),
              decoration: const BoxDecoration(
                  color: Color(0xFFFF4848), shape: BoxShape.circle
              ),
              child: Center(
                child: Text(" $numOfItems", style: TextStyle(
                    fontSize: getProportionateScreenWidth(10),height: 1,color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          )
      ],
      ),
    );
  }
}
