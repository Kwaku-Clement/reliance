import 'package:device_info_plus/device_info_plus.dart';
import 'package:logger/logger.dart';
import 'dart:io';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfoPlugin;
  final Logger _logger;

  // Fixed constructor to properly use the plugin parameter
  DeviceInfoService(this._logger, {DeviceInfoPlugin? plugin})
    : _deviceInfoPlugin = plugin ?? DeviceInfoPlugin();

  Future<Map<String, dynamic>?> getDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
        return {
          'platform': 'Android',
          'model': androidInfo.model,
          'brand': androidInfo.brand,
          'device': androidInfo.device,
          'sdkInt': androidInfo.version.sdkInt,
        };
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
        return {
          'platform': 'iOS',
          'name': iosInfo.name,
          'model': iosInfo.model,
          'systemName': iosInfo.systemName,
          'systemVersion': iosInfo.systemVersion,
          'utsnameVersion': iosInfo.utsname.version,
          'utsnameMachine': iosInfo.utsname.machine,
        };
      } else {
        _logger.w('Device info not supported for this platform.');
        return {'platform': 'Other', 'details': 'N/A'};
      }
    } catch (e) {
      _logger.e('Error getting device info: $e');
      return {'platform': 'Unknown', 'error': e.toString()};
    }
  }
}
