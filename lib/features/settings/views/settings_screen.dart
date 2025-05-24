import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliance/l10n/app_localizations.dart';
import '../controllers/settings_controller.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_text_styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SettingsController>(context, listen: false).loadTokens();
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final SettingsController settingsController = context
        .watch<SettingsController>();

    return Scaffold(
      appBar: AppBar(title: Text(localizations.secureStorageTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              localizations.authTokensSection,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              '${localizations.authTokenLabel} ${settingsController.currentAuthToken != null ? '****${settingsController.currentAuthToken!.substring(settingsController.currentAuthToken!.length - 4)}' : 'None'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '${localizations.refreshTokenLabel} ${settingsController.currentRefreshToken != null ? '****${settingsController.currentRefreshToken!.substring(settingsController.currentRefreshToken!.length - 4)}' : 'None'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _tokenController,
              decoration: InputDecoration(
                labelText: localizations.enterNewTokenHint,
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            AppButton(
              text: localizations.storeTokensButton,
              onPressed: () async {
                if (_tokenController.text.isNotEmpty) {
                  await settingsController.storeDummyTokens(
                    _tokenController.text,
                  );
                  _showSnackBar(localizations.storeTokensButton);
                } else {
                  _showSnackBar(localizations.enterNewTokenHint);
                }
              },
            ),
            AppButton(
              text: localizations.clearTokensButton,
              onPressed: () async {
                await settingsController.clearAllTokens();
                _showSnackBar(localizations.clearTokensButton);
              },
            ),
            const SizedBox(height: 30),
            Text(
              localizations.appTheme,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ChoiceChip(
                  label: Text(localizations.systemTheme),
                  selected:
                      settingsController.currentThemeMode == ThemeMode.system,
                  onSelected: (selected) {
                    if (selected)
                      settingsController.setThemeMode(ThemeMode.system);
                  },
                ),
                ChoiceChip(
                  label: Text(localizations.lightTheme),
                  selected:
                      settingsController.currentThemeMode == ThemeMode.light,
                  onSelected: (selected) {
                    if (selected)
                      settingsController.setThemeMode(ThemeMode.light);
                  },
                ),
                ChoiceChip(
                  label: Text(localizations.darkTheme),
                  selected:
                      settingsController.currentThemeMode == ThemeMode.dark,
                  onSelected: (selected) {
                    if (selected)
                      settingsController.setThemeMode(ThemeMode.dark);
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              localizations.securityReminderBackend,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              localizations.securityReminderSensitiveData,
              style: AppTextStyles.errorLight.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
