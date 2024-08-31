import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'pedometer_db_platform_interface.dart';



/// An implementation of [PedometerDbPlatform] that uses method channels.
class MethodChannelPedometerDb extends PedometerDbPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pedometer_db');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<int?> queryPedometerDataFromOS(int startTime, int endTime) async {
    final steps = await methodChannel.invokeMethod<int>('queryPedometerDataFromOS', {'startTime': startTime, 'endTime': endTime});
    return steps;
  }
}
