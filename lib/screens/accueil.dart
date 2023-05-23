// import 'package:flutter/material.dart';
// import 'package:installed_apps/app_info.dart';
// import 'package:installed_apps/installed_apps.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// class Accueil extends StatefulWidget {
//   const Accueil({super.key});

//   @override
//   State<Accueil> createState() => _AccueilState();
// }

// class _AccueilState extends State<Accueil> {
//   // String? _fileName;
//   // PlatformFile? pickedfile;
//   // bool isLoading = false;
//   // File? fileToDisplay;
//   // FilePickerResult? result;

//   // void pickFile() async {
//   //   try {
//   //     setState(() {
//   //       isLoading = true;
//   //     });

//   //     result = await FilePicker.platform.pickFiles(
//   //       type: FileType.any,
//   //       allowMultiple: false,
//   //     );
//   //     if (result != null) {
//   //       _fileName = result!.files.first.name;
//   //       pickedfile = result!.files.first;
//   //       fileToDisplay = File(pickedfile!.path.toString());
//   //       print("Fichier : $_fileName");
//   //     }
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //   } catch (e) {
//   //     print(e.toString());
//   //   }
//   // }

//   void _showModalSheet(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     showModalBottomSheet(
//       context: context,
//       isDismissible: true,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//         top: Radius.circular(20),
//         bottom: Radius.circular(20),
//       )),
//       builder: (context) => DraggableScrollableSheet(
//         expand: false,
//         initialChildSize: 0.6,
//         maxChildSize: 0.8,
//         minChildSize: 0.4,
//         builder: ((context, scrollController) => SingleChildScrollView(
//               controller: scrollController,
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Positioned(
//                     child: Container(
//                       width: 60,
//                       height: 7,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: true
//                           ? Text("Wait")
//                           : TextButton(
//                               onPressed: () {
//                                 // pickFile();
//                               },
//                               child: Text("Get File")),
//                     ),
//                   )
//                 ],
//               ),
//             )),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(title: const Text("Application Installées")),
//       floatingActionButton: FloatingActionButton.extended(
//         label: const Text("Analyse apk"),
//         icon: const Icon(Icons.add),
//         onPressed: () => _showModalSheet(context),
//       ),
//       body: Container(
//         child: FutureBuilder<List<AppInfo>>(
//           future: InstalledApps.getInstalledApps(true, true),
//           builder: (BuildContext buildContext,
//               AsyncSnapshot<List<AppInfo>> snapshot) {
//             return snapshot.connectionState == ConnectionState.done
//                 ? snapshot.hasData
//                     ? ListView.builder(
//                         itemCount: snapshot.data!.length,
//                         scrollDirection: Axis.vertical,
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           AppInfo app = snapshot.data![index];
//                           return Card(
//                             child: CheckboxListTile(
//                               onChanged: (value) async {
//                                 bool? isSystemApp =
//                                     await InstalledApps.isSystemApp(
//                                         app.packageName!);
//                                 // FlutterAppBadger.updateBadgeCount(1);
//                                 // print("Une application system : $isSystemApp");
//                               },
//                               title: Text(app.name!),
//                               subtitle: Text(app.packageName!),
//                               secondary: Image.memory(app.icon!),
//                               value: false,
//                             ),
//                           );
//                         },
//                       )
//                     : const Center(
//                         child: SpinKitRotatingCircle(
//                           color: Colors.amber,
//                           size: 50,
//                         ),
//                       )
//                 : const Center(
//                     child: SpinKitFoldingCube(
//                       color: Colors.amber,
//                       size: 70,
//                     ),
//                   );
//           },
//         ),
//       ),
//     );
//   }
// }
