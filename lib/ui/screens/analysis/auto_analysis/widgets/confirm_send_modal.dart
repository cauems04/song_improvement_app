import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/analysis.dart';
import 'package:guitar_song_improvement/data/model/music_provider.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/dark_theme.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/view_models/auto_analysis_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/result/analysis_result_screen.dart';
import 'package:provider/provider.dart';

class ConfirmSendModal extends StatefulWidget {
  final AutoAnalysisViewModel autoAnalysisVM;

  const ConfirmSendModal({super.key, required this.autoAnalysisVM});

  @override
  State<ConfirmSendModal> createState() => _ConfirmSendModalState();
}

class _ConfirmSendModalState extends State<ConfirmSendModal> {
  bool _submitted = false;

  Future<void> submitScore(BuildContext context) async {
    SelectedSongProvider selectedSongProvider =
        Provider.of<SelectedSongProvider>(context, listen: false);

    MusicProvider musicProvider = Provider.of<MusicProvider>(
      context,
      listen: false,
    );

    NavigatorState navigator = Navigator.of(context);

    Analysis analysisCreated = await selectedSongProvider.addAnalysis(
      widget.autoAnalysisVM.scoreValues,
      widget.autoAnalysisVM.recordLinked,
    );

    await musicProvider.getData();

    _submitted = true;
    navigator.pop();
    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => AnalysisResultScreen(analysisCreated),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          Spacing.lg,
          Spacing.xl,
          Spacing.lg,
          Spacing.md,
        ),
        decoration: BoxDecoration(
          color: DarkThemeColors.defaultModal,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.bar_chart_rounded,
              size: 50,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: Spacing.sm),
                  child: Text(
                    "Save Analysis?",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "You finished your analysis",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white60,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
              child: Row(
                children: [
                  _ResetButton(() => Navigator.of(context).pop()),
                  Expanded(child: _ConfirmButtom(() => submitScore(context))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (!_submitted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.autoAnalysisVM.resetValues();
      });
    }

    super.dispose();
  }
}

class _ConfirmButtom extends StatelessWidget {
  final VoidCallback action;

  const _ConfirmButtom(this.action);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Ink(
          height: 50,
          width: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.onPrimary,
              ],
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              "Save Analysis",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        onTap: () {
          action();
        },
      ),
    );
  }
}

class _ResetButton extends StatelessWidget {
  final VoidCallback action;

  const _ResetButton(this.action);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        child: Ink(
          height: 50,
          width: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(
                  context,
                ).colorScheme.surfaceContainerLowest.withAlpha(100),
                Theme.of(context).colorScheme.surfaceContainerLow,
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Center(child: Icon(Icons.replay_rounded, color: Colors.white)),
        ),
        onTap: () {
          action();
        },
      ),
    );
  }
}
