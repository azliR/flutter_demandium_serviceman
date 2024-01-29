import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
        duration: const Duration(seconds: 3),
        interval: const Duration(seconds: 5), //Default value: Duration(seconds: 0)
        color: Colors.white, //Default value
        colorOpacity: 0, //Default value
        enabled: true, //Default value
        direction: const ShimmerDirection.fromLTRB(),
        child: SizedBox(
          height: context.height,
          width: context.width,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).shadowColor,


                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Container(
                                width: 200,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).shadowColor,
                                )))
                      ],
                    ),

                    const SizedBox(height: 7,),

                    Container(
                        height: 25,
                        width: context.width*.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).shadowColor,
                        )
                    )
                  ],
                ),
              );
            },
          ),
        ),

    );
  }
}