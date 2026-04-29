import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/music_provider.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/rate_info.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/view_models/auto_analysis_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/widgets/confirm_send_modal.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/widgets/score_card.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/widgets/score_rate_box.dart';
import 'package:provider/provider.dart';

class AutoAnalysisScreen extends StatefulWidget {
  final int? recordLinkedId;
  const AutoAnalysisScreen({super.key, this.recordLinkedId});

  @override
  State<AutoAnalysisScreen> createState() => _AutoAnalysisScreenState();
}

class _AutoAnalysisScreenState extends State<AutoAnalysisScreen> {
  late final AutoAnalysisViewModel autoAnalysisVM;
  late final List<GlobalKey> boxKeys;

  @override
  void initState() {
    super.initState();
    autoAnalysisVM = AutoAnalysisViewModel();
    autoAnalysisVM.initValues(recordLinked: widget.recordLinkedId);
    autoAnalysisVM.addListener(_onViewModelChange);
    boxKeys = List.generate(5, (_) => GlobalKey());
  }

  void _onViewModelChange() {
    if (autoAnalysisVM.isLastCard) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showModalBottomSheet(
          context: context,
          constraints: BoxConstraints(maxHeight: 350),
          isDismissible: false,
          enableDrag: false,
          builder: (newContext) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: Provider.of<SelectedSongProvider>(context),
              ),
              ChangeNotifierProvider.value(
                value: Provider.of<MusicProvider>(context),
              ),
            ],
            child: Center(
              child: ConfirmSendModal(autoAnalysisVM: autoAnalysisVM),
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.surface, Colors.black87],
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            customBorder: CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.arrow_back, color: Colors.white60),
            ),
            onTap: () {
              Navigator.pop(context);
            },
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
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            for (int i = 0; i < RateType.values.length; i++)
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: Spacing.sm,
                                ),
                                child: ScoreRateBox(
                                  boxKey: boxKeys[i],
                                  rateType: RateType.values[i],
                                  autoAnalysisVM: autoAnalysisVM,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        final slideIn =
                            Tween<Offset>(
                              begin: const Offset(1.5, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOut,
                              ),
                            );

                        return SlideTransition(position: slideIn, child: child);
                      },
                      layoutBuilder: (currentChild, previousChildren) {
                        // descarta os filhos saindo — sem animação de saída
                        return currentChild ?? const SizedBox.shrink();
                      },
                      child:
                          (!autoAnalysisVM.isAnimatingCard &&
                              !autoAnalysisVM.isLastCard)
                          ? DraggableScoreCard(
                              key: ValueKey(autoAnalysisVM.currentScoreType),
                              scoreType: autoAnalysisVM.currentScoreType,
                            )
                          : const SizedBox.shrink(key: ValueKey('empty')),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
