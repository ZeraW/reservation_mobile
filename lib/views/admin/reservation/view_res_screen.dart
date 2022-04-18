import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/reservation.dart';
import 'package:reservation_mobile/models/user.dart';
import 'package:reservation_mobile/server/firebase/reservation_api.dart';

class ViewReservationScreen extends StatefulWidget {
  static const routeName = 'view_reservation_screen';

  final String packageId;

  const ViewReservationScreen({required this.packageId, Key? key})
      : super(key: key);

  @override
  State<ViewReservationScreen> createState() => _ViewReservationScreenState();
}

class _ViewReservationScreenState extends State<ViewReservationScreen> {
  Color cardColor = Colors.grey.withOpacity(0.50);
  Color textColor = Colors.black.withOpacity(0.60);

  @override
  Widget build(BuildContext context) {
    List<UserModel>? usersList = context.watch<List<UserModel>?>();

    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: const Text(
          'Reservation',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
      ),
      body: StreamBuilder<List<Reservation>>(
          stream: ReservationApi().query(pId: widget.packageId),
          builder: (context, snapshot) {
            List<Reservation>? list = snapshot.data;

            return list != null && usersList != null
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                        child: ListTile(
                          tileColor: Colors.grey[200],
                          title: Text('Id: ${list[index].id!}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8,),
                              Text('User: ${UserModel().getUserName(list: usersList, id: list[index].userId!)}'),
                              const SizedBox(height: 4,),
                              Text('Capacity: ${list[index].capacity!}'),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: list.length,
                  )
                : const SizedBox();
          }),
    );
  }
}
