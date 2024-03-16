import 'package:flutter/material.dart';
import 'package:mr_hotel/pages/reservasi_page.dart';
import 'package:mr_hotel/providers/kamar_provider.dart';
import 'package:mr_hotel/widgets/empty_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../common/constant.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<void> getData() async {
    Provider.of<KamarProvider>(
      context,
      listen: false,
    ).kamar();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });

    return Consumer<KamarProvider>(
      builder: (context, kamarProvider, child) {
        return Scaffold(
          body: SafeArea(
            child: kamarProvider.kamars.isNotEmpty
                ? ListView.builder(
                    itemCount: kamarProvider.kamars.length,
                    itemBuilder: (context, index) {
                      final kamar = kamarProvider.kamars[index];

                      return ListTile(
                        title: Text(
                          "${kamar.noKamar.toString()} | ${kamar.kelasKamar}",
                          style: secondaryTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                        subtitle: Text(
                          "Rp${formatCurrency(kamar.hargaKamar)}",
                          style: secondaryTextStyle.copyWith(
                            fontWeight: regular,
                          ),
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                            ),
                            backgroundColor: primaryColor,
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(
                              PageTransition(
                                child: ReservasiPage(
                                  idKamar: kamar.id.toString(),
                                  noKamar: kamar.noKamar.toString(),
                                  kelasKamar: kamar.kelasKamar.toString(),
                                  hargaKamar: kamar.hargaKamar ?? 0,
                                ),
                                type: PageTransitionType.rightToLeft,
                              ),
                            )
                                .then((value) {
                              kamarProvider.kamar();
                            });
                          },
                          child: Text(
                            "Reservasi",
                            style: primaryTextStyle,
                          ),
                        ),
                      );
                    },
                  )
                : const EmptyWidget(title: "Kamar belum tersedia"),
          ),
        );
      },
    );
  }
}
