import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../services/cart_service.dart';
import 'package:provider/provider.dart';

Future<void> generateReceipt(BuildContext context) async {
  final cartProvider = Provider.of<CartProvider>(context, listen: false);
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "Black Broth App",
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),
            pw.Text("Receipt", style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 10),
            pw.Divider(),
            pw.Column(
              children:
                  cartProvider.cartItems.map((item) {
                    return pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          item.food['name'],
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          "\$${item.food['price'].toStringAsFixed(2)} x ${item.quantity}",
                        ),
                      ],
                    );
                  }).toList(),
            ),

            pw.Divider(),
            pw.SizedBox(height: 10),
            pw.Text(
              "Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}",
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              "Thank you for your purchase!",
              style: pw.TextStyle(fontSize: 14),
            ),
          ],
        );
      },
    ),
  );

  // Show Print Preview
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  ).catchError((e) {
    print("Error printing PDF: $e");
  });
}
