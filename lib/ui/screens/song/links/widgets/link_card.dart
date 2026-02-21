import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/link.dart';
import 'package:guitar_song_improvement/data/services/google_favicon_service.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkCard extends StatelessWidget {
  final Link link;
  const LinkCard(this.link, {super.key});

  Future<void> _launchUrl() async {
    // Threat for when it's not a link, cause it can throw an error
    if (!await launchUrl(link.url, mode: LaunchMode.externalApplication)) {
      throw Error(); // Implement custom error!!!!!!!!!!!!!!!
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(
        context,
      ).colorScheme.surfaceContainerLowest.withAlpha(100),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.surface),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => _launchUrl(),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Spacing.sm),
                child: Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100]!.withAlpha(40),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: _Favicon(link.url),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      link.title,
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      link.url.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.open_in_new, color: Colors.white70, size: 14),
            ],
          ),
        ),
      ),
    );
  }
}

class _Favicon extends StatelessWidget {
  final Uri url;
  const _Favicon(this.url);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GoogleFaviconService.searchFavicon(url),
      builder: (context, snapshot) {
        Widget resultWidget = Icon(Icons.link, size: 32);

        if (snapshot.connectionState == ConnectionState.waiting) {
          resultWidget = _FaviconLoadingAnimation();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            resultWidget = Image.memory(snapshot.data!);
          }
        }

        return resultWidget;
      },
    );
  }
}

class _FaviconLoadingAnimation extends StatefulWidget {
  const _FaviconLoadingAnimation();

  @override
  State<_FaviconLoadingAnimation> createState() =>
      _FaviconLoadingAnimationState();
}

class _FaviconLoadingAnimationState extends State<_FaviconLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController opacityController;

  @override
  void initState() {
    opacityController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
      lowerBound: 0.2,
      upperBound: 0.6,
    );

    opacityController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityController,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surfaceContainerLow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    opacityController.dispose();
    super.dispose();
  }
}
