import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/about_page/domain/repo/url_launcher_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:wiredash/wiredash.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                aboutSection(context),
                securitySection(context),
                techSection(context),
                supportFeebackSection(context),
                pravicyPolicySection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget aboutSection(BuildContext context) {
    final theme = Theme.of(context);
    return FakeGlass(
      shape: LiquidRoundedRectangle(borderRadius: AppConstant.appBorder),
      child: Column(
        children: [
          Text(context.tr(AppText.about_app), style: theme.textTheme.titleMedium,),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(context.tr(AppText.version)),
            subtitle: Text(AppConstant.appVersion),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text(context.tr(AppText.build_date)),
            subtitle: Text(AppConstant.buildDate),
          ),

          // ListTile(
          //   leading: Icon(Icons.code),
          //   title: Text('Версия API'),
          //   subtitle: Text('1.0.0'),
          // ),
          ListTile(
            leading: Icon(Icons.code),
            title: Text(context.tr(AppText.developer)),
            subtitle: Text(AppConstant.developer),
          ),
        ],
      ),
    );
  }

  Widget securitySection(BuildContext context) {
      final theme = Theme.of(context);
    return FakeGlass(
      shape: LiquidRoundedRectangle(borderRadius: AppConstant.appBorder),
      child: Column(
        children: [
          Text(context.tr(AppText.security), style: theme.textTheme.titleMedium,),
          ListTile(
            leading: Icon(Icons.security),
            title: Text(context.tr(AppText.cipher)),
            subtitle: Text(context.tr(AppText.cipher_desc)),
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text(context.tr(AppText.saving_data)),
            subtitle: Text(context.tr(AppText.saving_data_desc)),
          ),
          ListTile(
            leading: Icon(Icons.cloud_off),
            title: Text(context.tr(AppText.synchronization)),
            subtitle: Text(context.tr(AppText.synchronization_desc)),
          ),
          ListTile(
            leading: Icon(Icons.visibility_off),
            title: Text(context.tr(AppText.zero_knowledge)),
            subtitle: Text(context.tr(AppText.zero_knowledge_desc)),
          ),
        ],
      ),
    );
  }

  Widget techSection(BuildContext context) {
      final theme = Theme.of(context);
    return FakeGlass(
      shape: LiquidRoundedRectangle(borderRadius: AppConstant.appBorder),
      child: Column(
        children: [
          Text(context.tr(AppText.technical_details), style: theme.textTheme.titleMedium,),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text(context.tr(AppText.database)),
            subtitle: Text(context.tr(AppText.database_desc)),
          ),
          ListTile(
            leading: Icon(Icons.vpn_key),
            title: Text(context.tr(AppText.algorithm)),
            subtitle: Text(context.tr(AppText.algorithm_desc)),
          ),
          ListTile(
            leading: Icon(Icons.fingerprint),
            title: Text(context.tr(AppText.biometric)),
            subtitle: Text(context.tr(AppText.biometric_desc)),
          ),
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text(context.tr(AppText.platform)),
            subtitle: Text(context.tr(AppText.platform_desc)),
          ),

          ListTile(
            onTap: ()async {
              await getIt<UrlLauncherRepo>().lauchURL(
                url: AppConstant.codeRepositoryUrl,
              ); 
            },
            leading: Icon(Icons.phone_android),
            title: Text(context.tr(AppText.open_source)),
            subtitle: Text(context.tr(AppText.open_source_desc)),
          ),
        ],
      ),
    );
  }

  Widget supportFeebackSection(BuildContext context) {
      final theme = Theme.of(context);
    return FakeGlass(
      shape: LiquidRoundedRectangle(borderRadius: AppConstant.appBorder),
      child: Column(
        children: [
          Text(context.tr(AppText.support) , style: theme.textTheme.titleMedium,),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(context.tr(AppText.email_support)),
            subtitle: Text(AppConstant.developerEmail),
            onTap: () async {
              await getIt<UrlLauncherRepo>().contactToDeveloper(
                developerEmail: AppConstant.developerEmail,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text(context.tr(AppText.bugs_report)),
            onTap: () => {
              Wiredash.of(context).show(inheritMaterialTheme: true),
            },
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text(context.tr(AppText.propose_idea)),
            onTap: () => {
              Wiredash.of(context).show(inheritMaterialTheme: true),
            },
          ),
          ListTile(
            leading: Icon(Icons.rate_review),
            title: Text(context.tr(AppText.rate_app)),
            onTap: () async {
              await getIt<UrlLauncherRepo>().lauchURL(
                url: AppConstant.rustoreUrl,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget pravicyPolicySection(BuildContext context) {
      final theme = Theme.of(context);
    return FakeGlass(
      shape: LiquidRoundedRectangle(borderRadius: AppConstant.appBorder),
      child: Column(
        children: [
          Text(context.tr(AppText.legal_info) , style: theme.textTheme.titleMedium,),
          ListTile(
            leading: Icon(Icons.description),
            title: Text(context.tr(AppText.privacy_policy)),
            onTap: () async {
              await getIt<UrlLauncherRepo>().lauchURL(
                url: AppConstant.privacyPolicyUrl,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.gavel),
            title: Text(context.tr(AppText.term_service)),
            onTap: () async {
              await getIt<UrlLauncherRepo>().lauchURL(
                url: AppConstant.termOfServiceUrl,
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.copyright),
            title: Text(context.tr(AppText.copy_right)),
            subtitle: Text(AppConstant.copyRightUrl),
          ),
        ],
      ),
    );
  }
}
