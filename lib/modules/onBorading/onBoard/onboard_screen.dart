part of 'onboard.dart';

class OnboardScreen extends StatelessWidget {
  static const String routeName = "/onboard";

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider<OnboardProvider>(
      create: (context) => OnboardProvider(context: context),
      builder: (context, child) => const OnboardScreen(),
    );
  }

  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStep = context.select<OnboardProvider, int>(
      (value) => value.currentStep,
    );
    final provider = context.read<OnboardProvider>();
    final color = context.colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          provider.onBack();
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [

            Assets.images.background.image( fit: BoxFit.cover,height: context.height,width: context.width),

            // onboarding screen list
            _OnboardList(currentStep: currentStep),

            // gradient background

            if(currentStep!=5)...[
              Container(
                height: 130,
                width: context.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.surface,
                      color.surface.withOpacity(.8),
                      color.surface.withOpacity(0),
                    ],
                    stops: const [.6, .8, 1],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              // continue button
              const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ContinueButton(),
                  Gap(Spacing.xxLarge),
                ],
              ),
            ],




            // back button
            if (currentStep != 0) ...[
              Positioned(
                left: Spacing.normal,
                top: 60,
                child: CommonButton.cupertino(
                  onTap: provider.onBack,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(color: color.onSurface.withOpacity(.2), shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: color.primary,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
            if(PrefService.instance.userProfile!=null)...[
              Positioned(
                right: Spacing.normal,
                top: 60,
                child: CommonButton.cupertino(
                  onTap: () {
                    context.navigator.pop();
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(color: color.onSurface.withOpacity(.2), shape: BoxShape.circle),
                    child: Icon(
                      Icons.close,
                      color: color.primary,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class _OnboardList extends StatefulWidget {
  final int currentStep;

  const _OnboardList({required this.currentStep});

  @override
  State<_OnboardList> createState() => _OnboardListState();
}

class _OnboardListState extends State<_OnboardList> {
  List<Widget> onboardList = [
    const _EnterYourNameOnboardScreen(),
    const _YourPronounsScreen(),
    const _YourDobScreen(),
    const _YourInterestsScreen(),
    const _ChooseAiFriendScreen(),
    const _ChooseNameAndGenderScreen(),
    const _ChooseFriendAgeScreen(),
    const _ChooseFriendPersonalityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OnboardProvider>();
    return PageView.builder(
      controller: provider.pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: onboardList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return onboardList[index];
      },
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    final isEnable = context.select<OnboardProvider, bool>(
      (value) => value.isContinueButtonEnable,
    );
    final currentStep = context.select<OnboardProvider, int>(
      (value) => value.currentStep,
    );

    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      width: context.width * .8,
      decoration: isEnable
          ? BoxDecoration(
              borderRadius: ShapeBorderRadius.xxLarge,
              boxShadow: [
                BoxShadow(color: context.colorScheme.onSurface.withOpacity(.3), blurRadius: 7, spreadRadius: 3),
              ],
            )
          : null,
      child: FilledButton(
        onPressed: isEnable ? context.read<OnboardProvider>().onContinue : null,
        child: Text(
          currentStep==7? context.l10n.createYourAlFriend: context.l10n.continueText,
          style: context.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: context.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class _HeaderSpace extends StatelessWidget {
  const _HeaderSpace();

  @override
  Widget build(BuildContext context) {
    return const Gap(90);
  }
}
