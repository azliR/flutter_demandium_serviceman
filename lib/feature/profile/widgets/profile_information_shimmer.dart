import 'package:demandium_serviceman/core/core_export.dart';

class ProfileInfoShimmer extends StatelessWidget {
  const ProfileInfoShimmer ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 3),
      interval: const Duration(seconds: 5), //Default value: Duration(seconds: 0)
      color: Colors.white, //Default value
      colorOpacity: 0, //Default value
      enabled: true, //Default value
      direction: const ShimmerDirection.fromLTRB(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(),
            Gaps.verticalGapOf(30),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).shadowColor
              ),
            ),

            Gaps.verticalGapOf(Dimensions.paddingSizeDefault),

            ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeSmall),
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(color:Theme.of(context).shadowColor, borderRadius: BorderRadius.circular(5)),
                      child: const Row(),
                    ));
                })
          ],
        ),
      ),
    );
  }
}
