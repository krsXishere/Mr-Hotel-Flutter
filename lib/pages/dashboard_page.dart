import 'package:flutter/material.dart';
import 'package:mr_hotel/pages/reservasi_page.dart';
import 'package:mr_hotel/providers/kamar_provider.dart';
import 'package:mr_hotel/providers/user_provider.dart';
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

    Provider.of<UserProvider>(
      context,
      listen: false,
    ).user();
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
                ?
                // ListView.builder(
                //     itemCount: kamarProvider.kamars.length,
                //     itemBuilder: (context, index) {
                //       final kamar = kamarProvider.kamars[index];

                //       return ListTile(
                //         title: Text(
                //           "${kamar.noKamar.toString()} | ${kamar.kelasKamar}",
                //           style: secondaryTextStyle.copyWith(
                //             fontWeight: medium,
                //           ),
                //         ),
                //         subtitle: Text(
                //           "Rp${formatCurrency(kamar.hargaKamar)}",
                //           style: secondaryTextStyle.copyWith(
                //             fontWeight: regular,
                //           ),
                //         ),
                //         trailing: ElevatedButton(
                //           style: ElevatedButton.styleFrom(
                //             shape: RoundedRectangleBorder(
                //               borderRadius:
                //                   BorderRadius.circular(defaultBorderRadius),
                //             ),
                //             backgroundColor: primaryColor,
                //           ),
                //           onPressed: () {
                //             Navigator.of(context)
                //                 .push(
                //               PageTransition(
                //                 child: ReservasiPage(
                //                   idKamar: kamar.id.toString(),
                //                   noKamar: kamar.noKamar.toString(),
                //                   kelasKamar: kamar.kelasKamar.toString(),
                //                   hargaKamar: kamar.hargaKamar ?? 0,
                //                   image: kamar.image.toString(),
                //                 ),
                //                 type: PageTransitionType.rightToLeft,
                //               ),
                //             )
                //                 .then((value) {
                //               kamarProvider.kamar();
                //             });
                //           },
                //           child: Text(
                //             "Reservasi",
                //             style: primaryTextStyle,
                //           ),
                //         ),
                //       );
                //     },
                //   )
                GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: kamarProvider.kamars.length,
                    itemBuilder: (context, index) {
                      final kamar = kamarProvider.kamars[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(
                            PageTransition(
                              child: ReservasiPage(
                                idKamar: kamar.id.toString(),
                                noKamar: kamar.noKamar.toString(),
                                kelasKamar: kamar.kelasKamar.toString(),
                                hargaKamar: kamar.hargaKamar ?? 0,
                                image: kamar.image.toString(),
                                tag: kamar.id.toString(),
                              ),
                              type: PageTransitionType.rightToLeft,
                            ),
                          )
                              .then((value) {
                            kamarProvider.kamar();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(
                                  defaultBorderRadius,
                                ),
                                boxShadow: [
                                  primaryShadow,
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    height: height(context) * 0.1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          defaultBorderRadius),
                                      child: Hero(
                                        tag: kamar.id.toString(),
                                        child: Image.network(
                                          "${baseImageURL()}/${kamar.image}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Kamar ${kamar.noKamar}",
                                  style: secondaryTextStyle.copyWith(
                                    fontWeight: bold,
                                  ),
                                ),
                                Text(
                                  "Kelas ${kamar.kelasKamar}",
                                  style: secondaryTextStyle.copyWith(),
                                ),
                                Text(
                                  "Rp${formatCurrency(kamar.hargaKamar)}",
                                  style: secondaryTextStyle.copyWith(),
                                ),
                              ],
                            ),
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
