import 'package:get/get.dart';

class LanguageConfig extends GetxController{
  var selectedLanguage = 'EN'.obs;
  var lsLanguageConfig = [
    {"lang": "English", "id": "EN"},
    {"lang": "Indonesia", "id": "ID"},
    {"lang": "Filipina", "id": "FP"}
  ].obs;

  var greeting = 'Hola,'.obs;
  //greeting
  var signInMessage = 'Hi there, Nice to see you'.obs;
  var greeting1 = 'Good Morning,'.obs;
  var greeting2 = 'Good Afternoon,'.obs;
  var greeting3 = 'Good Evening,'.obs;

  //error
  var errorMessage = 'Failed'.obs;
  var errorCatch = 'Failed, Cannot get data from server'.obs;
  var errorTimeOut = "Failed, Connection Time Out".obs;
  var codePageNotFound = '404'.obs;
  var titlePageNotFound = 'Page Not Found!'.obs;
  var messagePageNotFound = "We're sorry, the page you requested could not be found. Please go back to the homepage!".obs;

  //sign in form
  var btnSignin = "Sign In".obs;
  var toHomePage = 'Go to Homepage'.obs;
  var formLoginUsername = 'Username'.obs;
  var formLoginPassword = 'Password'.obs;
  var validateLoginUsername = 'Please input username'.obs;
  var validateLoginPassword = 'Please input password'.obs;
  var validateFormLogin = 'Please check all field before continue'.obs;

  //attendance
  var greetingMessage = "LETS ABSENT!".obs;
  var attentionTitle= "Attention".obs;
  var inAreaMessage= "You are in the circle area".obs;
  var outAreaMessage= "You are not in the circle area".obs;

  var checkInTitle = "Check In".obs;
  var checkOutTitle = "Check Out".obs;
  var doneTitle = "Done".obs;
  var checkAreaTitle = "Check Area".obs;
  var dateTitle = "Date".obs;
  var statusTitle = "Status".obs;
  var historyTitle = "History".obs;
  var positionTitle = "Position".obs;

  @override
  void onInit() {
    onGreetingUser();
    onSetLanguage();
    super.onInit();
  }

  void onGreetingUser(){
    // DateTime currentTime = DateTime.now();
    // // var time = DateFormat('kk').format(currentTime);
    // int formatTime = int.parse(time.toString());
    //
    // if(formatTime > 1 && formatTime <= 10){
    //   greeting.value = greeting1.value;
    // } else if(formatTime > 10 && formatTime <= 18) {
    //   greeting.value = greeting2.value;
    // } else if(formatTime > 18 && formatTime < 24) {
    //   greeting.value = greeting3.value;
    // } else {
    //   greeting.value = "Hola,";
    // }
  }

  void onSetSelectedLang({required String selectedLang}){
    selectedLanguage.value = selectedLang;
    onSetLanguage();
  }

  void onSetLanguage() {
    signInMessage.value = selectedLanguage.value == 'EN' ? English().signInMessage : Indonesia().signInMessage;
    titlePageNotFound.value = selectedLanguage.value == 'EN' ? English().titlePageNotFound : Indonesia().titlePageNotFound;
    messagePageNotFound.value = selectedLanguage.value == 'EN' ? English().messagePageNotFound : Indonesia().messagePageNotFound;
    toHomePage.value = selectedLanguage.value == 'EN' ? English().toHomePage : Indonesia().toHomePage;
    btnSignin.value = selectedLanguage.value == 'EN' ? English().btnSignin : Indonesia().btnSignin;
    errorTimeOut.value = selectedLanguage.value == 'EN' ? English().errorTimeOut : Indonesia().errorTimeOut;
    errorCatch.value = selectedLanguage.value == 'EN' ? English().errorCatch : Indonesia().errorCatch;
    validateLoginUsername.value = selectedLanguage.value == 'EN' ? English().validateLoginUsername : Indonesia().validateLoginUsername;
    validateLoginPassword.value = selectedLanguage.value == 'EN' ? English().validateLoginPassword : Indonesia().validateLoginPassword;

    errorMessage.value = selectedLanguage.value == 'EN' ? English().errorMessage : selectedLanguage.value == 'IN' ? Indonesia().errorMessage : Filipina().errorMessage;

    greeting1.value = selectedLanguage.value == 'EN' ? English().greeting1 : selectedLanguage.value == 'IN' ? Indonesia().greeting1 : Filipina().greeting1;
    greeting2.value = selectedLanguage.value == 'EN' ? English().greeting2 : selectedLanguage.value == 'IN' ? Indonesia().greeting2 : Filipina().greeting2;
    greeting3.value = selectedLanguage.value == 'EN' ? English().greeting3 : selectedLanguage.value == 'IN' ? Indonesia().greeting3 : Filipina().greeting3;

    greetingMessage.value = selectedLanguage.value == 'EN' ? English().greetingMessage : selectedLanguage.value == 'IN' ? Indonesia().greetingMessage : Filipina().greetingMessage;
    attentionTitle.value = selectedLanguage.value == 'EN' ? English().attentionTitle : selectedLanguage.value == 'IN' ? Indonesia().attentionTitle : Filipina().attentionTitle;
    inAreaMessage.value = selectedLanguage.value == 'EN' ? English().inAreaMessage : selectedLanguage.value == 'IN' ? Indonesia().inAreaMessage : Filipina().inAreaMessage;
    outAreaMessage.value = selectedLanguage.value == 'EN' ? English().outAreaMessage : selectedLanguage.value == 'IN' ? Indonesia().outAreaMessage : Filipina().outAreaMessage;
    checkInTitle.value = selectedLanguage.value == 'EN' ? English().checkInTitle : selectedLanguage.value == 'IN' ? Indonesia().checkInTitle : Filipina().checkInTitle;
    checkOutTitle.value = selectedLanguage.value == 'EN' ? English().checkOutTitle : selectedLanguage.value == 'IN' ? Indonesia().checkOutTitle : Filipina().checkOutTitle;
    doneTitle.value = selectedLanguage.value == 'EN' ? English().doneTitle : selectedLanguage.value == 'IN' ? Indonesia().doneTitle : Filipina().doneTitle;
    checkAreaTitle.value = selectedLanguage.value == 'EN' ? English().checkAreaTitle : selectedLanguage.value == 'IN' ? Indonesia().checkAreaTitle : Filipina().checkAreaTitle;
    dateTitle.value = selectedLanguage.value == 'EN' ? English().dateTitle : selectedLanguage.value == 'IN' ? Indonesia().dateTitle : Filipina().dateTitle;
    statusTitle.value = selectedLanguage.value == 'EN' ? English().statusTitle : selectedLanguage.value == 'IN' ? Indonesia().statusTitle : Filipina().statusTitle;
    historyTitle.value = selectedLanguage.value == 'EN' ? English().historyTitle : selectedLanguage.value == 'IN' ? Indonesia().historyTitle : Filipina().historyTitle;
    positionTitle.value = selectedLanguage.value == 'EN' ? English().positionTitle : selectedLanguage.value == 'IN' ? Indonesia().positionTitle : Filipina().positionTitle;
  }
}

class English{
  String signInMessage = 'Hi there, Nice to see you';
  String greeting1 = 'Good Morning';
  String greeting2 = 'Good Afternoon';
  String greeting3 = 'Good Evening';
  String errorMessage = 'Failed';
  String errorCatch = 'Failed, Cannot get data from server';
  String errorTimeOut = "Failed, Connection Time Out";
  String codePageNotFound = '404';
  String titlePageNotFound = 'Page Not Found!';
  String messagePageNotFound = "We're sorry, the page you requested could not be found. Please go back to the homepage!";
  String btnSignin = "Sign In";
  String toHomePage = 'Go to Homepage';
  String formLoginUsername = 'Username';
  String formLoginPassword = 'Password';
  String validateLoginUsername = 'Please input username';
  String validateLoginPassword = 'Please input password';
  String validateFormLogin = 'Please check all field before continue';

  String greetingMessage = 'LETS ABSENT!';
  String attentionTitle = 'Attention';
  String inAreaMessage = 'You are in the circle area';
  String outAreaMessage = 'You are not in the circle area';
  String checkInTitle = 'Check In';
  String checkOutTitle = 'Check Out';
  String doneTitle = 'Done';
  String checkAreaTitle = 'Check Area';
  String dateTitle = 'Date';
  String statusTitle = 'Status';
  String historyTitle = 'History';
  String positionTitle = 'Position';
}

class Indonesia{
  String signInMessage = 'Halo disana, Senang melihatmu kembali';
  String greeting1 = 'Selamat Pagi';
  String greeting2 = 'Selamat Siang';
  String greeting3 = 'Selamat Malam';
  String titlePageNotFound = 'Halaman tidak ditemukan!';
  String messagePageNotFound = 'Mohon maaf, halaman yang anda inginkan tidak ditemukan. Silahkan kembali ke halaman utama!';
  String toHomePage = 'Menuju halaman utama';
  String btnSignin = 'Masuk';
  String errorTimeOut = 'Gagal, Waktu habis untuk terhubung';
  String errorMessage = 'Gagal';
  String errorCatch = 'Gagal, Tidak dapat terhubung dengan server';
  String validateLoginUsername = 'Silahkan masukkan username';
  String validateLoginPassword = 'Silahkan masukkan password';
  String validateFormLogin = 'Silahkan periksa semua field sebelum melanjutkan';

  String greetingMessage = 'ABSEN DULU YUK!';
  String attentionTitle = 'Perhatian';
  String inAreaMessage = 'Anda berada dalam lingkaran area';
  String outAreaMessage = 'Anda tidak berada dalam lingkaran area';

  String checkInTitle = 'Absen Masuk';
  String checkOutTitle = 'Absen Keluar';
  String doneTitle = 'Selesai';
  String checkAreaTitle = 'Periksa Area';
  String dateTitle = 'Tanggal';
  String statusTitle = 'Status';
  String historyTitle = 'Riwayat';
  String positionTitle = 'Posisi';
}

class Filipina{
  String signInMessage = 'Halo disana, Senang melihatmu kembali';
  String greeting1 = 'Magandang umaga';
  String greeting2 = 'Magandang hapon';
  String greeting3 = 'Magandang gabi';
  String titlePageNotFound = 'Halaman tidak ditemukan!';
  String messagePageNotFound = 'Mohon maaf, halaman yang anda inginkan tidak ditemukan. Silahkan kembali ke halaman utama!';
  String toHomePage = 'Menuju halaman utama';
  String btnSignin = 'Masuk';
  String errorTimeOut = 'Gagal, Waktu habis untuk terhubung';
  String errorMessage = 'Nabigo';
  String errorCatch = 'Gagal, Tidak dapat terhubung dengan server';
  String validateLoginUsername = 'Silahkan masukkan username';
  String validateLoginPassword = 'Silahkan masukkan password';
  String validateFormLogin = 'Silahkan periksa semua field sebelum melanjutkan';

  String greetingMessage = 'ABENT MUNA TAYO!';
  String attentionTitle = 'Pansin';
  String inAreaMessage = 'Ikaw ay nasa bilog na lugar';
  String outAreaMessage = 'Wala ka sa circle area';

  String checkInTitle = 'Pag-log in sa kawalan';
  String checkOutTitle = 'absent sa labas';
  String doneTitle = 'Tapos na';
  String checkAreaTitle = 'Suriin ang Lugar';
  String dateTitle = 'Petsa';
  String statusTitle = 'Katayuan';
  String historyTitle = 'Kasaysayan';
  String positionTitle = 'Posisyon';
}