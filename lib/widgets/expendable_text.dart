import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:furutsu_x_fruitbase/utils/colors.dart';
import 'package:furutsu_x_fruitbase/utils/dimensions.dart';
import 'package:furutsu_x_fruitbase/widgets/small_text.dart';

class ExpendableText extends StatefulWidget {
  final String text;
  const ExpendableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpendableText> createState() => _ExpendableTextState();
}

class _ExpendableTextState extends State<ExpendableText> {
  late String firsthalf;
  late String secondhalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firsthalf = widget.text.substring(0, textHeight.toInt());
      secondhalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firsthalf = widget.text;
      secondhalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondhalf.isEmpty
          ? SmallText(
              height: 1.8,
              color: AppColors.paraColor,
              size: Dimensions.font16,
              text: firsthalf)
          : Column(
              children: [
                SmallText(
                    color: AppColors.paraColor,
                    size: Dimensions.font16,
                    text: hiddenText
                        ? (firsthalf + "...")
                        : (firsthalf + secondhalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(text: "Show more", color: AppColors.mainColor),
                      Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColors.mainColor),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
