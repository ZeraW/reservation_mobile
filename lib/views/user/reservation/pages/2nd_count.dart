import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/provider/reservation_provider.dart';
import 'package:reservation_mobile/utils/colors.dart';
import 'package:reservation_mobile/widgets/button/button_widget.dart';

class ResCount extends StatelessWidget {
  const ResCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReservationManage>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'No. Of Adults Travelers',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Children above 5 counts as adults',
          style: TextStyle(
              color: Colors.black.withOpacity(0.70),
              fontWeight: FontWeight.bold,
              fontSize: 17),
        ),
        const SizedBox(
          height: 40,
        ),
        CountWidget(
            add: () {
              if (provider.reservation.capacity != null) {
                provider.reservation.capacity! < provider.maxCount
                    ? provider.updateCount(provider.reservation.capacity! + 1)
                    : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text(
                          "You've reached the maximum amount",
                        ),
                        action: SnackBarAction(
                          textColor: Colors.white,
                          label: 'ok',
                          onPressed: () {},
                        ),
                      ));
              } else {
                if (provider.maxCount == 1) {
                  provider.updateCount(1);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                      "You've reached the maximum amount",
                    ),
                    action: SnackBarAction(
                      textColor: Colors.white,
                      label: 'ok',
                      onPressed: () {},
                    ),
                  ));
                } else {
                  provider.updateCount(2);
                }
              }
            },
            remove: () {
              provider.reservation.capacity != null &&
                      provider.reservation.capacity != 1
                  ? provider.updateCount(provider.reservation.capacity! - 1)
                  : provider.updateCount(1);
            },
            count: '${provider.reservation.capacity ?? '1'}'),
        const Spacer(),
        ButtonWidget(
          const Text(
            'Continue',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          isExpanded: true,
          color: xColors.mainColor,
          fun: () {
            if (provider.reservation.capacity == null) {
              provider.updateCount(1);
            }

            provider.goTo(3);
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class CountWidget extends StatelessWidget {
  final String count;
  final Function() add, remove;

  const CountWidget(
      {required this.count, required this.add, required this.remove, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: remove,
          child: Container(
            padding: const EdgeInsets.all(5),
            child: const Icon(Icons.remove),
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(333)),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(8),
            child: Center(
                child: Text(
              count,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            )),
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(10)),
          ),
        ),
        GestureDetector(
          onTap: add,
          child: Container(
            padding: const EdgeInsets.all(5),
            child: const Icon(Icons.add),
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(333)),
          ),
        )
      ],
    );
  }
}
