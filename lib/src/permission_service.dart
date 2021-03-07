import 'package:permission_handler/permission_handler.dart';

mixin PermissionServiceMixin {
  Future<bool> requestPrimaryPermission() async {
    Map<Permission, PermissionStatus> _primaryPermission =
        await [Permission.mediaLibrary, Permission.storage, Permission.camera, Permission.photos].request();

    return !_primaryPermission.values.toList().contains(PermissionStatus.denied);
  }

  Future<bool> requestGeoPermission() async {
    Map<Permission, PermissionStatus> _primaryPermission =
        await [Permission.location, Permission.locationAlways, Permission.locationWhenInUse].request();

    return !_primaryPermission.values.toList().contains(PermissionStatus.denied);
  }

  void openSetting() async => await openAppSettings();
}
