import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/analysis_page/content/score_type.dart';
import 'package:guitar_song_improvement/ui/screens/analysis_page/widgets/score_bottom_sheet.dart';
import 'package:guitar_song_improvement/ui/screens/analysis_page/widgets/score_selector.dart';

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
//               ScoreSelector(
//                 "Pitch",
//                 pitchValue,
//                 onTap: (value) {
//                   setState(() {
//                     pitchValue = value;
//                   });
//                 },
//               ),
//               ScoreSelector(
//                 "Rhythm",
//                 rhytmValue,
//                 onTap: (value) {
//                   setState(() {
//                     rhytmValue = value;
//                   });
//                 },
//               ),
//               ScoreSelector(
//                 "Dynamics",
//                 dynamicsValue,
//                 onTap: (value) {
//                   setState(() {
//                     dynamicsValue = value;
//                   });
//                 },
//               ),
//               ScoreSelector(
//                 "Technique",
//                 techniqueValue,
//                 onTap: (value) {
//                   setState(() {
//                     techniqueValue = value;
//                   });
//                 },
//               ),
//               ScoreSelector(
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
            SizedBox(
              height: 350,
              width: 600,
              child: PageView(
                controller: PageController(),
                children: [
                  ScoreSelector(
                    ScoreType.pitch.name,
                    onTap: (value) {
                      pitchValue = value;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomSheet: Material(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: InkWell(
          child: Container(
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
            builder: (context) => ScoreBottomSheet(),
          ),
        ),
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
