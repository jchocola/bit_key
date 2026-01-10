import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/about_page/domain/repo/url_launcher_repo.dart';
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
          Text('О приложении', style: theme.textTheme.titleMedium,),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Версия'),
            subtitle: Text(AppConstant.appVersion),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Дата сборки'),
            subtitle: Text(AppConstant.buildDate),
          ),

          // ListTile(
          //   leading: Icon(Icons.code),
          //   title: Text('Версия API'),
          //   subtitle: Text('1.0.0'),
          // ),
          ListTile(
            leading: Icon(Icons.code),
            title: Text('Developer'),
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
          Text('Безопасность', style: theme.textTheme.titleMedium,),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Шифрование'),
            subtitle: Text('AES-256-GCM / ChaCha20-Poly1305'),
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('Хранение данных'),
            subtitle: Text('Локально на устройстве'),
          ),
          ListTile(
            leading: Icon(Icons.cloud_off),
            title: Text('Синхронизация'),
            subtitle: Text('Нет облачной синхронизации'),
          ),
          ListTile(
            leading: Icon(Icons.visibility_off),
            title: Text('Zero-knowledge'),
            subtitle: Text('Мы не имеем доступ к вашим паролям'),
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
          Text('Технические детали', style: theme.textTheme.titleMedium,),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('База данных'),
            subtitle: Text('Hive с шифрованием'),
          ),
          ListTile(
            leading: Icon(Icons.vpn_key),
            title: Text('Алгоритмы'),
            subtitle: Text('Argon2id, SHA-256, AES-256'),
          ),
          ListTile(
            leading: Icon(Icons.fingerprint),
            title: Text('Биометрия'),
            subtitle: Text('Face ID / Touch ID / Отпечаток пальца'),
          ),
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text('Платформа'),
            subtitle: Text('Flutter '),
          ),

          ListTile(
            onTap: ()async {
              await getIt<UrlLauncherRepo>().lauchURL(
                url: AppConstant.codeRepositoryUrl,
              ); 
            },
            leading: Icon(Icons.phone_android),
            title: Text('Open source'),
            subtitle: Text('code in github'),
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
          Text('Поддержка' , style: theme.textTheme.titleMedium,),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email поддержки'),
            subtitle: Text(AppConstant.developerEmail),
            onTap: () async {
              await getIt<UrlLauncherRepo>().contactToDeveloper(
                developerEmail: AppConstant.developerEmail,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text('Сообщить об ошибке'),
            onTap: () => {
              Wiredash.of(context).show(inheritMaterialTheme: true),
            },
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('Предложить функцию'),
            onTap: () => {
              Wiredash.of(context).show(inheritMaterialTheme: true),
            },
          ),
          ListTile(
            leading: Icon(Icons.rate_review),
            title: Text('Оценить приложение'),
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
          Text('Правовая информация' , style: theme.textTheme.titleMedium,),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Политика конфиденциальности'),
            onTap: () async {
              await getIt<UrlLauncherRepo>().lauchURL(
                url: AppConstant.privacyPolicyUrl,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.gavel),
            title: Text('Условия использования'),
            onTap: () async {
              await getIt<UrlLauncherRepo>().lauchURL(
                url: AppConstant.termOfServiceUrl,
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.copyright),
            title: Text('Авторские права'),
            subtitle: Text(AppConstant.copyRightUrl),
          ),
        ],
      ),
    );
  }
}
