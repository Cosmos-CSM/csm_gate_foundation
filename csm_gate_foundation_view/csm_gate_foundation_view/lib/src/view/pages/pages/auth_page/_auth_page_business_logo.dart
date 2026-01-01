part of 'auth_page.dart';

///
final class _AuthPageBusinessLogo extends StatelessWidget with ThemingMixin {
  ///
  const _AuthPageBusinessLogo();

  @override
  Widget build(BuildContext context) {
    IGateFoundationViewTheme theme = getTheme(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 350),
        child: AspectRatio(
          aspectRatio: 1 / .75,
          child: Image(
            isAntiAlias: true,
            filterQuality: FilterQuality.high,
            image: AssetImage(theme.loginBusinessLogo),
          ),
        ),
      ),
    );
  }
}
