import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:flutter/material.dart';

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
                aboutSection(),
                securitySection(),
                techSection(),
                supportFeebackSection(),
                pravicyPolicySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget aboutSection() {
    return Column(
      children: [
        Text('О приложении'),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('Версия'),
          subtitle: Text(' (build )'),
        ),
        ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text('Дата сборки'),
          subtitle: Text('2024-01-15'),
        ),
        ListTile(
          leading: Icon(Icons.code),
          title: Text('Версия API'),
          subtitle: Text('1.0.0'),
        ),
      ],
    );
  }

  Widget securitySection() {
    return Column(
      children: [
        Text('Безопасность'),
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
    );
  }

  Widget techSection() {
    return Column(
      children: [
        Text('Технические детали'),
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
      ],
    );
  }

  Widget supportFeebackSection() {
    return Column(
      children: [
        Text('Поддержка'),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('Email поддержки'),
          subtitle: Text('support@bitkey.app'),
          // onTap: () => _launchEmail(),
        ),
        ListTile(
          leading: Icon(Icons.bug_report),
          title: Text('Сообщить об ошибке'),
          // onTap: () => _openBugReport(),
        ),
        ListTile(
          leading: Icon(Icons.lightbulb),
          title: Text('Предложить функцию'),
          //onTap: () => _openFeatureRequest(),
        ),
        ListTile(
          leading: Icon(Icons.rate_review),
          title: Text('Оценить приложение'),
          //onTap: () => _rateApp(),
        ),
      ],
    );
  }

  Widget pravicyPolicySection() {
    return Column(
     
      children: [
        Text('Правовая информация'),
        ListTile(
          leading: Icon(Icons.description),
          title: Text('Политика конфиденциальности'),
          //onTap: () => _openPrivacyPolicy(),
        ),
        ListTile(
          leading: Icon(Icons.gavel),
          title: Text('Условия использования'),
          //onTap: () => _openTerms(),
        ),
      
        ListTile(
          leading: Icon(Icons.copyright),
          title: Text('Авторские права'),
          subtitle: Text('© 2024 BitKey. Все права защищены.'),
        ),
      ],
    );
  }
}
