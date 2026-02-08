import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/music_provider.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_type.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/view_models/auto_analysis_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/widgets/score_bottom_sheet.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/widgets/score_selector.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/widgets/section_indicator.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/result/analysis_result_screen.dart';
import 'package:provider/provider.dart';

class AutoAnalysisScreen extends StatefulWidget {
  final int? recordLinkedId;
  const AutoAnalysisScreen({super.key, this.recordLinkedId});

  @override
  State<AutoAnalysisScreen> createState() => _AutoAnalysisScreenState();
}

class _AutoAnalysisScreenState extends State<AutoAnalysisScreen> {
  late final AutoAnalysisViewModel autoAnalysisVM;

  @override
  void initState() {
    super.initState();
    autoAnalysisVM = AutoAnalysisViewModel();
    autoAnalysisVM.initValues();
  }

  Future<void> submitScore() async {
    autoAnalysisVM.calculateScore();

    final SelectedSongProvider selectedSongProvider =
        Provider.of<SelectedSongProvider>(context, listen: false);

    final MusicProvider musicProvider = Provider.of<MusicProvider>(
      context,
      listen: false,
    );

    final navigator = Navigator.of(context);

    await selectedSongProvider.updateScore(
      autoAnalysisVM.finalScore,
      widget.recordLinkedId,
    );

    await musicProvider.getData();

    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => AnalysisResultScreen(autoAnalysisVM.finalScore),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: InkWell(
          customBorder: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(Icons.arrow_back),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 120,
              height: 40,
              child: Material(
                borderRadius: BorderRadius.circular(5),
                color: Colors.amber[300],
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      "Simplified analysis",
                      textAlign: TextAlign.center,

                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 120,
              height: 40,
              child: Material(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300],
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      "Record Audio",
                      textAlign: TextAlign.center,

                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          Spacing.lg,
          Spacing.none,
          Spacing.lg,
          Spacing.none,
        ),
        child: ListenableBuilder(
          listenable: autoAnalysisVM,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Text(
                    "How well did you do?",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Spacing.xxl),
                  child: SizedBox(
                    height: 80,
                    width: 600,
                    child: PageView(
                      controller: autoAnalysisVM.pageController,
                      children: [
                        for (ScoreType type in ScoreType.values)
                          ScoreSelector(
                            type.name,
                            initialPosition: autoAnalysisVM.scoreValues[type]!,
                            onTap: (value) =>
                                autoAnalysisVM.selectScore(value, type),
                          ),
                      ],
                      onPageChanged: (value) =>
                          autoAnalysisVM.changePage(value),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: Spacing.xxl),
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (int i = 0; i < ScoreType.values.length; i++)
                          SectionIndicator(
                            autoAnalysisVM.scoreValues[ScoreType.values[i]]!,
                            isSelected:
                                autoAnalysisVM.currentScoreType ==
                                ScoreType.values[i],
                            onTap: () {
                              autoAnalysisVM.pageController.jumpToPage(i);
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 140),
                  child: AnimatedOpacity(
                    opacity: autoAnalysisVM.isLastPage ? 1 : 0,
                    duration: Duration(milliseconds: 200),
                    child: _SendButtom(() async => await submitScore()),
                  ),
                ),
              ],
            );
          },
        ),
      ),

      bottomSheet: Material(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: InkWell(
          child: SizedBox(
            height: 120,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: Spacing.md),
              child: Text(
                "What does it mean?",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (context) =>
                ScoreBottomSheet(autoAnalysisVM.currentScoreType),
          ),
        ),
      ),
    );
  }
}

class _SendButtom extends StatelessWidget {
  final Function() onTap;

  const _SendButtom(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 50,
          width: 150,
          child: Center(
            child: Text(
              "Send",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        onTap: () => onTap(),
      ),
    );
  }
}
