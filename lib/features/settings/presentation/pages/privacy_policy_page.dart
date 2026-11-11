import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Last updated: November 2024', style: textTheme.bodySmall?.copyWith(color: scheme.outline)),
          const SizedBox(height: 16),
          const _Section(
            title: 'Overview',
            body:
                'DueMate – Smart Reminder is an offline-first application. All data you enter — '
                'reminders, categories, and settings — is stored exclusively on your device. '
                'We do not collect, transmit, or share any personal information.',
          ),
          const _Section(
            title: 'Data We Collect',
            body:
                'We do not collect any data. The app has no internet connectivity, '
                'no analytics SDK, no crash reporting service, and no advertising network. '
                'Your reminders and preferences never leave your device unless you '
                'explicitly export a backup file using the Backup & Restore feature.',
          ),
          const _Section(
            title: 'Data Stored on Your Device',
            body: 'The following is stored locally in your device\'s private app storage:\n\n'
                '• Reminder details (title, due date, category, amount, recurrence)\n'
                '• Notification schedules\n'
                '• App preferences (theme, language, default currency)\n'
                '• Custom categories you create\n\n'
                'This data is only accessible to the DueMate app and is removed when you uninstall the app.',
          ),
          const _Section(
            title: 'Notifications',
            body:
                'DueMate uses Android\'s local notification system to send you reminder alerts. '
                'Notifications are generated entirely on-device and do not involve any external server or service.',
          ),
          const _Section(
            title: 'Backup & Export',
            body:
                'If you use the Backup & Restore feature, the exported file (JSON or CSV) contains '
                'your reminder data. You are solely responsible for the security of this file once exported. '
                'DueMate does not upload or store this file anywhere.',
          ),
          const _Section(
            title: 'Third-Party Services',
            body: 'DueMate does not use any third-party analytics, advertising, or tracking services.',
          ),
          const _Section(
            title: 'Children\'s Privacy',
            body:
                'DueMate does not knowingly collect data from anyone, including children under the age of 13. '
                'As no data is collected, there is no special handling required.',
          ),
          const _Section(
            title: 'Changes to This Policy',
            body:
                'If this privacy policy changes in a future version, the updated date at the top '
                'of this page will reflect the change. Significant changes will be noted in the app\'s '
                'update changelog.',
          ),
          const _Section(
            title: 'Contact',
            body: 'If you have any questions about this privacy policy, please contact:\n\n'
                'Email: mdnazimuddin77@gmail.com\n'
                'App: DueMate – Smart Reminder\n'
                'Package: com.fincrit.smartreminder',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleSmall?.copyWith(color: scheme.primary, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(body, style: textTheme.bodyMedium?.copyWith(height: 1.55)),
        ],
      ),
    );
  }
}
