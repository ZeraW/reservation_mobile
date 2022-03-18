
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/dimensions.dart';

class AddPic extends StatefulWidget {
 final String? imageUrl;
 final Function(File?) onChange;

  const AddPic({this.imageUrl,required this.onChange,Key? key}) : super(key: key);

  @override
  State<AddPic> createState() => _AddPicState();
}

class _AddPicState extends State<AddPic> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
      debugPrint('_storedImage $_storedImage');
      widget.onChange(_storedImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Responsive.width(3,context)),
          child: SizedBox(
            height: Responsive.width(26,context),
            width: Responsive.width(26,context),
            child: _storedImage != null
                ? Image.file(_storedImage!,fit: BoxFit.cover,)
                : widget.imageUrl != null ?
            Image.network('${widget.imageUrl}',fit: BoxFit.cover)
                :const Icon(
              Icons.image,
              size: 70,
              color: Colors.grey,
            ), // replace
          ),
        ),
        IntrinsicWidth(
          child: ListTile(
            onTap: _takePicture,
            leading: const CircleAvatar(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              backgroundColor: Colors.black54,
            ),
            title: const Text(
              'Add Picture',
            ),
          ),
        ),
      ],
    );
  }
}
