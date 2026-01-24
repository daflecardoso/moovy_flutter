import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/di.dart';
import 'package:moovy/main_cubit.dart';
import 'package:moovy/settings/settings_cubit.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final formKey = GlobalKey<ShadFormState>();
  double maxWidth = 400;
  final cubit = SettingsCubit(getIt.get(), getIt.get(), getIt.get(), getIt.get())..setup();

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    return Scaffold(
      appBar: AppBar(title: Text('Settings', style: ShadTheme.of(context).textTheme.large)),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        bloc: cubit,
        builder: (context, state) {
          switch (state) {
            case SettingsInitial():
              return SizedBox.shrink();
            case SettingsForm():
              return ShadForm(
                key: formKey,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShadSelectFormField<String>(
                          id: 'currency',
                          initialValue: state.currency.code,
                          label: Text('Currency'),
                          minWidth: maxWidth,
                          placeholder: const Text('Select a currency'),
                          options: [...state.currencies.map((e) => ShadOption(value: e.code, child: Text(e.title)))],
                          selectedOptionBuilder: (context, value) =>
                              Text(state.currencies.firstWhere((e) => e.code == value).title),
                          onChanged: print,
                        ),
                        ShadSelectFormField<String>(
                          id: 'language',
                          label: Text('Language'),
                          itemCount: state.languages.length,
                          initialValue: state.language.locale.toString(),
                          minWidth: maxWidth,
                          placeholder: const Text('Select a language'),
                          optionsBuilder: (context, index) {
                            return ShadOption(
                              value: state.languages[index].locale.toString(),
                              child: Text(state.languages[index].title),
                            );
                          },
                          selectedOptionBuilder: (context, value) =>
                              Text(state.languages.firstWhere((l) => l.locale.toString() == value).title),
                          onChanged: print,
                        ),
                        ShadSelectFormField<String>(
                          initialValue: state.theme.themeMode.name,
                          id: 'theme',
                          label: Text('Theme'),
                          minWidth: maxWidth,
                          placeholder: const Text('Select a theme'),
                          options: [
                            ...state.themes.map((e) => ShadOption(value: e.themeMode.name, child: Text(e.title))),
                          ],
                          selectedOptionBuilder: (context, value) =>
                              Text(state.themes.firstWhere((e) => e.themeMode.name == value).title),
                          onChanged: print,
                        ),
                        Row(
                          spacing: 16,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ShadButton(
                              child: const Text('Save'),
                              onPressed: () async {
                                if (formKey.currentState!.saveAndValidate()) {
                                  debugPrint('validation succeeded with ${formKey.currentState!.value}');
                                  await cubit.save(formKey.currentState!.value);
                                  mainCubit.setup();
                                  _toast();
                                } else {
                                  debugPrint('validation failed');
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }

  _toast() {
    ShadToaster.of(context).show(
      ShadToast(

        title: const Text('Success'),
        description:
        const Text('Changes was updated'),
      ),
    );
  }
}
