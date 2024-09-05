import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class IndicatorWidget extends StatelessWidget {
  final Color indicatorColor;
  final int selectedIndex;
  LevelController levelController = Get.put(LevelController());
  IndicatorWidget(
      {Key? key, required this.indicatorColor, required this.selectedIndex,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: displayWidth(context) > 500 ?displayWidth(context)*0.21:displayWidth(context)*0.15),
      child: SizedBox(
        height: displayHeight(context) * 0.01,
        child: Center(
          child: ListView.builder(
              scrollDirection:  Axis.horizontal,
              itemCount: (levelController.levelLength/10).ceil(),
          itemBuilder: (context, index) {
          return CommonIndicator(context, index);
          },),
        ),
      ),
    );
  }

  Widget CommonIndicator(context,index){
    return Padding(
      padding: EdgeInsets.only(right: displayWidth(context)*0.03),
      child: SizedBox(
        width: selectedIndex == index ? displayWidth(context) * 0.06 : displayWidth(context) > 600 ? displayWidth(context) * 0.035 : displayWidth(context)*0.04,
        height: displayHeight(context) * 0.01,
        child: GestureDetector(
          onTap: () {
            // levelController.introController!.value.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
            // levelController.update();
          },
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 200,
              ),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? ColorConstants.white
                    : ColorConstants.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );

  }
}