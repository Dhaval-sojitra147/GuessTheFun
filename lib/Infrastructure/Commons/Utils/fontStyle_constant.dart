import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class TextStyleConstant {
  static TextStyle textBold32({Color? color}) {
    TextStyle textStyle;
    return textStyle = TextStyle(
      overflow: TextOverflow.ellipsis,
      color: color ?? ColorConstants.black,
      fontSize: Get.width * 0.082,
      fontFamily: "OdudaBold",
    );
  }

  static TextStyle textBold28({Color? color,Shadow? shadow}) {
    TextStyle textStyle;
    return textStyle = TextStyle(
      // overflow: TextOverflow.ellipsis,
      color: color ?? ColorConstants.black,
      fontSize: Get.width * 0.071,
      fontFamily: "OdudaBold",
      shadows: [
        shadow ?? Shadow(),
      ],
    );
  }

  static TextStyle textBold26({Color? color,Shadow? shadow}) {
    TextStyle textStyle;
    return textStyle = TextStyle(
      height: 1,
      // overflow: TextOverflow.ellipsis,
      color: color ?? ColorConstants.black,
      fontSize: Get.width <  800 ? Get.width * 0.066 : Get.width * 0.033,
      shadows: [
        shadow ?? Shadow(),
      ],
      fontFamily: "OdudaBold",
    );
  }

  static TextStyle textBold24({Color? color,Shadow? shadow}) {
    TextStyle textStyle;
    return textStyle = TextStyle(
      // overflow: TextOverflow.ellipsis,
      color: color ?? ColorConstants.black,
      fontSize: Get.width * 0.061,
      height: 1,
      shadows: [
        shadow ?? Shadow(),
      ],

      fontFamily: "OdudaBold",
    );
  }

  static TextStyle textBold22({Color? color,Shadow? shadow}) {
    TextStyle textStyle;
    return textStyle = TextStyle(
      color: color ?? ColorConstants.black,
      fontSize: Get.width * 0.056,
      fontFamily: "OdudaBold",
      shadows: [
        shadow ?? Shadow(),
      ],
    );
  }

  static TextStyle textBold20({Color? color,Shadow? shadow}) {
    TextStyle textStyle;
    return textStyle = TextStyle(
      color: color ?? ColorConstants.black,
      fontSize: Get.width * 0.051,
      fontFamily: "OdudaBold",
      shadows: [
        shadow ?? Shadow(),
      ],
    );
  }

  static TextStyle textBold18({Color? color,Shadow? shadow}) {
    TextStyle textStyle;
    return textStyle = TextStyle(
      // overflow: TextOverflow.ellipsis,
      color: color ?? ColorConstants.black,
      fontSize: Get.width * 0.046,
      fontFamily: "OdudaBold",
      shadows: [
        shadow ?? Shadow(),
      ],
    );
  }

  static TextStyle textBold16({Color? color,Shadow? shadow}) {
    TextStyle textStyle;
    return textStyle = TextStyle(
      overflow: TextOverflow.ellipsis,
      color: color ?? ColorConstants.black,
      fontSize: Get.width * 0.041,
      fontFamily:"OdudaBold",
      shadows: [
        shadow ?? Shadow(),
      ],
    );
  }

  static TextStyle textBold14({Color? color,Shadow? shadow}) {
    TextStyle textStyle;
    return textStyle = TextStyle(
      overflow: TextOverflow.ellipsis,
      color: color ?? ColorConstants.black,
      fontSize: Get.width * 0.037,
      fontFamily: "OdudaBold",
      shadows: [
        shadow ?? Shadow(),
      ],
    );
  }

  static TextStyle textBold10({Color? color,Shadow? shadow}) {
    TextStyle textStyle;
    return textStyle = TextStyle(
      overflow: TextOverflow.ellipsis,
      color: color ?? ColorConstants.black,
      fontSize: Get.width * 0.029,
      fontFamily: "OdudaBold",
      shadows: [
        shadow ?? Shadow(),
      ],
    );
  }
 }
