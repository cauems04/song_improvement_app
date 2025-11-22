import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

// class AnalysisPage extends StatefulWidget {
//   const AnalysisPage({super.key});

//   @override
//   State<AnalysisPage> createState() => _AnalysisPageState();
// }

// class _AnalysisPageState extends State<AnalysisPage> {
//   int pitchValue = 0;
//   int rhytmValue = 0;
//   int dynamicsValue = 0;
//   int techniqueValue = 0;
//   int notationValue = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       appBar: AppBar(
//         leading: InkWell(
//           customBorder: CircleBorder(),
//           child: Padding(
//             padding: const EdgeInsets.all(8),
//             child: Icon(Icons.arrow_back),
//           ),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             SizedBox(
//               width: 120,
//               height: 40,
//               child: Material(
//                 borderRadius: BorderRadius.circular(5),
//                 color: Colors.amber[300],
//                 child: InkWell(
//                   onTap: () {},
//                   child: Center(
//                     child: Text(
//                       "Simplified analysis",
//                       textAlign: TextAlign.center,

//                       style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                         height: 1,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 120,
//               height: 40,
//               child: Material(
//                 borderRadius: BorderRadius.circular(5),
//                 color: Colors.grey[300],
//                 child: InkWell(
//                   onTap: () {},
//                   child: Center(
//                     child: Text(
//                       "Record Audio",
//                       textAlign: TextAlign.center,

//                       style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                         height: 1,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(
//           Spacing.lg,
//           Spacing.none,
//           Spacing.md,
//           Spacing.none,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Center(
//                 child: Text(
//                   "How well did you do?",
//                   style: Theme.of(context).textTheme.headlineLarge,
//                 ),
//               ),
//               _ScoreSelector(
//                 "Pitch",
//                 pitchValue,
//                 onTap: (value) {
//                   setState(() {
//                     pitchValue = value;
//                   });
//                 },
//               ),
//               _ScoreSelector(
//                 "Rhythm",
//                 rhytmValue,
//                 onTap: (value) {
//                   setState(() {
//                     rhytmValue = value;
//                   });
//                 },
//               ),
//               _ScoreSelector(
//                 "Dynamics",
//                 dynamicsValue,
//                 onTap: (value) {
//                   setState(() {
//                     dynamicsValue = value;
//                   });
//                 },
//               ),
//               _ScoreSelector(
//                 "Technique",
//                 techniqueValue,
//                 onTap: (value) {
//                   setState(() {
//                     techniqueValue = value;
//                   });
//                 },
//               ),
//               _ScoreSelector(
//                 "Notation",
//                 notationValue,
//                 onTap: (value) {
//                   setState(() {
//                     notationValue = value;
//                   });
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: Spacing.xxl, bottom: 80),
//                 child: _ConfirmButtom(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void updateValue() {}
// }

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  int pitchValue = 0;
  int rhytmValue = 0;
  int dynamicsValue = 0;
  int techniqueValue = 0;
  int notationValue = 0;

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
          Spacing.md,
          Spacing.none,
        ),
        child: Column(
          children: [
            Center(
              child: Text(
                "How well did you do?",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Expanded(
              child: PageView(
                controller: PageController(),
                children: [
                  AnalysisSection("Dynamics", selectedIndex: 1, onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateValue() {}
}

class _ScoreSelector extends StatefulWidget {
  final String label;
  final int selectedIndex;

  final Function(int highestScore) onTap;

  const _ScoreSelector(
    this.label,
    this.selectedIndex, {
    super.key,
    required this.onTap,
  });

  @override
  State<_ScoreSelector> createState() => _ScoreSelectorState();
}

class _ScoreSelectorState extends State<_ScoreSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: Spacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: Spacing.xs),
                  child: Text(
                    widget.label,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Icon(Icons.info, size: 20),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (n) {
              bool isFilled = false;

              if (widget.selectedIndex >= n) isFilled = true;

              return GestureDetector(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 120),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (isFilled)
                        ? Theme.of(context).colorScheme.onPrimary
                        : Colors.grey[850],
                  ),
                ),
                onTap: () => widget.onTap(n),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ConfirmButtom extends StatelessWidget {
  const _ConfirmButtom({super.key});

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
        onTap: () {},
      ),
    );
  }
}

class AnalysisSection extends StatelessWidget {
  final String label;
  final int selectedIndex;
  final Function() onTap;

  const AnalysisSection(
    this.label, {
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ScoreSelector(label, selectedIndex, onTap: (value) => onTap()),
        Expanded(
          child: DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.topCenter,
                    end: AlignmentGeometry.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.surfaceContainerLow,
                      Theme.of(context).colorScheme.surfaceContainerLowest,
                    ],
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: Spacing.sm,
                          bottom: 20,
                        ),
                        child: Text(
                          "What does it mean?",
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 300, // <-- define a área onde o texto centraliza
                      child: Center(
                        child: Text(
                          "Texto explicativo aqui... paksfbdivbdahibadbdasxbasocbacoacba db joB Dsbd SBDI ",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
