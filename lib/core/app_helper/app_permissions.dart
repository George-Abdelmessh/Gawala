import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  await storagePermission();
}

Future<void> storagePermission() async {
  final permission = await Permission.storage.status;
  if (permission != PermissionStatus.granted) {
    await Permission.storage.request();
  }
}
