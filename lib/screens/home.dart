import 'dart:convert';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:safe_droid/components/constantes.dart';

import 'package:http/http.dart' as http;
import 'package:safe_droid/components/notification.dart';
import 'package:safe_droid/db/db.dart';
import 'package:safe_droid/models/appli.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<AppAnalyse>>? futureApp;
  final appDB = DB();
  // Variable
  String? _fileName;
  PlatformFile? pickedfile;
  bool isLoading = false;
  File? fileToDisplay;
  FilePickerResult? result;
  int notif = 0;

  pickFile() async {
    try {
      setState(() {
        isLoading = true;

        pickedfile != null;
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
          pickedfile != null;
        });
        setState(() {
          isLoading = false;
          pickedfile != null;
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
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
                              onTap: () {
                                pickFile();
                                Navigator.pop(context);
                              },
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
                            late double permission = .0;
                            late double cerficat = .0;
                            late double manifest = .0;
                            late double networkSecurity = .0;
                            late double codeAnalys = .0;
                            late double scoreSecu = .0;
                            late double res = .0;

                            final client = http.Client();
                            final headers = {'X-Mobsf-Api-Key': apiKey};

                            final request = http.MultipartRequest(
                                'POST', Uri.parse('$baseURL/upload'));

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
                              final responses = await client.post(
                                  Uri.parse('$baseURL/scan'),
                                  body: parameters,
                                  headers: headers);

                              var dat = jsonDecode(responses.body);
                              // Calcule pourcentage Permission
                              var permis = dat['permissions'];
                              Map<String, dynamic> jsonMap =
                                  jsonDecode(jsonEncode(permis));
                              late int cont = 0;
                              jsonMap.forEach((key, value) {
                                Map<String, dynamic> val =
                                    jsonDecode(jsonEncode(value));
                                val.forEach((ke, valu) {
                                  if (ke == 'status') {
                                    if (valu == "dangerous") {
                                      cont++;
                                    }
                                  }
                                });
                                permission = (cont / jsonMap.length) * 100;
                              });

                              // Calcule certificate_analysis
                              var certificate = dat['certificate_analysis']
                                  ['certificate_summary'];
                              cerficat = (certificate['high'] /
                                      (certificate['high'] +
                                          certificate['warning'] +
                                          certificate['info'])) *
                                  100;
                              // Calcule manifest_analysis
                              var manifests =
                                  dat['manifest_analysis']['manifest_summary'];
                              manifest = (manifests['high'] /
                                      (manifests['warning'] +
                                          manifests['high'] +
                                          manifests['info'] +
                                          manifests['suppressed'])) *
                                  100;

                              // network_security
                              var networkSecu =
                                  dat['network_security']['network_summary'];
                              networkSecurity = (networkSecu['high'] /
                                      (networkSecu['high'] +
                                          networkSecu['warning'] +
                                          networkSecu['info'] +
                                          networkSecu['secure'])) *
                                  100;
                              // code_analysis
                              var codeAnalysis =
                                  dat['code_analysis']['summary'];
                              codeAnalys = (codeAnalysis['high'] /
                                      (codeAnalysis['high'] +
                                          codeAnalysis['warning'] +
                                          codeAnalysis['info'] +
                                          codeAnalysis['secure'] +
                                          codeAnalysis['suppressed'])) *
                                  100;

                              // Securité Score
                              var securityScore =
                                  dat["appsec"]["security_score"];
                              scoreSecu =
                                  double.tryParse(securityScore.toString())!;

                              // Final result
                              res = (permission +
                                      cerficat +
                                      codeAnalys +
                                      networkSecurity +
                                      manifest) /
                                  5.0;
                              await appDB.create(
                                id: dat['package_name'],
                                appName: dat["app_name"],
                                url: pickedfile?.path,
                                version: dat["version_name"],
                                certificat: cerficat.roundToDouble(),
                                manifest: manifest.roundToDouble(),
                                networkSecu: networkSecurity.roundToDouble(),
                                codeAnalyst: codeAnalys.roundToDouble(),
                                scoreSecu: scoreSecu.roundToDouble(),
                                permission: permission.roundToDouble(),
                              );

                              setState(() {
                                notif++;
                                pickedfile = null;
                              });
                              NotificationService.showNotification(
                                  titre: "Analyse terminée",
                                  summary: "Analyse Statique de $_fileName",
                                  payload: {'navigate': 'true'},
                                  actionButtons: [
                                    NotificationActionButton(
                                        key: 'check',
                                        label: "Ouvrir",
                                        actionType: ActionType.Default,
                                        color: cBleuFonce)
                                  ],
                                  body:
                                      "L'application $_fileName est malvaillante");
                            } else {
                              NotificationService.showNotification(
                                  titre: "Analyse terminée",
                                  summary: "Analyse Statique",
                                  payload: {'navigate': 'true'},
                                  actionButtons: [
                                    NotificationActionButton(
                                      key: 'check',
                                      label: "Voir",
                                      actionType: ActionType.SilentAction,
                                      color: cBleuFonce,
                                    )
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          padding: EdgeInsets.only(
            left: size.width * 0.1 - 10,
            right: size.width * 0.1 - 30,
            // bottom: size.width * 0.1 - 20,
          ),
          decoration: const BoxDecoration(
            color: cBleuFonce,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: size * 0.15,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: size.width * 0.1 - 10,
                  right: size.width * 0.1 - 30,
                  //  bottom: size.width * 0.1 - 20,
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
                    const Spacer(),
                    Image.asset(
                      "assets/images/andro.png",
                      width: 100,
                      height: 100,
                      color: cBlanc,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                notif = 0;
              });
              Navigator.of(context).pushNamed("/notifications");
            },
            icon: Badge(
              isLabelVisible: notif == 0 ? false : true,
              offset: Offset.zero,
              label: Text(
                notif.toString(),
                style: const TextStyle(color: cBlanc),
              ),
              alignment: Alignment.topRight,
              child: const Icon(Icons.notifications),
            ),
          )
        ],
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
      body: SizedBox(
        child: FutureBuilder<List<AppInfo>>(
          future: InstalledApps.getInstalledApps(true, true),
          builder: (BuildContext buildContext,
              AsyncSnapshot<List<AppInfo>> snapshot) {
            return snapshot.connectionState == ConnectionState.done
                ? snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          AppInfo app = snapshot.data![index];
                          return Card(
                            color: Colors.grey.shade200,
                            margin: const EdgeInsets.only(
                                left: 12, top: 15, bottom: 5, right: 12),
                            elevation: 0,
                            borderOnForeground: true,
                            child: CheckboxListTile(
                              onChanged: (value) {},
                              title: Text(app.name!),
                              subtitle: Text(app.packageName!),
                              secondary: Image.memory(app.icon!),
                              value: false,
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: SpinKitRotatingCircle(
                          color: cBleuFonce,
                          size: 50,
                        ),
                      )
                : const Center(
                    child: SpinKitFoldingCube(
                      color: cBleuFonce,
                      size: 70,
                    ),
                  );
          },
        ),
      ),
    );
  }

  FloatingActionButton btnAnalyse(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text("Analyse apk"),
      icon: const Icon(Icons.add),
      backgroundColor: cBleuFonce,
      onPressed: () => _showModalSheet(context),
    );
  }
}
