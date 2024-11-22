part of 'onboard.dart';

class OnboardProvider extends BaseProvider {
  OnboardProvider({required super.context});

  TextEditingController nameController = TextEditingController();
  bool isContinueButtonEnable = false;
  int currentStep = 0;
  PageController pageController = PageController();
  ScrollController friendListScrollController = ScrollController();
  final List pronounsList = ["She / Her", "He / Him", "They / Them"];
  String selectedPronouns = "";
  DateTime userDob = DateTime.now();

  final List<String> interestsList = [
    "🎨 Art and Creativity",
    "📚 Literature",
    "🎥 Movies and TV Shows",
    "💃 Dancing",
    "🐶 Pets and Animals",
    "🌱 Gardening",
    "🌍 Volunteering",
    "💻 Technology",
    "👗 Fashion",
    "✈️ Travel",
    "🎵 Music",
    "⚽️ Sports",
    "🎮 Gaming",
    "💼 Career",
    "🍳 Cooking",
    "💪 Fitness",
    "☕️ Coffee",
    "💭 Philosophy/Existential questions",
    "🎭 Theater and Performing Arts",
    "🌍 Environmental Sustainability"
  ];

  List<String> selectedInterestsList = [];

  List friendsList = [
    Assets.images.aiModel1.path,
    Assets.images.aiModel2.path,
    Assets.images.aiModel3.path,
    Assets.images.aiModel1.path,
    Assets.images.aiModel2.path,
    Assets.images.aiModel3.path,
    Assets.images.aiModel1.path,
    Assets.images.aiModel2.path,
    Assets.images.aiModel3.path,
    Assets.images.aiModel1.path,
    Assets.images.aiModel2.path,
    Assets.images.aiModel3.path,
  ];
  int selectedFriendIndex = 0;
  List genderTypes = ["Female", "Male", "Non-Binary"];
  String selectedGenderType = "Female";
  TextEditingController friendName = TextEditingController();
  int selectedFriendAge = 18;
  String selectedPersonality = "";


  @override
  void initState() {
    super.initState();
    selectedPronouns = pronounsList.first;
    if(PrefService.instance.userProfile!=null){
_fillInitialValues();
    }
  }

  void nameValidationChecker(String value) {
    if (isContinueButtonEnable != value.isNotEmpty) {
      isContinueButtonEnable = value.isNotEmpty;
      notifyListeners();
    }
  }

  Future<void> onContinue() async {
    CommonFunc.vibrate();
    CommonFunc.closeKeyboard();
    if (MediaQuery.of(context).viewInsets.bottom != 0) {
      await Future.delayed(200.milliseconds);
    }
    if (currentStep == 7) {
      _createFriend();
      return;
    }
    currentStep += 1;
    if (currentStep == 3) {
      isContinueButtonEnable = selectedInterestsList.isNotEmpty;
    }
    pageController.animateToPage(currentStep, duration: 300.milliseconds, curve: Curves.easeIn);
    notifyListeners();
  }

  void onBack() {
    isContinueButtonEnable = true;
    currentStep -= 1;
    pageController.animateToPage(currentStep, duration: 300.milliseconds, curve: Curves.easeIn);
    notifyListeners();
  }

  void changePronouns(int index) {
    selectedPronouns = pronounsList[index];
    notifyListeners();
  }

  void changeDob(DateTime dateTime) {
    userDob = dateTime;
  }

  void handleInterestSelection(String value) {
    if (selectedInterestsList.contains(value)) {
      selectedInterestsList.remove(value);
    } else {
      selectedInterestsList.add(value);
    }
    isContinueButtonEnable = selectedInterestsList.isNotEmpty;
    notifyListeners();
  }

  void changeFriend(int index) {
    selectedFriendIndex = index;

    _scrollToCenter(index);
    notifyListeners();
  }

  void _scrollToCenter(int index) {
    const itemWidth = 78; // Width of each item
    final targetOffset = (itemWidth * (index)).toDouble();

    friendListScrollController.animateTo(
      targetOffset,
      duration: 300.milliseconds,
      curve: Curves.easeIn,
    );
  }

  void changeFriendInPageView(int index) {
    selectedFriendIndex = index;
    notifyListeners();
  }

  void changeGender(int index) {
    selectedGenderType = genderTypes[index];
    notifyListeners();
  }

  void changeFriendAge(int age) {
    selectedFriendAge = age;
    notifyListeners();
  }

  void selectFriendPersonality(String value) {
    selectedPersonality = value;
    notifyListeners();
  }

  void _createFriend() {
    prefService.setUserProfile = UserProfile(
        userName: nameController.text,
        userPronounce: selectedPronouns,
        userDob: userDob,
        userInterestList: selectedInterestsList,
        friendName: friendName.text,
        friendGender: selectedGenderType,
        friendAge: selectedFriendAge,
        friendPersonality: selectedPersonality,);

    prefService.addAiFriend = AiFriendData(profileImage:friendsList[selectedFriendIndex], name: friendName.text, age: selectedFriendAge, gender: selectedGenderType, personality: selectedPersonality,userName: nameController.text);

    _afterCreateFriend();
  }

  void _afterCreateFriend() {
    if(prefService.userProfile!=null){
      context.navigator.pushNamedAndRemoveUntil(DashboardScreen.routeName, (route) => false,);
    }else{

    context.navigator.pushReplacementNamed(DashboardScreen.routeName);
    }
    prefService.setInitialScreen = InitialScreenType.dashboard;
  }

  void _fillInitialValues() {
    final user = prefService.userProfile;
    nameController.text = user?.userName??"";
    selectedPronouns = user?.userPronounce??"";
    userDob = user?.userDob??DateTime.now();
    selectedInterestsList = [...user?.userInterestList??[]];
    friendName.text = user?.friendName??"";
    selectedGenderType = user?.friendGender??"";
    selectedFriendAge = user?.friendAge??18;
    selectedPersonality = user?.friendPersonality??"";
    isContinueButtonEnable = nameController.text.isNotEmpty;
  }



}
