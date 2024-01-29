import 'package:flutter/material.dart';
import 'package:demandium_serviceman/utils/dimensions.dart';
import 'package:demandium_serviceman/utils/images.dart';
import 'package:demandium_serviceman/utils/styles.dart';

class NotificationDialog extends StatelessWidget{
  final String imageUrl;
  final String? title;
  final String? subTitle;
  const NotificationDialog({Key? key, required this.imageUrl,this.title,this.subTitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      title:  Align(alignment: Alignment.topRight,
        child: IconButton(icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Column(
                children: [
                  title!=null?Text(title!,style: ubuntuMedium.copyWith(color: Theme.of(context).
                  textTheme.bodyLarge!.color!.withOpacity(0.7) ,
                      fontSize: Dimensions.fontSizeDefault
                  )): const SizedBox.shrink(),

                  SizedBox(height: title!=null? Dimensions.paddingSizeDefault:0,),

                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).primaryColor.withOpacity(0.20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage.assetNetwork(
                        placeholder: Images.placeholder, image: imageUrl, fit: BoxFit.contain,
                        imageErrorBuilder: (c, o, s) => Image.asset(
                          Images.placeholder, height: MediaQuery.of(context).size.width - 130,
                          width: MediaQuery.of(context).size.width, fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: subTitle!=null? Dimensions.paddingSizeDefault:0,),
                  subTitle!=null?Text(subTitle!,style: ubuntuRegular.copyWith(color: Theme.of(context).
                  textTheme.bodyLarge!.color!.withOpacity(0.5) ,
                    fontSize: Dimensions.fontSizeDefault,
                  ),textAlign: TextAlign.justify,):const SizedBox.shrink(),

                  const SizedBox(height: Dimensions.paddingSizeDefault),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}