import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enums/language_enum.dart';
import '../bloc/setting_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseLanguageBottomSheet extends StatelessWidget {
  const ChooseLanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => showLanguageBottomSheet(context),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: BlocSelector<SettingsBloc, SettingState, (String, AssetImage)>(
              selector: (state) => (state.selectedLanguage.text, state.selectedLanguage.flag),
              builder: (context, language) {
                final name = language.$1;
                final flag = language.$2;
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      // child: ClipOval(
                      // child: Text(
                      //   state.selectedLanguage.flag,
                      //   style: TextStyle(fontSize: 30),
                      // ),
                      child: Image(
                        image: flag,
                        height: 30,
                      ),
                    ),
                    Text(name),
                  ],
                );
              },
            ),
          ),
          const Icon(
            Icons.arrow_drop_down_rounded,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.chooseLanguage,
              ),
              const SizedBox(height: 16.0),
              BlocBuilder<SettingsBloc, SettingState>(
                builder: (context, state) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: Language.values.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          // Trigger the ChangeLanguage event
                          context.read<SettingsBloc>().add(
                                ChangeLanguagePressed(selectedLanguage: Language.values[index]),
                              );
                          Future.delayed(const Duration(milliseconds: 300)).then((value) => Navigator.of(context).pop());
                        },
                        // leading: ClipOval(child: Text(Language.values[index].flag, style: TextStyle(fontSize: 30))),
                        leading: Image(image: Language.values[index].flag, height: 30),
                        title: Text(Language.values[index].text, style: const TextStyle(fontSize: 16)),
                        trailing: Language.values[index] == state.selectedLanguage
                            ? const Icon(
                                Icons.check_circle_rounded,
                                color: Colors.red,
                              )
                            : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: Language.values[index] == state.selectedLanguage
                              ? const BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                )
                              : BorderSide(
                                  color: Colors.grey[500]!,
                                ),
                        ),
                        tileColor: Language.values[index] == state.selectedLanguage ? Colors.red.withOpacity(0.05) : null,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16.0);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
