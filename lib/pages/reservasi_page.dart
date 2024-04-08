import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mr_hotel/common/constant.dart';
import 'package:mr_hotel/providers/transaksi_provider.dart';
import 'package:mr_hotel/widgets/custom_button_auth_widget.dart';
import 'package:mr_hotel/widgets/custom_textformfield_widget.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class ReservasiPage extends StatefulWidget {
  final String idKamar, noKamar, kelasKamar, image;
  final int hargaKamar;

  const ReservasiPage({
    super.key,
    required this.idKamar,
    required this.noKamar,
    required this.hargaKamar,
    required this.kelasKamar,
    required this.image,
  });

  @override
  State<ReservasiPage> createState() => _ReservasiPageState();
}

class _ReservasiPageState extends State<ReservasiPage>
    with AfterLayoutMixin<ReservasiPage> {
  final totalBayarController = TextEditingController();

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final transaksiProvider = Provider.of<TransaksiProvider>(
      context,
      listen: false,
    );
    transaksiProvider.deleteDataReservasi();
  }

  showSnackBar(
    String message,
    Color color,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          message,
          style: primaryTextStyle.copyWith(
            color: white,
          ),
        ),
      ),
    );
  }

  navigate() {
    Navigator.of(context).pop();
  }

  bayar(TransaksiProvider transaksiProvider) async {
    if (totalBayarController.text.isNotEmpty) {
      if (int.parse(totalBayarController.text) >=
          transaksiProvider.totalBayar) {
        if (transaksiProvider.date != null) {
          if (await transaksiProvider.create(widget.idKamar)) {
            showSnackBar(
              "Berhasil Reservasi",
              Colors.green,
            );
            navigate();
          } else {
            showSnackBar(
              "Gagal Reservasi",
              Colors.red,
            );
          }
        } else {
          showSnackBar(
            "Pilih Tanggal Reservasi",
            Colors.red,
          );
        }
      } else {
        showSnackBar(
          "Saldo tidak mencukupi",
          Colors.red,
        );
      }
    } else {
      showSnackBar(
        "Isi semua data",
        Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransaksiProvider>(
      builder: (context, transaksiProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: white,
            centerTitle: true,
            title: Text(
              "Reservasi Kamar",
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(defaultPadding),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                        boxShadow: [
                          primaryShadow,
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      child: Image.network(
                        "${baseURL()}/storage/${widget.image}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Container(
                    padding: EdgeInsets.all(defaultPadding),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      boxShadow: [
                        primaryShadow,
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nomor Kamar: ${widget.noKamar}",
                          style: secondaryTextStyle,
                        ),
                        Text(
                          "Harga Kamar: Rp${formatCurrency(widget.hargaKamar)} x ${transaksiProvider.totalHari} hari",
                          style: secondaryTextStyle,
                        ),
                        Text(
                          "Kelas Kamar: ${widget.kelasKamar}",
                          style: secondaryTextStyle,
                        ),
                        Text(
                          "Biaya Admin: Rp${formatCurrency(10000)}",
                          style: secondaryTextStyle,
                        ),
                        Text(
                          "Total: Rp${formatCurrency(transaksiProvider.totalBayar)}",
                          style: secondaryTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final date = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2060),
                        saveText: "Simpan",
                        cancelText: "Batal",
                        confirmText: "Konfirmasi",
                      );

                      transaksiProvider.checkTotalHari(
                        date?.duration.inDays ?? 0,
                        widget.hargaKamar,
                      );

                      transaksiProvider.checkDateTimeRange(date);
                    },
                    child: Container(
                      padding: EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                          boxShadow: [
                            primaryShadow,
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pilih tanggal reservasi",
                            style: secondaryTextStyle,
                          ),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Icon(
                            Icons.calendar_month,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  CustomTextFormFieldWidget(
                    hintText: "Bayar",
                    label: "Bayar",
                    isPasswordField: false,
                    controller: totalBayarController,
                    type: TextInputType.number,
                    isNumber: true,
                    onTap: () {},
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  CustomButtonAuthWidget(
                    text: "Reservasi Sekarang!",
                    color: primaryColor,
                    isLoading: transaksiProvider.isLoading,
                    onPressed: () {
                      bayar(transaksiProvider);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
