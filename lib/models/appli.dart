class AppAnalyse {
  final String id;
  final String appName;
  final String? url;
  final String version;
  final double certificat;
  final double manifest;
  final double networkSecu;
  final double codeAnalyst;
  final double scoreSecu;
  final double permission;

  AppAnalyse({
    required this.id,
    required this.appName,
    required this.permission,
    this.url,
    required this.version,
    required this.certificat,
    required this.manifest,
    required this.networkSecu,
    required this.codeAnalyst,
    required this.scoreSecu,
  });

  factory AppAnalyse.fromSqfliteDataBase(Map<String, dynamic> map) =>
      AppAnalyse(
          id: map['id'],
          appName: map['appName'] ?? '',
          url: map['url'] ?? '',
          version: map['version'],
          certificat: map['certificat'],
          manifest: map['manifest'],
          networkSecu: map['networkSecu'],
          codeAnalyst: map['codeAnalyst'],
          permission: map['permission'],
          scoreSecu: map['scoreSecu']);
}
