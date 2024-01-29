import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool centerTitle;
  final Function()? onBackPressed;
  const CustomAppBar({Key? key,required this.title,this.centerTitle= false, this.onBackPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 8,
      titleSpacing: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      shadowColor: Get.isDarkMode?Theme.of(context).primaryColor.withOpacity(0.5):Theme.of(context).primaryColor.withOpacity(0.1),
      centerTitle: centerTitle,
      title: Text(title,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).primaryColorLight),),
      leading: IconButton(
        onPressed: onBackPressed ?? (){
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).primaryColorLight,size: 20,),
      ),
    );
  }
  @override
  Size get preferredSize => const Size(double.maxFinite, 55);
}

