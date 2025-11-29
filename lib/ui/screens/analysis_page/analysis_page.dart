import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/services/score_service.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/analysis_page/content/score_type.dart';
import 'package:guitar_song_improvement/ui/screens/analysis_page/widgets/score_bottom_sheet.dart';
import 'package:guitar_song_improvement/ui/screens/analysis_page/widgets/score_selector.dart';
import 'package:guitar_song_improvement/ui/screens/analysis_page/widgets/section_indicator.dart';
import 'package:guitar_song_improvement/ui/screens/analysis_result_page.dart/analysis_result_page.dart';
import 'package:provider/provider.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  late ScoreType currentScoreType;
  late Map<ScoreType, int> scoreValues;

  late bool isLastPage;

  final PageController pageController = PageController();

  @override
  void initState() {
    currentScoreType = ScoreType.values[0];
    scoreValues = {for (ScoreType type in ScoreType.values) type: 0};
    isLastPage = false;

    super.initState();
  }

  void submitScore() async {
    ScoreService scoreService = ScoreService(scoreValues);

    scoreService.calculateScore();

    await Provider.of<SelectedSongProvider>(
      context,
      listen: false,
    ).updateScore(scoreService.normalizedFinalScore);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            AnalysisResultPage(scoreService.normalizedFinalScore),
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
        child: Column(
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
                  controller: pageController,
                  children: [
                    for (ScoreType type in ScoreType.values)
                      ScoreSelector(
                        type.name,
                        initialPosition: scoreValues[type]!,
                        onTap: (value) => setState(() {
                          scoreValues[type] = value;
                        }),
                      ),
                  ],
                  onPageChanged: (value) {
                    setState(() {
                      currentScoreType = ScoreType.values[value];
                      isLastPage = (value == ScoreType.values.length - 1)
                          ? true
                          : false;
                    });
                  },
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
                        scoreValues[ScoreType.values[i]]!,
                        isSelected: currentScoreType == ScoreType.values[i],
                        onTap: () {
                          pageController.jumpToPage(i);
                        },
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 140),
              child: AnimatedOpacity(
                opacity: isLastPage ? 1 : 0,
                duration: Duration(milliseconds: 200),
                child: _SendButtom(() => submitScore()),
              ),
            ),
          ],
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
            builder: (context) => ScoreBottomSheet(currentScoreType),
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

class _PassPageButton extends StatelessWidget {
  final IconButton icon;
  const _PassPageButton(this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white),
      ),
      child: icon,
    );
  }
}
