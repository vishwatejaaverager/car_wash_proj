enum AppRoutes {
  otpScreen("otp_screen"),
  loginScreen("login_screen"),
  carModelsScreen("car_models"),
  homeScreen("home_screen"),
  serviceDetScreen('service_det_screen'),
  scheduleScreen('schedule_screen'),
  carCompScreen("car_comp_screem");

  const AppRoutes(this.path);

  final String path;
}
