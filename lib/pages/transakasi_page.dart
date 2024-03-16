import 'package:flutter/material.dart';
import 'package:mr_hotel/providers/transaksi_provider.dart';
import 'package:provider/provider.dart';
import '../common/constant.dart';
import '../widgets/empty_widget.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  Future<void> getData() async {
    Provider.of<TransaksiProvider>(
      context,
      listen: false,
    ).transaksi();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });

    return Consumer<TransaksiProvider>(
      builder: (context, transaksiProvider, child) {
        return Scaffold(
          body: SafeArea(
            child: transaksiProvider.transaksis.isNotEmpty
                ? ListView.builder(
                    itemCount: transaksiProvider.transaksis.length,
                    itemBuilder: (context, index) {
                      final transaksi = transaksiProvider.transaksis[index];

                      return ListTile(
                        title: Text(
                          formatWaktu(
                            true,
                            tanggal: DateTime.parse(
                              transaksi.tanggal.toString(),
                            ),
                          ),
                          style: secondaryTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                        subtitle: Text(
                          "Rp${formatCurrency(transaksi.totalBayar)}",
                          style: secondaryTextStyle.copyWith(
                            fontWeight: regular,
                          ),
                        ),
                      );
                    },
                  )
                : const EmptyWidget(title: "Transaksi belum tersedia"),
          ),
        );
      },
    );
  }
}
