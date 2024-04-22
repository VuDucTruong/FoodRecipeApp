
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeviceInfo {
  TargetPlatform _targetPlatform;
  DeviceInfo({required TargetPlatform targetPlatform})
      : _targetPlatform = targetPlatform;


  Future<DeviceInfoParams> getDeviceInfo() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (_targetPlatform == TargetPlatform.android)
      {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        String infostr = 'Android ${androidInfo.version.release} ${androidInfo.model}; OS ${androidInfo.version.sdkInt}';
        return DeviceInfoParams(deviceId: androidInfo.androidId, deviceInfo: infostr);
      }
    else if (_targetPlatform == TargetPlatform.iOS)
      {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        String infostr = 'iOS ${iosInfo.systemVersion} ${iosInfo.model}';
        return DeviceInfoParams(deviceId: iosInfo.identifierForVendor, deviceInfo: infostr);
      }
    else {
      return DeviceInfoParams(deviceId: 'unknown', deviceInfo: 'unknown');
    }
  }
}

class DeviceInfoParams{
  String deviceId;
  String deviceInfo;
  DeviceInfoParams({required this.deviceId, required this.deviceInfo});
}