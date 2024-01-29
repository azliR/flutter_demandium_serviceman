import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';


class CartServiceWidget extends StatelessWidget {
  final CartModel? cart;
  final int cartIndex;

  const CartServiceWidget({
    super.key,
    required this.cart,
    required this.cartIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingEditController>(builder: (bookingEditController){
      return Container(
        height: 80.0, decoration: BoxDecoration(color: Theme.of(context).colorScheme.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
      ),
        child: Stack(alignment: Alignment.center, clipBehavior: Clip.antiAliasWithSaveLayer, children: [

          Positioned(
            right: Get.find<LocalizationController>().isLtr ? 22 : null,
            left: Get.find<LocalizationController>().isLtr ? null : 22,
            child: Image.asset(Images.servicemanDelete, width: 22.0),
          ),


          bookingEditController.cartList.length > 1 ?
          Dismissible(key: UniqueKey(),
            onDismissed: (DismissDirection direction) => bookingEditController.removeCartItem(cartIndex),
            child: CartItemView(bookingEditController: bookingEditController, cart: cart, cartIndex: cartIndex,),
          ) : CartItemView(bookingEditController: bookingEditController, cart: cart, cartIndex: cartIndex,),

        ]),
      );
    });
  }
}

class CartItemView extends StatelessWidget {
  final BookingEditController bookingEditController;
  final CartModel? cart;
  final int cartIndex;
  const CartItemView({Key? key, required this.bookingEditController, this.cart, required this.cartIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor, border: Border.all(color: Colors.white.withOpacity(.2)),
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall), boxShadow: shadow
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          child: SizedBox(
            width: ResponsiveHelper.isMobile(context) ? Get.width / 1.8 : Get.width / 4,
            child: Row( children: [
              const SizedBox(width: Dimensions.paddingSizeSmall),

              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                child: CustomImage(
                  image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}/service/${cart?.serviceThumbnail}',
                  height: 65, width: 70, fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded( child: Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text( cart?.serviceName ?? "",
                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                SizedBox( width: Get.width * 0.4,
                  child: Text( cart?.variantKey ?? "",
                    style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                        fontSize: Dimensions.fontSizeDefault), maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5),
                Directionality( textDirection: TextDirection.ltr,
                  child: Text( PriceConverter.convertPrice(double.tryParse(cart?.totalCost?.toString() ?? "0")),
                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),
                  ),
                ),
                const SizedBox(height: 5),
              ]),
              ),
            ]),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Row(children: [
            if (cart!.quantity! > 1)
              QuantityButton(
                onTap: () {
                  bookingEditController.updateCartItemQuantity( cart!, cartIndex, increment: false);
                },
                isIncrement: false,
              ),
            if (cart!.quantity == 1 && bookingEditController.cartList.length > 1)
              InkWell(
                onTap: () {
                  Get.dialog(
                    ConfirmationDialog(icon: Images.servicemanDelete, description: 'are_you_sure_to_delete_this_service'.tr,
                        isLogOut: true,
                        onYesPressed: () {
                          bookingEditController.removeCartItem(cartIndex);
                          Get.back();
                        }),
                    useSafeArea: false,
                  );
                },
                child: Container(
                  height: 22, width: 22,
                  margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Icon(Icons.delete_forever,color: Theme.of(context).colorScheme.error,),
                ),
              ),
            Text(cart!.quantity.toString(),
                style: ubuntuMedium.copyWith(
                    fontSize: Dimensions.fontSizeExtraLarge)),
            QuantityButton(
              onTap: () {
                bookingEditController.updateCartItemQuantity( cart!, cartIndex, increment: true);
              },
              isIncrement: true,
            ),
          ]),
        ),
      ]),
    );
  }
}
