import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_assignment/features/settings/models/setting_model.dart';
import 'package:tiktok_clone_assignment/features/settings/repos/setting_repo.dart';
import 'package:tiktok_clone_assignment/features/settings/setting_screen.dart';
import 'package:tiktok_clone_assignment/features/videos/models/playback_config_model.dart';

class SettingViewModel extends Notifier<SettingModel> {
  //SettingModel 형태로 Notifier를 상속받는 SettingViewModel 클래스 선언
  final SettingRepository _repository;

  SettingViewModel(this._repository);

  void setDarkMode(DarkMode mode) {
    _repository.setDarkMode(mode);
    state =
        SettingModel(darkmode: mode); //state에 새로운 SettingModel을 할당함으로 상태를 변경
    //state는 Notifier의 속성으로 상태를 변경할 때마다 notifyListeners()를 호출하여 UI를 업데이트
    //state는 Mutatable이 아니기 때문에 새로운 객체를 할당하여 변경
  }

  @override
  SettingModel build() {
    return SettingModel(darkmode: _repository.getDarkMode());
  }
}

final settingConfigProvider = NotifierProvider<SettingViewModel, SettingModel>(
  // () => SettingViewModel(),
  () => throw UnimplementedError(),
  // => SettingViewModel(),
);

// final settingProvider = ChangeNotifierProvider<SettingViewModel>((ref) {
//   final repository = ref.watch(settingRepositoryProvider);
//   return SettingViewModel(repository);
// });
