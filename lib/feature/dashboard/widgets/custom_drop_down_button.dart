import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:demandium_serviceman/core/core_export.dart';

class CustomDropDownButton extends StatefulWidget {

  final List<String> itemList;
  final String type;
  final String title;

  const CustomDropDownButton({Key? key,required this.itemList,required this.type, required this.title,}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CustomDropDownButtonState();
  }
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String dropdownValue = 'Select';
  String selectedMonth = DateFormat('MMMM').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardController){
      return CustomDropDown(
          type: widget.title,
          hint:  widget.type=="Year"? dashboardController.selectedYear: selectedMonth,
          errorText: '',
          items: widget.itemList
              .map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            if(widget.type=="Month"){
              selectedMonth=value!;
              int index =  widget.itemList.indexOf(value)+1;
              dashboardController.changeDashboardDropdownValue(index.toString(),widget.type);
            }else if(widget.type=="Year"){
              dashboardController.changeDashboardDropdownValue(value!,widget.type);
            }
          }
      );
    });
  }
}


class CustomDropDown extends StatelessWidget {
  final String type;
  final String? value;
  final String? hint;
  final String? errorText;
  final List<DropdownMenuItem<String>>? items;
  final Function? onChanged;

  const CustomDropDown(
      {Key? key,
        this.value,
        this.hint,
        this.items,
        this.onChanged,
        this.errorText,
        required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            height: 30,
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
                color: Get.isDarkMode?Colors.grey.withOpacity(0.3):Colors.grey[50],
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Get.isDarkMode?Colors.grey.withOpacity(.5):Colors.blue.shade100)
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child:  Center(child: Text("$type: ",style:  TextStyle(fontSize: 12,color: Get.isDarkMode?Colors.white:Colors.black54),)),
                ),
                Expanded(
                  flex: 3,
                  child:  DropdownButton<String>(
                    dropdownColor: Theme.of(context).cardColor,
                    style:  TextStyle(fontSize: 12,color: Get.isDarkMode?Colors.grey:Colors.black54),
                    value: value,
                    hint: Text(hint!,
                      style: const TextStyle(fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: items,
                    onChanged: (item) {
                      onChanged!(item);
                    },
                    isExpanded: true,
                    underline: Container(),
                    icon: const Icon(Icons.keyboard_arrow_down,size: 15,),
                  ),
                )
              ],
            )
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Text(errorText!, style: TextStyle(fontSize: 12, color: Colors.red[800]),),
          )

      ],
    );
  }
}