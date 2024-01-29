import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';
import 'package:demandium_serviceman/feature/profile/view/account_info.dart';
import 'package:demandium_serviceman/feature/profile/view/general_info.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({Key? key}) : super(key: key);
  @override
  State<ProfileInformationScreen> createState() => _ProfileInformationScreenState();
}
class _ProfileInformationScreenState extends State<ProfileInformationScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<ProfileController>().pickImage(removePickedProfileImage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: "profile_information".tr),
      body:  DefaultTabController(
        length: 2,
        child: GetBuilder<ProfileController>(
          builder: (controller){
            return Column(
              children: [
                const SizedBox(height: Dimensions.paddingSizeDefault,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Theme.of(context).primaryColor))),
                  child: TabBar(
                    isScrollable: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: controller.tabController,
                    indicatorColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    tabs: [
                      SizedBox(height: 40,width: MediaQuery.of(context).size.width*.4,
                          child:  Center(child: Text("general_info".tr))
                      ),
                      SizedBox(height: 40,width: MediaQuery.of(context).size.width*.4,
                          child:  Center(child: Text("account_info".tr))
                      ),
                    ],

                    onTap: (int index) {
                      switch (index) {
                        case 0:
                          controller.updatePageCurrentState(EditProfileTabControllerState.generalInfo);
                          break;
                        case 1:
                          controller.updatePageCurrentState(EditProfileTabControllerState.accountIno);
                          break;
                      }
                    }),
                ),

                const Expanded(
                  child: TabBarView(children: [
                    GeneralInfo(),
                    AccountInfo()
                  ]),
                )
              ],
            );
            },
        )
      ),
    );
  }
}
