import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/navigation_service.dart';
import '../../../models/room.dart';
import '../../../server/firebase/room_api.dart';
import '../../../widgets/add_pic.dart';
import '../../../widgets/button/button_widget.dart';
import '../../../widgets/textfield_widget.dart';

class EditRoomScreen extends StatefulWidget {
  static const routeName = 'edit_room_screen';
  final Room? edit;
  final List<Room>? all;
  final String hotelId;

  const EditRoomScreen({required this.hotelId, this.edit, this.all, Key? key})
      : super(key: key);

  @override
  State<EditRoomScreen> createState() => _EditRoomScreenState();
}

class _EditRoomScreenState extends State<EditRoomScreen> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameTEC = TextEditingController();
  final TextEditingController priceTEC = TextEditingController();
  final TextEditingController descTEC = TextEditingController();
  File? _storedImage;

  void save() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      String name = nameTEC.text;
      double price = double.parse(priceTEC.text);
      String desc = descTEC.text;

      if (widget.edit == null) {
        await RoomApi()
            .addData(
                add: Room(
                    name: name,
                    hotelId: widget.hotelId,
                    price: price,
                    description: desc),
                file: _storedImage)
            .then((value) {
          NavigationService.adminInstance.goBack();
        });
      } else {
        await RoomApi()
            .updateData(
                update: Room(
                    id: widget.edit?.id,
                    hotelId: widget.edit?.hotelId,
                    name: name,
                    price: price,
                    description: desc,
                    image: widget.edit?.image),
                file: _storedImage)
            .then((value) {
          NavigationService.adminInstance.goBack();
        });
      }
    } else {
      debugPrint('Form is invalid');
    }
  }

  void delete() async {
    await RoomApi().deleteData(delete: widget.edit!).then((value) {
      NavigationService.adminInstance.goBack();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit != null) {
      nameTEC.text = widget.edit!.name!;
      priceTEC.text = widget.edit!.price!.toString();
      descTEC.text = widget.edit!.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.edit != null ? 'Edit Room' : 'Add Room',
          style: const TextStyle(
            color: blackFontColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: FormBuilder(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AddPic(
                        onChange: (f) {
                          _storedImage = f;
                          setState(() {});
                        },
                        imageUrl:
                            widget.edit != null && widget.edit!.image != null
                                ? widget.edit!.image
                                : null),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormBuilder(
                      hint: "name",
                      controller: nameTEC,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter a valid name";
                        } else if (((widget.all!.firstWhere(
                                (it) =>
                                    it.name!.toLowerCase() ==
                                    value.toLowerCase(),
                                orElse: () => Room(id: null))).id !=
                            null)) {
                          return "Room Exist";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormBuilder(
                      hint: "price",
                      controller: priceTEC,
                      keyType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter price";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormBuilder(
                      hint: "description",
                      controller: descTEC,
                      maxLines: 4,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter description";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonWidget(
                            const Text('save'),
                            isExpanded: true,
                            color: mainGColor,
                            fun: () {
                              save();
                            },
                          ),
                        ),
                        widget.edit != null
                            ? Expanded(
                                child: ButtonWidget(
                                  const Text(
                                    'delete',
                                    style: TextStyle(color: whiteFontColor),
                                  ),
                                  isExpanded: true,
                                  color: mainRColor,
                                  fun: () {
                                    delete();
                                  },
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ))),
      ),
    );
  }
}
