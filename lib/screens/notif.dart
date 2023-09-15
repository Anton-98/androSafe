import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safe_droid/components/constantes.dart';
import 'package:safe_droid/db/db.dart';
import 'package:safe_droid/models/appli.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Future<List<AppAnalyse>>? futureApp;
  final appDB = DB();

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  void fetchAll() {
    setState(() {
      futureApp = appDB.fetchAll();
    });
  }

  _showModalSheet(BuildContext context, AppAnalyse app) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
      backgroundColor: Colors.grey[400]?.withOpacity(0.9),
      elevation: 0,
      isScrollControlled: true,
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      )),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55,
        minChildSize: 0.5,
        builder: ((context, scrollController) => SingleChildScrollView(
              controller: scrollController,
              child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 7,
                      height: 5,
                      child: Container(
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: cBlanc,
                        ),
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Résultats Analyse : ${app.appName}",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            height: 1,
                            thickness: 0.7,
                            endIndent: 0,
                            color: cBleuFonce,
                            indent: 0,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Vunerabilité Certifat : ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${app.certificat}%',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 0.7,
                            endIndent: size.width * 0.1,
                            color: cBleuFonce,
                            indent: 0,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Vunerabilité Code : ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${app.codeAnalyst}%',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 0.7,
                            endIndent: size.width * 0.1,
                            color: cBleuFonce,
                            indent: 0,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Vunerabilité Réseau : ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${app.networkSecu}%',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 0.7,
                            endIndent: size.width * 0.1,
                            color: cBleuFonce,
                            indent: 0,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Vunerabilité Manifest : ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${app.manifest}%',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 0.7,
                            endIndent: size.width * 0.1,
                            color: cBleuFonce,
                            indent: 0,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Vunerabilité Permissions : ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${app.permission}%',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 0.7,
                            endIndent: size.width * 0.1,
                            color: cBleuFonce,
                            indent: 0,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Score de Securité : ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${app.scoreSecu}%',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 2,
                            thickness: 3.2,
                            endIndent: size.width * 0.1,
                            color: cBleuFonce,
                            indent: size.width * 0.1,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Sécurité Globale : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${((app.certificat + app.codeAnalyst + app.networkSecu + app.manifest + app.permission + app.scoreSecu) / 6).roundToDouble()}%',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          TextButton.icon(
                              onPressed: () async {},
                              icon: const Icon(Icons.install_mobile_outlined),
                              label: const Text("Installer"))
                        ])
                  ]),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultats Analyse'),
        backgroundColor: cBleuFonce,
      ),
      body: FutureBuilder<List<AppAnalyse>>(
        future: futureApp,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitRotatingCircle(
                color: cBleuFonce,
              ),
            );
          } else {
            final appss = snapshot.data!;
            return appss.isEmpty
                ? const Center(
                    child: Text("Aucune notifications..."),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      final ap = appss[index];
                      return Badge(
                        padding: const EdgeInsets.only(right: 20),
                        alignment: Alignment.centerRight,
                        child: Dismissible(
                          background: Container(
                            color: cBleuFonce,
                          ),
                          secondaryBackground: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Supprimer',
                                    style: TextStyle(color: cBlanc),
                                  ),
                                  Icon(Icons.delete)
                                ]),
                          ),
                          key: ValueKey(ap.id),
                          onDismissed: (DismissDirection direction) {},
                          direction: DismissDirection.endToStart,
                          child: ListTile(
                            title: Text(ap.appName),
                            subtitle: Text(ap.url!),
                            onTap: () => _showModalSheet(context, ap),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                    itemCount: appss.length);
          }
        },
      ),
    );
  }
}
