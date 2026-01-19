import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/auto_analysis_screen.dart';
import 'package:guitar_song_improvement/ui/screens/choose_mode/widgets/denied_permission_modal.dart';
import 'package:guitar_song_improvement/ui/screens/record_audio/record_audio_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ChooseModeScreen extends StatefulWidget {
  const ChooseModeScreen({super.key});

  @override
  State<ChooseModeScreen> createState() => _ChooseModeScreenState();
}

class _ChooseModeScreenState extends State<ChooseModeScreen> {
  bool isPlayselected = true;
  bool rememberChoice = false;

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
          child: Column(
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
                isSelected: (isPlayselected),
                onTap: () {
                  if (!isPlayselected) {
                    setState(() => isPlayselected = true);
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: Spacing.lg),
                child: OptionCard(
                  "Do not record",
                  "Go straight to the analysis, without recording",
                  Icon(Icons.volume_up),
                  isSelected: (!isPlayselected),
                  onTap: () {
                    if (isPlayselected) {
                      setState(() => isPlayselected = false);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: Spacing.lg,
                  bottom: Spacing.lg,
                ),
                child: RememberCoiceCheckButtom(rememberChoice, () {
                  setState(() {
                    rememberChoice = !rememberChoice;
                  });
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: _ConfirmButtom(isPlayselected),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final Icon icon;
  final String label;
  final String description;
  final bool isSelected;
  final Function() onTap;

  const OptionCard(
    this.label,
    this.description,
    this.icon, {
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        padding: EdgeInsets.all(Spacing.sm),
        duration: Duration(milliseconds: 200),
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          border: BoxBorder.all(
            width: (isSelected) ? 4 : 2,
            color: (isSelected)
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.surfaceContainerLow,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            Align(
              alignment: AlignmentGeometry.topRight,
              child: AnimatedOpacity(
                opacity: (isSelected) ? 1 : 0,
                duration: Duration(milliseconds: 200),
                child: Icon(Icons.check_circle, color: Colors.lightGreenAccent),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        onTap();
      },
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

class RememberCoiceCheckButtom extends StatelessWidget {
  final Function() onTap;
  final bool rememberChoice;

  const RememberCoiceCheckButtom(this.rememberChoice, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          child: rememberChoice
              ? Icon(Icons.check_box, size: 30, color: Colors.lightGreenAccent)
              : Icon(Icons.check_box_outline_blank, size: 30),
          onTap: () => onTap(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: Spacing.md),
          child: Text(
            "Remember choice",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
