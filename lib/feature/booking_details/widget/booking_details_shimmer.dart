import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class BookingDetailsShimmer extends StatelessWidget {
  const BookingDetailsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Shimmer(
        duration: const Duration(seconds: 3),
        interval: const Duration(seconds: 5), //Default value: Duration(seconds: 0)
        color: Colors.white, //Default value
        colorOpacity: 0, //Default value
        enabled: true, //Default value
        direction: const ShimmerDirection.fromLTRB(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 25,
                        width: 75,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 35,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color:Theme.of(context).shadowColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      color:Theme.of(context).shadowColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 15,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      color:Theme.of(context).shadowColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      color:Theme.of(context).shadowColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 15,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      color:Theme.of(context).shadowColor,
                    ),
                  ),
                ],
              ),
            ),


            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      color:Theme.of(context).shadowColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 15,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      color:Theme.of(context).shadowColor,
                    ),
                  ),
                ],
              ),
            ),


            const SizedBox(height: 25),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 17,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      color:Theme.of(context).shadowColor,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 12,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),

                      Container(
                        height: 12,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 15,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      color:Theme.of(context).shadowColor,
                    ),
                  ),

                  const SizedBox(height: 25),
                  Container(
                    height: 15,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      color:Theme.of(context).shadowColor,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Container(
                    height: 30,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      color:Theme.of(context).shadowColor,
                    ),
                  ),


                 const SizedBox(height: 35),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           height: 12,
                           width: 150,
                           decoration: BoxDecoration(
                             borderRadius: const BorderRadius.all(Radius.circular(3)),
                             color:Theme.of(context).shadowColor,
                           ),
                         ),

                         Container(
                           height: 12,
                           width: 90,
                           decoration: BoxDecoration(
                             borderRadius: const BorderRadius.all(Radius.circular(3)),
                             color:Theme.of(context).shadowColor,
                           ),
                         ),
                       ],
                     ),
                     const SizedBox(height: 5),
                     Container(
                       height: 8,
                       width: 135,
                       decoration: BoxDecoration(
                         borderRadius: const BorderRadius.all(Radius.circular(3)),
                         color:Theme.of(context).shadowColor,
                       ),
                     ),
                     const SizedBox(height: 5),
                     Container(
                       height: 8,
                       width: 135,
                       decoration: BoxDecoration(
                         borderRadius: const BorderRadius.all(Radius.circular(3)),
                         color:Theme.of(context).shadowColor,
                       ),
                     ),
                     const SizedBox(height: 5),
                     Container(
                       height: 8,
                       width: 135,
                       decoration: BoxDecoration(
                         borderRadius: const BorderRadius.all(Radius.circular(3)),
                         color:Theme.of(context).shadowColor,
                       ),
                     ),
                     const SizedBox(height: 5),
                     Container(
                       height: 8,
                       width: 135,
                       decoration: BoxDecoration(
                         borderRadius: const BorderRadius.all(Radius.circular(3)),
                         color:Theme.of(context).shadowColor,
                       ),
                     ),
                     const SizedBox(height: 5),
                     Container(
                       height: 8,
                       width: 135,
                       decoration: BoxDecoration(
                         borderRadius: const BorderRadius.all(Radius.circular(3)),
                         color:Theme.of(context).shadowColor,
                       ),
                     ),
                     const SizedBox(height: 5),
                     Container(
                       height: 8,
                       width: 135,
                       decoration: BoxDecoration(
                         borderRadius: const BorderRadius.all(Radius.circular(3)),
                         color:Theme.of(context).shadowColor,
                       ),
                     ),
                   ],
                 ),

                  const SizedBox(height: 35),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 12,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(3)),
                              color:Theme.of(context).shadowColor,
                            ),
                          ),

                          Container(
                            height: 12,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(3)),
                              color:Theme.of(context).shadowColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 8,
                        width: 135,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 8,
                        width: 135,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 8,
                        width: 135,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 8,
                        width: 135,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 8,
                        width: 135,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 8,
                        width: 135,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Container(
                    height: 1,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      color:Theme.of(context).shadowColor,
                    ),
                  ),
                  const SizedBox(height: 5),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 12,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),

                      Container(
                        height: 12,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 12,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),

                      Container(
                        height: 12,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 12,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),

                      Container(
                        height: 12,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 12,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),

                      Container(
                        height: 12,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),
                    ],
                  ),










                ],
              ),
            )









          ]
        ),

    );
  }
}