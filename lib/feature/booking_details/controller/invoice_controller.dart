import 'dart:io';

import 'package:demandium_serviceman/core/helper/date_converter.dart';
import 'package:demandium_serviceman/feature/booking_details/controller/booking_details_controller.dart';
import 'package:demandium_serviceman/feature/booking_details/controller/pdf_controller.dart';
import 'package:demandium_serviceman/feature/booking_details/model/booking_details_model.dart';
import 'package:demandium_serviceman/feature/booking_details/model/invoice.dart';
import 'package:demandium_serviceman/feature/booking_details/model/supplier.dart';
import 'package:demandium_serviceman/feature/splash/controller/splash_controller.dart';
import 'package:demandium_serviceman/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/feature/booking_details/model/provider.dart' as provider;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';



class PdfInvoiceApi {
  static Future<File> generate(
      BookingDetailsContent bookingDetailsContent,
      List<InvoiceItem> items,
      BookingDetailsController controller
      ) async{
    final pdf = Document();
    pw.ImageProvider? netImage;
    if(Get.find<SplashController>().configModel.content!.logo!=null){
      try{
        netImage = await networkImage('${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
            '/business/${Get.find<SplashController>().configModel.content!.logo}');
      }catch(e){
        netImage=null;
      }
    }else{
      netImage=null;
    }

    final date = DateTime.now();

    var invoice = Invoice(
      provider: provider.Provider(
        name: bookingDetailsContent.provider!.companyName!,
        address: bookingDetailsContent.provider!.companyAddress!,
      ),
      info: InvoiceInfo(
        date: date,
        description: 'Payment Status : ',
        number: bookingDetailsContent.readableId.toString(),
        paymentStatus: bookingDetailsContent.isPaid == 0 ?"Unpaid": 'Paid',
      ),
      items: items,
    );



    pdf.addPage(MultiPage(
      build: (context) => [
        companyImage(netImage,bookingDetailsContent,invoice),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        buildHeader(invoice,bookingDetailsContent),
        SizedBox(height: 1 * PdfPageFormat.cm),
        //buildTitle(invoice),
        buildInvoice(invoice),
        SizedBox(height: 0.4 * PdfPageFormat.cm),
        buildTotal(bookingDetailsContent,controller),
      ],
      pageFormat: PdfPageFormat.a4.copyWith(marginBottom: 1.5 *PdfPageFormat.cm,marginLeft: 1.5 *PdfPageFormat.cm,marginRight: 1.5 *PdfPageFormat.cm),
      footer: (context) => buildFooter(bookingDetailsContent),
    ));

    return PdfApi.saveDocument(name: 'invoice_${bookingDetailsContent.readableId}.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice,BookingDetailsContent bookingDetailsContent) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildCustomerAddress(bookingDetailsContent),
          buildInvoiceInfo(invoice.info,bookingDetailsContent),
        ],
      ),
    ],
  );

  static Widget companyImage(var netImage,BookingDetailsContent bookingDetailsContent,Invoice invoice) {
    return Column(
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
              children: [
                Container(width: 140,
                  height: 140,
                  child: pw.Image(netImage),),
              ]
          ),


        ]
    );
  }

  static Widget buildCustomerAddress(BookingDetailsContent bookingDetailsContent) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Invoice Number # ${bookingDetailsContent.readableId!}',
          style: TextStyle(fontWeight: pw.FontWeight.bold,fontSize: 16,)
      ),
      SizedBox(height: 0.5 * PdfPageFormat.cm),
      if(bookingDetailsContent.customer!=null)
      Text('Service Address',style: pw.TextStyle(fontSize: 14,fontWeight: pw.FontWeight.bold)),
      SizedBox(height: 2 * PdfPageFormat.mm),
      if(bookingDetailsContent.customer!=null)
        Text('Customer Name: ${bookingDetailsContent.customer!.firstName} ${bookingDetailsContent.customer!.lastName!}',
        ),
      SizedBox(height: 1 * PdfPageFormat.mm),
      if(bookingDetailsContent.customer!=null && bookingDetailsContent.customer!.email!=null)
        Text('Email: ${bookingDetailsContent.customer!.email}'),
      SizedBox(height: 1 * PdfPageFormat.mm),
      if(bookingDetailsContent.customer!=null && bookingDetailsContent.customer!.phone!=null)
        Text('Phone: ${bookingDetailsContent.customer!.phone}'),
      SizedBox(height: 1 * PdfPageFormat.mm),
      if(bookingDetailsContent.serviceAddress!=null)
        SizedBox(
          width: Get.width*.4,
          child: Text('Address: ${bookingDetailsContent.serviceAddress!=null?bookingDetailsContent.serviceAddress!.address:""}',),),

      SizedBox(height: 4 * PdfPageFormat.mm),
      Text("Payment Status: ${bookingDetailsContent.partialPayments != null && bookingDetailsContent.partialPayments!.isNotEmpty && bookingDetailsContent.isPaid == 0 ? "Partially paid" :bookingDetailsContent.isPaid.toString()=='0'?'Unpaid':'Paid'}",
          style: pw.TextStyle(fontSize: 14,fontWeight: pw.FontWeight.bold)
      )
    ],
  );

  static Widget buildInvoiceInfo(InvoiceInfo info,BookingDetailsContent bookingDetailsContent) {

    final data = <String>[
      DateConverter.dateStringMonthYear(info.date),
      info.paymentStatus,
    ];

    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Booking Date: ${data[0]}'),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          if(bookingDetailsContent.serviceman!=null)
            Text('Serviceman Details',style: pw.TextStyle(fontSize: 14,fontWeight: pw.FontWeight.bold)),
          if(bookingDetailsContent.serviceman!=null)
            SizedBox(height: 1 * PdfPageFormat.mm),
          if(bookingDetailsContent.serviceman!=null && bookingDetailsContent.serviceman!.user!=null)
            Text("${bookingDetailsContent.serviceman!.user!.firstName} ${bookingDetailsContent.serviceman!.user!.lastName!}"
            ),
          SizedBox(height: 1 * PdfPageFormat.mm),
          if(bookingDetailsContent.serviceman!=null && bookingDetailsContent.serviceman!.user!.phone!=null)
            Text("${bookingDetailsContent.serviceman!.user!.phone}"
            ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Text('Provider Details',style: pw.TextStyle(fontSize: 14,fontWeight: pw.FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          if(bookingDetailsContent.provider!=null && bookingDetailsContent.provider!.companyName!=null)
            Text('${bookingDetailsContent.provider!.companyName}',
            ),
          SizedBox(height: 1 * PdfPageFormat.mm),
          if(bookingDetailsContent.provider!=null && bookingDetailsContent.provider!.companyPhone!=null)
            Text('${bookingDetailsContent.provider!.companyPhone}',
            ),
          SizedBox(height: 1 * PdfPageFormat.mm),
          if(bookingDetailsContent.provider!=null && bookingDetailsContent.provider!.companyAddress!=null)
            Text('${bookingDetailsContent.provider!.companyAddress}',
            ),
        ]
    );
  }


  static Widget buildSupplierAddress(Supplier supplier) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 1 * PdfPageFormat.mm),
      Text(supplier.address),
    ],
  );

  static Widget buildTitle(Invoice invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'INVOICE',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 1 * PdfPageFormat.cm),

    ],
  );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Description',
      'Unit Price',
      'Quantity',
      'Discount',
      'Tax',
      'Total',
    ];
    final data = invoice.items.map((item) {
      return [
        item.serviceName,
        item.unitPrice,
        item.quantity,
        item.discountAmount,
        item.tax,
        item.unitAllTotal,
      ];
    }).toList();

    return TableHelper.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerPadding: const EdgeInsets.symmetric(horizontal: 10),
      headerStyle: TextStyle(fontWeight: FontWeight.bold,color: PdfColor.fromHex("f2f2f2")),
      rowDecoration: const BoxDecoration(
        color: PdfColors.grey100,
      ),
      headerDecoration: BoxDecoration(
        color: PdfColor.fromHex("4153b3"),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
      ),
      cellHeight: 30,
      columnWidths: {
        0: FixedColumnWidth(Get.width / 4),
      },
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(BookingDetailsContent bookingDetailsContent,BookingDetailsController controller) {

    double paidAmount = 0;

    double totalBookingAmount = bookingDetailsContent.totalBookingAmount ?? 0;
    bool isPartialPayment = bookingDetailsContent.partialPayments !=null && bookingDetailsContent.partialPayments!.isNotEmpty;

    if(isPartialPayment) {
      bookingDetailsContent.partialPayments?.forEach((element) {
        paidAmount = paidAmount + (element.paidAmount ?? 0);
      });
    }else{
      paidAmount  = totalBookingAmount - (bookingDetailsContent.additionalCharge ?? 0);
    }
    double dueAmount = totalBookingAmount - paidAmount;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Sub Total(VAT excluded)',
                  value: controller.allTotalCost.toString(),
                  unite: true,
                ),
                buildText(
                  title: 'Total discount',
                  value: "(-) ${controller.totalDiscountWithCoupon.toStringAsFixed(2)}",
                  unite: true,
                ),
                if(bookingDetailsContent.extraFee != null && bookingDetailsContent.extraFee! > 0)
                  buildText(
                    title: Get.find<SplashController>().configModel.content?.additionalChargeLabelName ??"",
                    value: "(+) ${bookingDetailsContent.extraFee?.toStringAsFixed(2)}",
                    unite: true,
                  ),

                buildText(
                  title: 'Tax',
                  value: "(+) ${bookingDetailsContent.totalTaxAmount?.toStringAsFixed(2)??"0"}",
                  unite: true,
                ),
                Divider(),
                bookingDetailsContent.partialPayments != null && bookingDetailsContent.partialPayments!.isNotEmpty ?
                Column(children: [
                  buildText(
                    title: 'Grand Total',
                    titleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    value: double.tryParse(controller.bookingDetailsContent!.totalBookingAmount.toString())!.toStringAsFixed(2),
                    unite: true,
                  ),
                  ListView.builder(itemBuilder: (context, index){

                    String paidWith = bookingDetailsContent.partialPayments?[index].paidWith ?? "";

                    return buildText(
                        title: '${paidWith == "digital" && bookingDetailsContent.paymentMethod == "offline_payment" ? ""  : (paidWith == "wallet" || paidWith == "digital")  ? "Paid by '"  : ""}'
                            '${ paidWith == "digital" && bookingDetailsContent.paymentMethod =="offline_payment" ? "Offline Payment" : paidWith == "digital" ? bookingDetailsContent.paymentMethod :  paidWith =="wallet" ? "wallet" : "Cash After Service" }',
                        value: bookingDetailsContent.partialPayments?[index].paidAmount.toString() ?? "0"
                    );
                  },
                    itemCount: bookingDetailsContent.partialPayments!.length,
                  ),
                  bookingDetailsContent.partialPayments?.length == 1 &&  dueAmount > 0?
                  buildText(
                      title: "Due amount (Cash after service)", value: "$dueAmount"
                  )  : SizedBox(),



                  if(bookingDetailsContent.additionalCharge !=0 && bookingDetailsContent.paymentMethod != "cash_after_service")
                    buildText(
                      title:  bookingDetailsContent.additionalCharge != null
                          && bookingDetailsContent.additionalCharge! > 0 ? (bookingDetailsContent.bookingStatus == "pending" || bookingDetailsContent.bookingStatus == "accepted" || bookingDetailsContent.bookingStatus == "ongoing") ?'Due Amount (Cash after service)' : "Paid Amount (Cash after service)"  : "Refund amount",
                      titleStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                      value: (bookingDetailsContent.additionalCharge ?? 0).toStringAsFixed(2),
                      unite: true,
                    ),

                ]):
                Column(children: [
                  buildText(
                    title: 'Grand Total',
                    titleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    value: controller.bookingDetailsContent!.totalBookingAmount!.toStringAsFixed(2),
                    unite: true,
                  ),
                  if(bookingDetailsContent.additionalCharge != null && bookingDetailsContent.additionalCharge! > 0 && bookingDetailsContent.paymentMethod != "cash_after_service")
                    Column(children: [
                      buildText(
                        title: 'Paid Amount (${bookingDetailsContent.paymentMethod =="offline_payment"? "Offline" : bookingDetailsContent.paymentMethod =="wallet_payment" ? "Wallet" : bookingDetailsContent.paymentMethod =="cash_after_service" ? "Cash After Service" : bookingDetailsContent.paymentMethod})',
                        titleStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        value: ((bookingDetailsContent.totalBookingAmount ?? 0) -(bookingDetailsContent.additionalCharge ?? 0)).toStringAsFixed(2),
                        unite: true,
                      ),
                      bookingDetailsContent.additionalCharge! > 0 ?
                      buildText(
                        title:   (bookingDetailsContent.bookingStatus == "pending" || bookingDetailsContent.bookingStatus == "accepted" || bookingDetailsContent.bookingStatus == "ongoing") ?'Due Amount (Cash after service)' : "Paid Amount (Cash after service)",
                        titleStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        value: (bookingDetailsContent.additionalCharge ?? 0).toStringAsFixed(2),
                        unite: true,
                      ): SizedBox(),

                    ])
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(BookingDetailsContent bookingDetailsContent) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text
            (
              'If you require any assistance or have feedback or suggestions about our site, you\n can email us or call us.',
              textAlign: TextAlign.center
          ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Container(
              decoration: BoxDecoration(
                  color: PdfColor.fromHex("f2f2f2")
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(),
                  SizedBox(height: 1 * PdfPageFormat.mm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildSimpleText(title: '', value: Get.find<SplashController>().configModel.content?.businessPhone??""),
                      SizedBox(height: 6 * PdfPageFormat.mm),
                      buildSimpleText(title: '', value: Get.find<SplashController>().configModel.content?.businessEmail??""),
                    ],),
                  SizedBox(height: 1 * PdfPageFormat.mm),
                  Text(AppConstants.baseUrl),
                  SizedBox(height: 1 * PdfPageFormat.mm),
                  buildSimpleText(title: '', value: Get.find<SplashController>().configModel.content?.footerText??""),
                  SizedBox(height: 4 * PdfPageFormat.mm),
                ],
              )
          )
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
