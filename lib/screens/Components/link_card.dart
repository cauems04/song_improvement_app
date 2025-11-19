import 'dart:io' as ExternalLink;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/link.dart';
import 'package:guitar_song_improvement/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/screens/components/box_form.dart';
import 'package:guitar_song_improvement/screens/save_link_page.dart';
import 'package:guitar_song_improvement/services/google_favicon_service.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkCard extends StatelessWidget {
  final Link link;

  const LinkCard(this.link, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(
          Spacing.md,
          Spacing.xs,
          Spacing.xs,
          Spacing.xs,
        ),
        child: Material(
          child: InkWell(
            child: BoxForm(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: Spacing.sm),
                    child: _Favicon(link.url),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          link.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            link.url.toString(),
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (newContext) => ChangeNotifierProvider.value(
                            value: Provider.of<SelectedSongProvider>(context),
                            child: SaveLinkPage(link: link, isEditing: true),
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            onTap: () {
              _onLaunchUrl();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onLaunchUrl() async {
    if (!await launchUrl(link.url, mode: LaunchMode.externalApplication))
      throw Error(); // Implement custom error!!!!!!!!!!!!!!!
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
