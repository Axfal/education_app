class AppUrl {
  static var baserUrl = 'https://nomore.com.pk/MDCAT_ECAT_Education/API';
  static var signIn = '$baserUrl/SignIn.php';
  static var signUp = '$baserUrl/Signup.php';
  static var fetchTest = '$baserUrl/fetch_test.php';
  static var fetchSubjects = '$baserUrl/fetch_user_subjects.php?test_id=';
  static var fetchChapters = '$baserUrl/fetch_user_chapters.php?test_id=';
  static var fetchQuestions = 'https://nomore.com.pk/MDCAT_ECAT_Education/API/user_test_data.php';
  static var feedback = '$baserUrl/feedback.php';
  static var createMockTest = '$baserUrl/MockTestGenerator.php';
}
