import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dotted_border/dotted_border.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  String? _fileName;
  PlatformFile? pickedfile;
  bool isLoading = false;
  File? fileToDisplay;
  FilePickerResult? result;
  String baseURL = 'http://127.0.0.1:8000/api/v1';

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
        print(pickedfile?.extension);
        setState(() {
          isLoading = true;
        });
        // print("Fichier details $_fileName, $pickedfile");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {}
  }

  Future<void> uploadApk() async {
    final Uri uploadUrl = Uri.parse('http://localhost:8000/api/v1/upload/');

    var request = http.MultipartRequest("POST", uploadUrl);
    // request.headers['Authorization'] =
    //     "56db51b8127e7fc7fc52aa4b639c0d34d2b30131c57893616246834b9dcdfc5a";

    Map<String, String> requestHeaders = {
      'Content-type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization':
          '56db51b8127e7fc7fc52aa4b639c0d34d2b30131c57893616246834b9dcdfc5a'
    };
    var stream = http.ByteStream(fileToDisplay!.openRead());
    stream.cast();

    var length = await fileToDisplay!.length();

    var apk = http.MultipartFile("file", stream, length);

    request.files.add(apk);
    request.headers.addAll(requestHeaders);
    print("object");

    final response = await request.send();

    //var responseData = await response.stream.toBytes();

    if (response.statusCode == 200) {
      print("Success");
    } else {
      print("Error");
    }
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
                      const Text(
                        "Selectionner une application à analyser",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      pickedfile != null
                          ? Text(
                              _fileName.toString(),
                              style: TextStyle(
                                color: Colors.blue.shade400,
                                fontSize: 24,
                              ),
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
                                  color: Colors.blue.shade400,
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
                                          color: Colors.blue,
                                          size: 40,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Select l'application à analyser",
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
/*
 request.headers['Authorization'] =
                                "56db51b8127e7fc7fc52aa4b639c0d34d2b30131c57893616246834b9dcdfc5a";
                            request.headers['Content-type'] =
                                'multipart/form-data';
                            request.headers['Accept'] =
                                'application/json; charset=utf-8';
*/

                            FormData fichier =
                                FormData.fromMap({"file": fileToDisplay});

                            final Dio dio = Dio();

                            Response respons = await dio.post(
                                "http://10.0.2.2:8000/api/v1/upload",
                                data: fichier,
                                options: Options(headers: {
                                  "Accept": "*/*",
                                  "Authorization":
                                      "56db51b8127e7fc7fc52aa4b639c0d34d2b30131c57893616246834b9dcdfc5a",
                                  'Content-type': 'multipart/form-data',
                                }));

                            final Uri uploadUrl =
                                Uri.parse('http://10.0.2.2:8000/api/v1/upload');

                            var request =
                                http.MultipartRequest("POST", uploadUrl);

                            Map<String, dynamic> requestHeaders = {
                              'Content-type ': 'multipart/form-data',
                              'Accept ': 'application/json',
                              'Authorization ':
                                  '56db51b8127e7fc7fc52aa4b639c0d34d2b30131c57893616246834b9dcdfc5a'
                            };
                            var stream =
                                http.ByteStream(fileToDisplay!.openRead());
                            stream.cast();

                            var length = await fileToDisplay!.length();

                            var apk =
                                http.MultipartFile("file", stream, length);

                            request.files.add(apk);
                            // request.headers.addAll(requestHeaders);

                            final response = await request.send();

                            //var responseData = await response.stream.toBytes();

                            if (respons.statusCode == 200) {
                              print("Success");
                            } else {
                              print(respons.statusCode);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(size.width - 45, size.width * 0.12),
                            backgroundColor: Colors.amber,
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
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
      appBar: AppBar(title: const Text("Application Installées")),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Analyse apk"),
        icon: const Icon(Icons.add),
        onPressed: () => _showModalSheet(context),
      ),
      body: Container(
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
                          color: Colors.amber,
                          size: 50,
                        ),
                      )
                : const Center(
                    child: SpinKitFoldingCube(
                      color: Colors.amber,
                      size: 70,
                    ),
                  );
          },
        ),
      ),
    );
  }
}

Future<void> uploadFile(File file) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse("http://10.0.2.2:8000/api/v1/upload"));

  var fileStream = http.ByteStream(file.openRead());
  var length = await file.length();
  var multipartFile =
      http.MultipartFile('file', fileStream, length, filename: file.path);
  request.headers["Authorization"] =
      '56db51b8127e7fc7fc52aa4b639c0d34d2b30131c57893616246834b9dcdfc5a';
  request.headers["Content-Type"] = ' multipart/form-data';
  request.headers["Content-Type"] = 'application/octet-stream';
  request.headers["Content-Disposition"] = 'application/octet-stream';

  request.files.add(multipartFile);

  var response = await request.send();

  if (response.statusCode == 200) {
    print("sucess");
  } else {
    print("error");
  }
/*
  var doi = Dio();

  FormData data = FormData.fromMap({
    "Autorization":
        "56db51b8127e7fc7fc52aa4b639c0d34d2b30131c57893616246834b9dcdfc5a",
  });*/
}
