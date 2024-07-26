import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  await storagePermission();
}

Future<void> storagePermission() async {
  final status = await Permission.storage.status;
  if (status != PermissionStatus.granted) {
    await Permission.storage.request();
  }
}
