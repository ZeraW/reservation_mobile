
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/hotel.dart';
import 'package:reservation_mobile/models/room.dart';
import 'package:reservation_mobile/provider/reservation_provider.dart';
import 'package:reservation_mobile/server/firebase/room_api.dart';
import 'package:reservation_mobile/utils/colors.dart';
import 'package:reservation_mobile/widgets/button/button_widget.dart';

class ResRoom extends StatelessWidget {
  const ResRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReservationManage>();

    return StreamBuilder<List<Room>?>(
      stream: RoomApi().getLiveData(provider.reservation.hotelId!),
      builder: (context, snapshot) {
        List<Room>? list = snapshot.data;
        return list!=null ?Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Room room = list[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${room.name}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          room.image!=null ? room.image! :imageHolder,
                          width: double.infinity,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Information',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17,color: Colors.black.withOpacity(0.78)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${room.description}',maxLines: 2,style: TextStyle(color: Colors.black.withOpacity(0.70)),),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('${room.price} L.E',style: TextStyle(color: Colors.black.withOpacity(0.70)),),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 45,
                              child: ButtonWidget(
                                Text(
                                  provider.reservation.roomsAndCount!.isNotEmpty &&  provider.reservation.roomsAndCount!.containsKey(room.id)? 'SELECTED':'SELECT',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                isExpanded: true,
                                color: provider.reservation.roomsAndCount!.isNotEmpty &&  provider.reservation.roomsAndCount!.containsKey(room.id)? Colors.black38: Colors.black,
                                fun: () {
                                  if(provider.reservation.roomsAndCount!.isNotEmpty &&  provider.reservation.roomsAndCount!.containsKey(room.id)){

                                  }else{
                                    provider.updateRoomsAndCount(room.id!,1, room.price!);

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
                      provider.reservation.roomsAndCount!.isNotEmpty &&  provider.reservation.roomsAndCount!.containsKey(room.id)?
                      CountWidget(add: (){
                        provider.updateRoomsAndCount(room.id!, provider.reservation.roomsAndCount![room.id]!+1, room.price!);
                      },count: '${provider.reservation.roomsAndCount![room.id]}',remove:(){
                        provider.updateRoomsAndCount(room.id!, provider.reservation.roomsAndCount![room.id]!-1, room.price!);
                      } ,):const SizedBox(),
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
                if (provider.reservation.roomsAndCount!.isNotEmpty ) {
                  provider.goTo(5);
                }else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                      "You must select a room",
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
        ):SizedBox();
      }
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
            padding: const EdgeInsets.all(2),
            child: const Icon(Icons.remove),
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(333)),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(5),
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
            padding: const EdgeInsets.all(2),
            child: const Icon(Icons.add),
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(333)),
          ),
        )
      ],
    );
  }
}
