import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/airline.dart';
import 'package:reservation_mobile/models/room.dart';
import 'package:reservation_mobile/provider/reservation_provider.dart';
import 'package:reservation_mobile/utils/colors.dart';
import 'package:reservation_mobile/widgets/button/button_widget.dart';

class ResAirLine extends StatelessWidget {
  const ResAirLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReservationManage>();
    List<Airline>? list = context.watch<List<Airline>?>();

    return list != null
        ? Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    Airline airline = list[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  airline.image!=null ?'${airline.image}' : imageHolder,
                                  height: 45,
                                  width: 45,
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                '${airline.name}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              height: 45,
                              width: 100,
                              child: ButtonWidget(
                                Text(
                                  provider.reservation.airLineId != null &&
                                          provider.reservation.airLineId == airline.id
                                      ? 'SELECTED'
                                      : 'SELECT',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                isExpanded: true,
                                color: provider.reservation.airLineId != null &&
                                        provider.reservation.airLineId == airline.id
                                    ? Colors.black38
                                    : Colors.black,
                                fun: () {
                                  if (provider.reservation.airLineId != null &&
                                      provider.reservation.airLineId == airline.id) {
                                  } else {
                                    provider.updateAirline(airline.id!);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  },
                  itemCount: list.length,
                ),
            ),
            ButtonWidget(
              const Text(
                'Continue',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              isExpanded: true,
              color: xColors.mainColor,
              fun: () {
                if (provider.reservation.airLineId !=null ) {
                  provider.goTo(6);
                }else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                      "You must select Airline",
                    ),
                    action: SnackBarAction(
                      textColor: Colors.white,
                      label: 'i understand',
                      onPressed: () {},
                    ),
                  ));
                }
              },
            ),
          ],
        )
        : const SizedBox();
  }
}
