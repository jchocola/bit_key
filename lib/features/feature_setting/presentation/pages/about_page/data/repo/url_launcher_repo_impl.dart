import 'package:bit_key/features/feature_setting/presentation/pages/about_page/domain/repo/url_launcher_repo.dart';
import 'package:bit_key/main.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherRepoImpl implements UrlLauncherRepo {
  @override
  Future<void> contactToDeveloper({required String developerEmail}) async {
    try {
      final Uri params = Uri(
        scheme: 'mailto',
        path: developerEmail,
        query:
            'subject=App Feedback&body=App Version 3.23', //add subject and body here
      );

      if (await canLaunchUrl(Uri.parse('mailto:$developerEmail'))) {
        await launchUrl(params);
      } else {
        logger.e('Could not launch');
      }
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<void> lauchURL({required String url}) async {
    try {
      final Uri uri = Uri.parse(url);
      await launchUrl(uri);
    } catch (e) {
      logger.e(e);
    }
  }
}
