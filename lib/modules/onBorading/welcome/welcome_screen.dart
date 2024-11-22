part of 'welcome.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = "/welcome";

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider<WelcomeProvider>(
      create: (context) => WelcomeProvider(context: context),
      builder: (context, child) =>  const WelcomeScreen(),
    );
  }

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme;
    final fontStyle = context.textTheme;
    return Scaffold(
      body: Consumer<WelcomeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const SizedBox.shrink();
          }
          return Stack(
            children: [
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    height: provider.videoPlayerController?.value.size.height,
                    width: provider.videoPlayerController?.value.size.width,
                    child: VideoPlayer(
                      provider.videoPlayerController!,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 150 + context.padding.top,
                    width: 500,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.primary.withOpacity(.95),
                          color.primary.withOpacity(.7),
                          color.primary.withOpacity(.4),
                          color.primary.withOpacity(.1),
                          color.primary.withOpacity(.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Text(
                      context.l10n.genesiaAi,
                      style: fontStyle.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 5,
                        fontSize: 40,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: context.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.primary,
                          color.primary.withOpacity(.7),
                          color.primary.withOpacity(.5),
                          color.primary.withOpacity(.3),
                          color.primary.withOpacity(.0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [.6,.8,.88,.93,1]
                      ),
                    ),
                    child: Column(
                      children: [
                        const Gap(80),
                        Text(
                          context.l10n.theAlFriendWhoIsnalwaysThereForYou,
                          style: fontStyle.headlineMedium?.copyWith(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(Spacing.xxxLarge),
                        Container(
                          height: 55,
                          width: context.width * .75,
                          decoration: BoxDecoration(
                            borderRadius: ShapeBorderRadius.xxLarge,
                            boxShadow: [
                              BoxShadow(color: color.onSurface.withOpacity(.3), blurRadius: 7, spreadRadius: 3),
                            ],
                          ),
                          child: FilledButton(
                            onPressed: provider.onStart,
                            child: Text(
                              context.l10n.letsStart,
                              style: fontStyle.labelMedium?.copyWith(color: color.surface, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        const Gap(Spacing.large),
                        Text(
                          context.l10n.bySigningUpYouAgreeToOur,
                          style: fontStyle.bodySmall?.copyWith(color: color.onSurfaceVariant),
                        ),
                        RichText(
                          text: TextSpan(
                            text: context.l10n.termsOfService,
                            style: fontStyle.labelSmall?.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                            children: [
                              TextSpan(text: " ${context.l10n.and} ", style: fontStyle.labelSmall?.copyWith(color: color.onSurfaceVariant)),
                               TextSpan(text: context.l10n.privacyPolicy,),
                            ],
                          ),
                        ),
                        const Gap(60)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
