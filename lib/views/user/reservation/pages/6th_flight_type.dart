
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/models/flight_type.dart';
import 'package:reservation_mobile/provider/reservation_provider.dart';
import 'package:reservation_mobile/utils/colors.dart';
import 'package:reservation_mobile/widgets/button/button_widget.dart';

class ResFlightType extends StatelessWidget {
  const ResFlightType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReservationManage>();
    List<FlightType>? list = context.watch<List<FlightType>?>();

    return list != null
        ? Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              FlightType item = list[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item.name}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Depart at: ${DateTime.fromMillisecondsSinceEpoch(provider.reservation.departAt!).day}-'
                                      '${DateTime.fromMillisecondsSinceEpoch(provider.reservation.departAt!).month}-'
                                      '${DateTime.fromMillisecondsSinceEpoch(provider.reservation.departAt!).year} ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400, fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Return at: ${DateTime.fromMillisecondsSinceEpoch(provider.reservation.returnAt!).day}-'
                                      '${DateTime.fromMillisecondsSinceEpoch(provider.reservation.returnAt!).month}-'
                                      '${DateTime.fromMillisecondsSinceEpoch(provider.reservation.returnAt!).year} ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Depart time: '
                                      '${DateTime.fromMillisecondsSinceEpoch(provider.reservation.departAt!).hour}'
                                      ':${DateTime.fromMillisecondsSinceEpoch(provider.reservation.departAt!).minute}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400, fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Return time: '
                                      '${DateTime.fromMillisecondsSinceEpoch(provider.reservation.returnAt!).hour}'
                                      ':${DateTime.fromMillisecondsSinceEpoch(provider.reservation.returnAt!).minute}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            'Price : ${item.price} L.E',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: SizedBox(
                          height: 45,
                          width: 100,
                          child: ButtonWidget(
                            Text(
                              provider.reservation.flightTypeId != null &&
                                  provider.reservation.flightTypeId == item.id
                                  ? 'SELECTED'
                                  : 'SELECT',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            isExpanded: true,
                            color: provider.reservation.flightTypeId != null &&
                                provider.reservation.flightTypeId == item.id
                                ? Colors.black38
                                : Colors.black,
                            fun: () {
                              if (provider.reservation.flightTypeId != null &&
                                  provider.reservation.flightTypeId == item.id) {
                              } else {
                                provider.updateFlightType(item.id!,item.price!);
                              }
                            },
                          ),
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
            if (provider.reservation.flightTypeId !=null ) {
              provider.updateTotalPrice();
              provider.goTo(7);
            }else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                  "You must select Flight Type",
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
