import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tribe/features/auth/presentation/components/my_text_field.dart';
import 'package:tribe/features/profile/domain/entities/profile_user.dart';
import 'package:tribe/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:tribe/features/profile/presentation/cubits/profile_states.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  PlatformFile? imagePickedFile; //mobile image pick
  Uint8List? webImage; //web image pick

  final bioTextController = TextEditingController(); //bio text controller

  Future<void> requestGalleryPermission() async {
  final status = await Permission.photos.request();

  if (!status.isGranted) {
    throw Exception("Gallery permission denied");
  }
}

  Future<void> pickImage() async {
    await requestGalleryPermission();
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: kIsWeb,
    );

    if (result != null) {
      setState(() {
        imagePickedFile = result.files.first;

        if (kIsWeb) {
          webImage = imagePickedFile!.bytes;
        }
      });
    }
  }

  void updateProfile() async {
    final profileCubit = context.read<ProfileCubit>();

    final String uid = widget.user.uid;
    final imageMobilePath = kIsWeb ? null : imagePickedFile?.path;
    final imageWebBytes = kIsWeb ? imagePickedFile?.bytes : null;
    final String? newBio = bioTextController.text.isNotEmpty
        ? bioTextController.text
        : null;

    if (newBio != null || imagePickedFile != null) {
      profileCubit.updateProfile(
        uid: uid,
        newBio: bioTextController.text,
        imageMobilePath: imageMobilePath,
        imageWebBytes: imageWebBytes,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator(), Text("Uploading...")],
              ),
            ),
          );
        } else {
          return buildEditPage();
        }
      },
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildEditPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(onPressed: updateProfile, icon: const Icon(Icons.upload)),
        ],
      ),
      body: Column(
        children: [
          //profile pic
          Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child:
                  //display selected image for mobile
                  (!kIsWeb && imagePickedFile != null)
                  ? Image.file(File(imagePickedFile!.path!))
                  :
                    //display selected image for web
                    (kIsWeb && webImage != null)
                  ? Image.memory(webImage!)
                  :
                    //no image selected -> display existing pfp
                    CachedNetworkImage(
                      imageUrl: widget.user.pfpUrl,
                      //loading
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      //error
                      errorWidget: (context, url, error) => Icon(
                        Icons.person,
                        size: 72,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      //loaded
                      imageBuilder: (context, imageProvider) =>
                          Image(image: imageProvider),
                    ),
            ),
          ),
          const SizedBox(height: 25),

          //pick image button
          Center(
            child: MaterialButton(
              onPressed: pickImage,
              color: Colors.blue,
              child: const Text("Pick Image"),
            ),
          ),

          //bio
          const Text("Bio"),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: MyTextField(
              controller: bioTextController,
              hintText: widget.user.bio,
              obscureText: false,
            ),
          ),
        ],
      ),
    );
  }
}
