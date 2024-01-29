import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class DashboardTopCardShimmer extends StatelessWidget {
  const DashboardTopCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 3),
      interval: const Duration(seconds: 5), //Default value: Duration(seconds: 0)
      colorOpacity: 0, //Default value
      enabled: true, //Default value
      direction: const ShimmerDirection.fromLTRB(),
      child: SizedBox(
        height: context.height,
        width: context.width,
        //color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Top cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
                child: Row(
                  children: [
                    Expanded(child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).shadowColor,
                      ),
                    ),),
                    const SizedBox(width: 10,),
                    Expanded(child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).shadowColor,
                      ),
                    ),),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                width: context.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).shadowColor,
                ),

              ),
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                width: context.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).shadowColor,
                ),

              ),
              const SizedBox(height: 20),


              //Stats Section
              Container(
                height: 35,
                width: double.infinity,
                color:Theme.of(context).shadowColor,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        color:Theme.of(context).shadowColor,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).shadowColor
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 30,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).shadowColor,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  color:Theme.of(context).shadowColor,
                ),
              ),
              const SizedBox(height:10),

              Container(
                height: 35,
                width: double.infinity,
                  color: Theme.of(context).shadowColor,
              ),

              const SizedBox(height:10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color:Theme.of(context).shadowColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5))
                  ),
                ),
              ),
              const SizedBox(height:10),


            ],
          ),
        ),
      ),
    );
  }
}