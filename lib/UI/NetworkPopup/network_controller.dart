import 'package:celebrity_quiz/Infrastructure/Commons/Constant/export.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController{
  RxBool outOfNetwork = false.obs;
  StreamSubscription? internetconnection;

  @override
  void onInit() {
    super.onInit();
    checkInternet();
  }

  checkInternet()async{
    internetconnection  = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.none){
        outOfNetwork.value = true;
      }else {
        outOfNetwork.value = false;
      }
    });
    update();
  }
}