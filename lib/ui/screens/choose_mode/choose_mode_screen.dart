import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/auto_analysis_screen.dart';
import 'package:guitar_song_improvement/ui/screens/choose_mode/view_model/choose_mode_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/choose_mode/widgets/option_card.dart';
import 'package:guitar_song_improvement/ui/screens/choose_mode/widgets/denied_permission_modal.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/record_audio_screen.dart';
import 'package:guitar_song_improvement/ui/screens/choose_mode/widgets/remember_choice_check_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ChooseModeScreen extends StatefulWidget {
  const ChooseModeScreen({super.key});

  @override
  State<ChooseModeScreen> createState() => _ChooseModeScreenState();
}

class _ChooseModeScreenState extends State<ChooseModeScreen> {
  late final ChooseModeViewmodel chooseModeVM;

  @override
  void initState() {
    super.initState();
    chooseModeVM = ChooseModeViewmodel();
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
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: chooseModeVM.isPlaySelected,
            builder: (context, value, child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Spacing.xs,
                      bottom: Spacing.xxl,
                    ),
                    child: Text(
                      "Select an option",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  OptionCard(
                    "Record audio",
                    "Play and listen before analysing your playing",
                    Icon(Icons.volume_up),
                    isSelected: (value),
                    onTap: () {
                      chooseModeVM.selectPlayOption();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Spacing.lg),
                    child: OptionCard(
                      "Do not record",
                      "Go straight to the analysis, without recording",
                      Icon(Icons.volume_up),
                      isSelected: (!value),
                      onTap: () {
                        chooseModeVM.unselectPlayOption();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Spacing.lg,
                      bottom: Spacing.lg,
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: chooseModeVM.rememberChoice,
                      builder: (context, value, child) {
                        return RememberCoiceCheckButtom(value, () {
                          chooseModeVM.toggleRememberChoice();
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: _ConfirmButtom(value),
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

class _ConfirmButtom extends StatelessWidget {
  final bool isPlayselected;
  const _ConfirmButtom(this.isPlayselected);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 50,
          width: 300,
          child: Center(
            child: Text(
              "Confirm",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        onTap: () async {
          if (isPlayselected) {
            PermissionStatus micPermissionStatus =
                await Permission.microphone.status;

            if (!context.mounted) return;

            if (micPermissionStatus.isDenied) {
              showDialog(
                context: context,
                builder: (context) => Center(child: DeniedPermissionModal()),
              );
            } else if (micPermissionStatus.isPermanentlyDenied) {
              showDialog(
                context: context,
                builder: (context) => Center(
                  child: DeniedPermissionModal(isPermanentlyDenied: true),
                ),
              );
            }

            micPermissionStatus = await Permission.microphone.status;

            if (micPermissionStatus.isGranted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => RecordAudioScreen()),
              );
            }
            return;
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (newContext) => ChangeNotifierProvider.value(
                value: Provider.of<SelectedSongProvider>(context),
                child: AutoAnalysisScreen(),
              ),
            ),
          );
        },
      ),
    );
  }
}
