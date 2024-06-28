import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_assignment/features/settings/models/setting_model.dart';
import 'package:tiktok_clone_assignment/features/settings/repos/setting_repo.dart';
import 'package:tiktok_clone_assignment/features/settings/setting_screen.dart';
import 'package:tiktok_clone_assignment/features/videos/repos/playback_config_repo.dart';

class SettingViewModel extends ChangeNotifier {
  final SettingRepository _repository;
  late final SettingModel _model;

  SettingViewModel(this._repository)
      : _model = SettingModel(darkmode: _repository.getDarkMode());

  DarkMode get darkmode => _model.darkmode;

  void setDarkMode(DarkMode mode) {
    _repository.setDarkMode(mode);
    _model.darkmode = mode;
    notifyListeners();
  }
}

final settingProvider = ChangeNotifierProvider<SettingViewModel>((ref) {
  final repository = ref.watch(settingRepositoryProvider);
  return SettingViewModel(repository);
});
