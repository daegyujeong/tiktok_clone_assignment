enum DarkMode {
  system,
  light,
  dark,
}

class SettingModel {
  DarkMode darkmode;

  SettingModel({
    required this.darkmode,
  });
}
