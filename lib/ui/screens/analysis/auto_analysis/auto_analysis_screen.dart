import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/analysis.dart';
import 'package:guitar_song_improvement/data/model/music_provider.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/rate_info.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/view_models/auto_analysis_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/widgets/score_card.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/widgets/score_rate_box.dart';
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
    try {
      final SelectedSongProvider selectedSongProvider =
          Provider.of<SelectedSongProvider>(context, listen: false);

      final MusicProvider musicProvider = Provider.of<MusicProvider>(
        context,
        listen: false,
      );

      final navigator = Navigator.of(context);

      // await selectedSongProvider.updateScore(
      //   autoAnalysisVM.finalScore,
      //   widget.recordLinkedId,
      // );

      Analysis analysisCreated = await selectedSongProvider.addAnalysis(
        autoAnalysisVM.scoreValues,
        widget.recordLinkedId,
      );

      await musicProvider.getData();

      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              AnalysisResultScreen(analysisCreated.getFinalScore),
        ),
      );
    } catch (e) {
      print(e);
    }
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Spacing.lg,
            Spacing.none,
            Spacing.lg,
            Spacing.none,
          ),
          child: ListenableBuilder(
            listenable: autoAnalysisVM,
            builder: (context, child) {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          for (RateType rateType in RateType.values)
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Spacing.sm,
                              ),
                              child: ScoreRateBox(rateType: rateType),
                            ),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //     top: 20,
                      //     bottom: Spacing.xxl,
                      //   ),
                      //   child: SizedBox(
                      //     height: 100,
                      //     width: double.infinity,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       crossAxisAlignment: CrossAxisAlignment.end,
                      //       children: [
                      //         for (int i = 0; i < ScoreType.values.length; i++)
                      //           SectionIndicator(
                      //             autoAnalysisVM.scoreValues[ScoreType
                      //                 .values[i]]!,
                      //             isSelected:
                      //                 autoAnalysisVM.currentScoreType ==
                      //                 ScoreType.values[i],
                      //             onTap: () {
                      //               autoAnalysisVM.pageController.jumpToPage(i);
                      //             },
                      //           ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: Spacing.md),
                        child: AnimatedOpacity(
                          opacity: autoAnalysisVM.isLastPage ? 1 : 0.2,
                          duration: Duration(milliseconds: 200),
                          child: _SendButtom(() async => await submitScore()),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: DraggableScoreCard(
                      scoreType: autoAnalysisVM.currentScoreType,
                    ),
                  ),
                ],
              );
            },
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
