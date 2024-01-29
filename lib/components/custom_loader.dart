
import 'package:demandium_serviceman/core/core_export.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Theme.of(context).primaryColorLight.withOpacity(0.6),)));
  }
}
