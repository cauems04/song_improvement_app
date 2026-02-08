import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/link_controller.dart';
import 'package:guitar_song_improvement/data/model/link.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/form/save_link/view_models/results/form_results.dart';
import 'package:guitar_song_improvement/ui/screens/form/save_link/view_models/save_link_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/form/save_link/widgets/link_custom_text_form_field.dart';
import 'package:provider/provider.dart';

class SaveLinkScreen extends StatelessWidget {
  final SaveLinkViewmodel saveLinkVM = SaveLinkViewmodel(LinkController());

  SaveLinkScreen({super.key, Link? link, bool isEditing = false}) {
    saveLinkVM.init(link, isEditing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: InkWell(
          customBorder: CircleBorder(),
          child: Icon(Icons.close, color: Colors.white),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 600,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 100,
              right: Spacing.xl,
              left: Spacing.xl,
            ),
            child: Form(
              key: saveLinkVM.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Save Link",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  LinkCustomTextFormField(
                    "Title",
                    saveLinkVM.titleEditingController,
                    validation: (value) {
                      return saveLinkVM.validateField(value);
                    },
                  ),
                  LinkCustomTextFormField(
                    "External link",
                    saveLinkVM.urlEditingController,
                    validation: (value) {
                      return saveLinkVM.validateField(value);
                    },
                  ),
                  SizedBox(
                    height: 40,
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Save")],
                        ),
                        onTap: () async {
                          final FormResult result = await saveLinkVM.submitForm(
                            currentSongId: Provider.of<SelectedSongProvider>(
                              context,
                              listen: false,
                            ).currentSong.id,
                          );

                          if (!context.mounted) return;

                          //Implement personalized SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result.message)),
                          );

                          if (result is SuccessResult) {
                            Provider.of<SelectedSongProvider>(
                              context,
                              listen: false,
                            ).getLinks();
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
