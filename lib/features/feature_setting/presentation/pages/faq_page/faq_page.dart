import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstant.appPadding,
            vertical: AppConstant.appPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: AppConstant.appPadding,
              children: [
                Text(
                  context.tr(AppText.security_end_encryption),
                  style: theme.textTheme.titleMedium,
                ),
                _buildSecAndEncrypQA(context),
                Text(
                  context.tr(AppText.using_the_application),
                  style: theme.textTheme.titleMedium,
                ),
                _buildUseQA(context),
                Text(
                  context.tr(AppText.storage_and_management),
                  style: theme.textTheme.titleMedium,
                ),
                _buildStoreAndSavingQA(context),
                Text(
                  context.tr(AppText.backup_and_restore),
                  style: theme.textTheme.titleMedium,
                ),
                _buildRestoreCopyQA(context),
                Text(
                  context.tr(AppText.prices_and_licenses),
                  style: theme.textTheme.titleMedium,
                ),
                _buildPriceLicenceCopyQA(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecAndEncrypQA(BuildContext context) {
    final theme = Theme.of(context);
    final QAs = getSecurityAndEncryptionQAs(context);

    return FakeGlass(
      shape: LiquidRoundedRectangle(borderRadius: AppConstant.appBorder),
      child: Column(
        children: List.generate(QAs.length, (index) {
          final qa = QAs[index];

          return ExpansionTile(
            title: Text(qa['q'] ?? '', style: theme.textTheme.bodyMedium),
            children: [Text(qa['a'] ?? '', style: theme.textTheme.bodySmall)],
          );
        }),
      ),
    );
  }

  Widget _buildUseQA(BuildContext context) {
    final theme = Theme.of(context);
    final QAs = getUseQAs(context);

    return FakeGlass(
      shape: LiquidRoundedRectangle(borderRadius: AppConstant.appBorder),
      child: Column(
        children: List.generate(QAs.length, (index) {
          final qa = QAs[index];

          return ExpansionTile(
            title: Text(qa['q'] ?? '', style: theme.textTheme.bodyMedium),
            children: [Text(qa['a'] ?? '', style: theme.textTheme.bodySmall)],
          );
        }),
      ),
    );
  }

  Widget _buildStoreAndSavingQA(BuildContext context) {
    final theme = Theme.of(context);
    final QAs = getStoreSavingQAs(context);

    return FakeGlass(
      shape: LiquidRoundedRectangle(borderRadius: AppConstant.appBorder),
      child: Column(
        children: List.generate(QAs.length, (index) {
          final qa = QAs[index];

          return ExpansionTile(
            title: Text(qa['q'] ?? '', style: theme.textTheme.bodyMedium),
            children: [Text(qa['a'] ?? '', style: theme.textTheme.bodySmall)],
          );
        }),
      ),
    );
  }

  Widget _buildRestoreCopyQA(BuildContext context) {
    final theme = Theme.of(context);
    final QAs = getRestoreCopyQAs(context);

    return FakeGlass(
      shape: LiquidRoundedRectangle(borderRadius: AppConstant.appBorder),
      child: Column(
        children: List.generate(QAs.length, (index) {
          final qa = QAs[index];

          return ExpansionTile(
            title: Text(qa['q'] ?? '', style: theme.textTheme.bodyMedium),
            children: [Text(qa['a'] ?? '', style: theme.textTheme.bodySmall)],
          );
        }),
      ),
    );
  }

  Widget _buildPriceLicenceCopyQA(BuildContext context) {
    final theme = Theme.of(context);
    final QAs = getPriceLicenseQAs(context);

    return FakeGlass(
      shape: LiquidRoundedRectangle(borderRadius: AppConstant.appBorder),
      child: Column(
        children: List.generate(QAs.length, (index) {
          final qa = QAs[index];

          return ExpansionTile(
            title: Text(qa['q'] ?? '', style: theme.textTheme.bodyMedium),
            children: [Text(qa['a'] ?? '', style: theme.textTheme.bodySmall)],
          );
        }),
      ),
    );
  }
}

List<Map<String, String>> getSecurityAndEncryptionQAs(BuildContext context) {
  return [
    {
      'q': context.tr(AppText.security_end_encryption_q1),
      'a': context.tr(AppText.security_end_encryption_a1),
    },
    {
      'q': context.tr(AppText.security_end_encryption_q2),
      'a': context.tr(AppText.security_end_encryption_a2),
    },

    {
      'q': context.tr(AppText.security_end_encryption_q3),
      'a': context.tr(AppText.security_end_encryption_a3),
    },
    {
      'q': context.tr(AppText.security_end_encryption_q4),
      'a': context.tr(AppText.security_end_encryption_a4),
    },
  ];
}

List<Map<String, String>> getUseQAs(BuildContext context) {
  return [
    {'q': context.tr(AppText.using_the_application_q1), 'a':  context.tr(AppText.using_the_application_a1)},
    {
      'q':  context.tr(AppText.using_the_application_q2),
      'a':  context.tr(AppText.using_the_application_a2),
    },
    {
      'q':  context.tr(AppText.using_the_application_q3),
      'a':  context.tr(AppText.using_the_application_a3),
    },
    {
      'q':  context.tr(AppText.using_the_application_q4),
      'a': context.tr(AppText.using_the_application_a4),
    },
  ];
}

List<Map<String, String>> getStoreSavingQAs(BuildContext context) {
  return [
    {
      'q': context.tr(AppText.storage_and_management_q1),
      'a': context.tr(AppText.storage_and_management_a1),
    },

    {
      'q': context.tr(AppText.storage_and_management_q2),
      'a': context.tr(AppText.storage_and_management_a2),
    },
    {
      'q': context.tr(AppText.storage_and_management_q3),
      'a': context.tr(AppText.storage_and_management_a3),
    },
    {
      'q': context.tr(AppText.storage_and_management_q4),
      'a': context.tr(AppText.storage_and_management_a4),
    },
    {
      'q': context.tr(AppText.storage_and_management_q5),
      'a': context.tr(AppText.storage_and_management_a5),
    },
  ];
}

List<Map<String, String>> getRestoreCopyQAs(BuildContext context) {
  return [
    {
      'q': context.tr(AppText.backup_and_restore_q1),
      'a': context.tr(AppText.backup_and_restore_a1),
    },
    {
      'q': context.tr(AppText.backup_and_restore_q2),
      'a': context.tr(AppText.backup_and_restore_a2),
    },
    {
      'q': context.tr(AppText.backup_and_restore_q3),
      'a': context.tr(AppText.backup_and_restore_a3),
    },
    {
      'q': context.tr(AppText.backup_and_restore_q4),
      'a': context.tr(AppText.backup_and_restore_a4),
    },
  ];
}

List<Map<String, String>> getPriceLicenseQAs(BuildContext context) {
  return [
    {
      'q': context.tr(AppText.prices_and_licenses_q1),
      'a': context.tr(AppText.prices_and_licenses_a1),
    },
    {
      'q': context.tr(AppText.prices_and_licenses_q2),
      'a': context.tr(AppText.prices_and_licenses_a2),
    },
    {
      'q': context.tr(AppText.prices_and_licenses_q3),
      'a': context.tr(AppText.prices_and_licenses_a3),
    },
  ];
}
