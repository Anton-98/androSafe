import 'dart:convert';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_droid/components/constantes.dart';

import 'package:http/http.dart' as http;
import 'package:safe_droid/components/notification.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Variable
  String? _fileName;
  PlatformFile? pickedfile;
  bool isLoading = false;
  File? fileToDisplay;
  FilePickerResult? result;
  pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      FilePickerResult? resul = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['apk', 'xapk'],
      );
      if (resul != null) {
        _fileName = resul.files.first.name;
        pickedfile = resul.files.first;
        fileToDisplay = File(resul.files.first.path.toString());
        setState(() {
          isLoading = true;
        });
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  _showModalSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        maxChildSize: 0.8,
        minChildSize: 0.7,
        builder: ((context, scrollController) => SingleChildScrollView(
              controller: scrollController,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -13,
                    height: 7,
                    child: Container(
                      width: size.width * 0.47,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      pickedfile == null
                          ? const Text(
                              "Selectionner une application à analyser",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Text(
                              "Détails",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      const SizedBox(
                        height: 18,
                      ),
                      pickedfile != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Type d'application : ${pickedfile!.extension}"),
                                const SizedBox(
                                  height: 18,
                                ),
                                Text("Nom application : ${pickedfile!.name} "),
                                const SizedBox(
                                  height: 18,
                                ),
                                const Text("Type d'analyse : Statique"),
                                const SizedBox(
                                  height: 18,
                                ),
                              ],
                            )
                          : GestureDetector(
                              onTap: pickFile,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40.0,
                                  vertical: 20.0,
                                ),
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(10),
                                  dashPattern: const [10, 4],
                                  strokeCap: StrokeCap.round,
                                  color: cBleuFonce,
                                  child: Container(
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.blue.shade50.withOpacity(.3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.folder_outlined,
                                          color: Color(0xff0094ec),
                                          size: 40,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Application à Analyser",
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 6,
                      ),
                      if (pickedfile != null)
                        ElevatedButton(
                          onPressed: () async {
                            final client = http.Client();
                            final headers = {
                              'X-Mobsf-Api-Key':
                                  'dabbfc1a1f90b18c36f0c9c739156f09b947d79c770db1dfa8fc84650ca4639e'
                            };

                            final request = http.MultipartRequest(
                                'POST',
                                Uri.parse(
                                    'http://10.0.2.2:8000/api/v1/upload'));

                            request.files.add(http.MultipartFile.fromBytes(
                                "file", fileToDisplay!.readAsBytesSync(),
                                filename: fileToDisplay?.path));

                            request.headers.addAll(headers);
                            final response = await client.send(request);

                            if (response.statusCode == 200) {
                              var responseByte =
                                  await response.stream.toBytes();
                              var responseString = utf8.decode(responseByte);
                              var data = jsonDecode(responseString);

                              final parameters = {
                                'scan_type': data["scan_type"],
                                'file_name': data["file_name"],
                                'hash': data["hash"],
                                're_scan': '0',
                              };
                              print("Analyse statique");
                              final responses = await client.post(
                                  Uri.parse('http://10.0.2.2:8000/api/v1/scan'),
                                  body: parameters,
                                  headers: headers);

                              // String hash = data["hash"];
                              // String scanType = data["scan_type"];
                              // String fileName = data["file_name"];
                              // String reScan = '0';
                              var dat = jsonDecode(responses.body);

                              var securityScore =
                                  dat["appsec"]["security_score"];

                              if (securityScore < 50) {
                                NotificationService.showNotification(
                                    titre: "Analyse terminée",
                                    summary: "Analyse Statique",
                                    payload: {'navigate': 'true'},
                                    actionButtons: [
                                      NotificationActionButton(
                                          key: 'check',
                                          label: "Voir resultat",
                                          actionType: ActionType.SilentAction,
                                          color: cBleuFonce)
                                    ],
                                    body:
                                        "L'application $_fileName est malvaillante");
                              }
                              print(
                                  "Version ${dat['manifest_analysis']["manifest_summary"]}");
                            } else {
                              NotificationService.showNotification(
                                  titre: "Analyse terminée",
                                  summary: "Analyse Statique",
                                  payload: {'navigate': 'true'},
                                  actionButtons: [
                                    NotificationActionButton(
                                        key: 'check',
                                        label: "Voir resultat",
                                        actionType: ActionType.SilentAction,
                                        color: cBleuFonce)
                                  ],
                                  body:
                                      "L'analyse de l'application $_fileName s'est mal terminée!!!");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(size.width * 0.5, size.height * 0.07),
                            backgroundColor: cBleuFonce,
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Analyser",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cBleuFonce,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
            colorFilter: const ColorFilter.mode(
              cBlanc,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("/menu");
          },
        ),
      ),
      floatingActionButton: btnAnalyse(context),
      body: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.2,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    left: size.width * 0.1 - 10,
                    right: size.width * 0.1 - 10,
                    bottom: size.width * 0.1 - 20,
                  ),
                  height: size.height * 0.2 - 27,
                  decoration: const BoxDecoration(
                    color: cBleuFonce,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "AndroSafe",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  FloatingActionButton btnAnalyse(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text("Analyse apk"),
      icon: const Icon(Icons.add),
      backgroundColor: cBleuClair,
      onPressed: () => _showModalSheet(context),
    );
  }
}
