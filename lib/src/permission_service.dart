import 'package:permission_handler/permission_handler.dart';

/// Defines the state of a [Permission].
enum PermissionServiceStatus {
  /// The user denied access to the requested feature.
  denied,

  /// The user granted access to the requested feature.
  granted,

  /// The OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  /// *Only supported on iOS.*
  restricted,

  ///User has authorized this application for limited access.
  /// *Only supported on iOS (iOS14+).*
  limited,

  /// The user denied access to the requested feature and selected to never
  /// again show a request for this permission. The user may still change the
  /// permission status in the settings.
  /// *Only supported on Android.*
  permanentlyDenied,
}

/// Defines list of a [Permission].
enum PermissionService {
  /// Android: Calendar
  /// iOS: Calendar (Events)
  calendar,

  /// Android: Camera
  /// iOS: Photos (Camera Roll and Camera)
  camera,

  /// Android: Contacts
  /// iOS: AddressBook
  contacts,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation (Always and WhenInUse)
  location,

  /// Android:
  ///   When running on Android < Q: Fine and Coarse Location
  ///   When running on Android Q and above: Background Location Permission
  /// iOS: CoreLocation - Always
  locationAlways,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - WhenInUse
  locationWhenInUse,

  /// Android: None
  /// iOS: MPMediaLibrary
  mediaLibrary,

  /// Android: Microphone
  /// iOS: Microphone
  microphone,

  /// Android: Phone
  /// iOS: Nothing
  phone,

  /// Android: Nothing
  /// iOS: Photos
  /// iOS 14+ read & write access level
  photos,

  /// Android: Nothing
  /// iOS: Photos
  /// iOS 14+ read & write access level
  photosAddOnly,

  /// Android: Nothing
  /// iOS: Reminders
  reminders,

  /// Android: Body Sensors
  /// iOS: CoreMotion
  sensors,

  /// Android: Sms
  /// iOS: Nothing
  sms,

  /// Android: Microphone
  /// iOS: Speech
  speech,

  /// Android: External Storage
  /// iOS: Access to folders like `Documents` or `Downloads`. Implicitly
  /// granted.
  storage,

  /// Android: Ignore Battery Optimizations
  ignoreBatteryOptimizations,

  /// Android: Notification
  /// iOS: Notification
  notification,

  /// Android: Allows an application to access any geographic locations
  /// persisted in the user's shared collection.
  accessMediaLocation,

  /// When running on Android Q and above: Activity Recognition
  /// When running on Android < Q: Nothing
  /// iOS: Nothing
  activityRecognition,

  /// The unknown only used for return type, never requested
  unknown,

  /// iOS 13 and above: The authorization state of Core Bluetooth manager.
  /// When running < iOS 13 or Android this is always allowed.
  bluetooth
}

mixin PermissionServiceMixin {
  /// Wrapper for status permission status
  static PermissionServiceStatus _serializePermissionStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.denied:
        return PermissionServiceStatus.denied;
      case PermissionStatus.granted:
        return PermissionServiceStatus.granted;
      case PermissionStatus.restricted:
        return PermissionServiceStatus.restricted;
      case PermissionStatus.limited:
        return PermissionServiceStatus.limited;
      case PermissionStatus.permanentlyDenied:
        return PermissionServiceStatus.permanentlyDenied;
    }
  }

  /// Wrapper for list of permission
  static Permission _serializePermission(PermissionService permissionService) {
    switch (permissionService) {
      case PermissionService.calendar:
        return Permission.calendar;
      case PermissionService.camera:
        return Permission.camera;
      case PermissionService.contacts:
        return Permission.contacts;
      case PermissionService.location:
        return Permission.location;
      case PermissionService.locationAlways:
        return Permission.locationAlways;
      case PermissionService.locationWhenInUse:
        return Permission.locationWhenInUse;
      case PermissionService.mediaLibrary:
        return Permission.mediaLibrary;
      case PermissionService.microphone:
        return Permission.microphone;
      case PermissionService.phone:
        return Permission.phone;
      case PermissionService.photos:
        return Permission.photos;
      case PermissionService.photosAddOnly:
        return Permission.photosAddOnly;
      case PermissionService.reminders:
        return Permission.reminders;
      case PermissionService.sensors:
        return Permission.sensors;
      case PermissionService.sms:
        return Permission.sms;
      case PermissionService.speech:
        return Permission.speech;
      case PermissionService.storage:
        return Permission.storage;
      case PermissionService.ignoreBatteryOptimizations:
        return Permission.ignoreBatteryOptimizations;
      case PermissionService.notification:
        return Permission.notification;
      case PermissionService.accessMediaLocation:
        return Permission.accessMediaLocation;
      case PermissionService.activityRecognition:
        return Permission.activityRecognition;
      case PermissionService.unknown:
        return Permission.unknown;
      case PermissionService.bluetooth:
        return Permission.bluetooth;
    }
  }

  /// Request permissions
  Future<List<PermissionServiceStatus>> requestPermissions({required List<PermissionService> permissions}) async {
    List<Permission> _permissionsToRequest = [];
    List<PermissionServiceStatus> _permissionServiceStatus = [];

    permissions.forEach((element) => _permissionsToRequest.add(_serializePermission(element)));

    final _results = await _permissionsToRequest.request();

    _results.values.forEach((element) => _permissionServiceStatus.add(_serializePermissionStatus(element)));

    return _permissionServiceStatus;
  }

  /// Check some permission
  Future<PermissionServiceStatus> checkPermission({required PermissionService permissionService}) async {
    PermissionStatus _status = await _serializePermission(permissionService).status;
    return _serializePermissionStatus(_status);
  }

  /// Open app settings
  Future<bool> openSetting() async => await openAppSettings();
}
