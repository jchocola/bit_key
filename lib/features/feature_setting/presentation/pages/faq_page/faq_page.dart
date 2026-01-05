import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_bg.dart';
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
                Text('🔐 Безопасность и шифрование' , style: theme.textTheme.titleMedium,),
                _buildSecAndEncrypQA(context),
                Text('📱 Использование приложения',style: theme.textTheme.titleMedium,),
                _buildUseQA(context),
                Text('🗄️ Хранение и управление',style: theme.textTheme.titleMedium,),
                _buildStoreAndSavingQA(context),
                Text('🔄 Резервное копирование и восстановление',style: theme.textTheme.titleMedium,),
                _buildRestoreCopyQA(context),
                Text('💰 Цены и лицензии',style: theme.textTheme.titleMedium,),
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
      'q': 'Где хранятся мои пароли?',
      'a':
          'Все данные хранятся локально на вашем устройстве в зашифрованном виде. Мы не используем облачные серверы для хранения ваших паролей.',
    },
    {
      'q': 'Какое шифрование используется?',
      'a': """
  Мы используем :
    AES-256-GCM / ChaCha20-Poly1305 для шифрования данных
    Argon2id для защиты мастер-пароля
    SHA-256 для хеширования
    Все данные шифруются перед сохранением на устройстве.
""",
    },

    {
      'q': 'Что будет, если я забуду мастер-пароль?',
      'a':
          'К сожалению, восстановить доступ невозможно. Мастер-пароль не хранится на наших серверах и не может быть восстановлен. Мы следуем принципу "zero-knowledge" (нулевого знания).',
    },
    {
      'q': ' Безопасно ли использовать биометрию?',
      'a':
          ' Да, биометрия (Face ID/Touch ID/отпечаток) используется только для удобного доступа к уже расшифрованным данным. Мастер-ключ по-прежнему защищен вашим паролем.',
    },
  ];
}

List<Map<String, String>> getUseQAs(BuildContext context) {
  return [
    {'q': ' Как импортировать пароли из других менеджеров?', 'a': ''},
    {
      'q': ' Как создать резервную копию?',
      'a': """
1. Перейдите в Настройки → Безопасность → Экспорт данных
2. Выберите формат (рекомендуем .kdbx для KeePass)
3. Установите пароль для бэкапа
4. Сохраните файл в безопасное место
""",
    },
    {
      'q': 'Как синхронизировать между устройствами?',
      'a':
          'На данный момент синхронизация не поддерживается. Каждое устройство имеет свою независимую базу. Для переноса данных используйте функцию экспорта/импорта.',
    },
    {
      'q': ' Почему нет облачной синхронизации?',
      'a': """
Мы сознательно отказались от облачной синхронизации для:

Максимальной безопасности (данные никогда не покидают устройство)
Контроля пользователя (вы полностью владеете своими данными)
Отсутствия точек отказа (не зависит от интернета)
""",
    },
  ];
}

List<Map<String, String>> getStoreSavingQAs(BuildContext context) {
  return [
    {
      'q': ' Сколько паролей можно хранить?',
      'a':
          'Ограничений нет! Приложение оптимизировано для работы с тысячами записей. Все зависит от свободного места на вашем устройстве.',
    },

    {'q': 'Можно ли хранить файлы и документы?', 'a': 'No'},
    {
      'q': 'Как организовать пароли?',
      'a': """
Используйте:

Папки для категорий (Работа, Личное, Соцсети)
Теги для быстрого поиска
Избранное для часто используемых
Поиск по всем полям
""",
    },
    {'q': 'Есть ли история изменений паролей?', 'a': 'Нет'},
    {
      'q': ' Забыл мастер-пароль, что делать?',
      'a': """
К сожалению, без мастер-пароля доступ к данным невозможен. Вы можете:

Попробовать восстановить пароль из бэкапа
Создать новую базу (старые данные будут утеряны)
Использовать инструменты восстановления (если сохранили подсказку)
""",
    },
  ];
}

List<Map<String, String>> getRestoreCopyQAs(BuildContext context) {
  return [
    {
      'q': 'Как часто делать бэкапы?',
      'a': """
  Рекомендуем:

Еженедельно при активном использовании
Перед обновлением приложения
При добавлении важных данных
""",
    },
    {
      'q': 'Где хранить бэкапы?',
      'a': """
Рекомендуемые места:

Внешний USB-накопитель (самый безопасный)
Локальный компьютер (в зашифрованном разделе)
Несколько копий в разных местах
Не рекомендуется: публичные облака, email
""",
    },
    {
      'q': 'Можно ли зашифровать бэкап отдельным паролем?',
      'a':
          "Да! При экспорте вы можете установить отдельный пароль для бэкапа, который отличается от мастер-пароля.",
    },
    {'q': 'Что входит в бэкап?', 'a': 'Полная копия всех данных'},
  ];
}

List<Map<String, String>> getPriceLicenseQAs(BuildContext context) {
  return [
    {
      'q': 'Приложение бесплатное?',
      'a':
          'Да, полностью бесплатное без скрытых платежей. Мы верим, что безопасность должна быть доступна всем.',
    },
    {'q': 'Как вы зарабатываете?', 'a': 'Мы не зарабатываем на пользователях'},
    {
      'q': 'Есть ли платные функции?',
      'a':
          'Нет, все функции бесплатны. В будущем возможны премиум-функции для корпоративных пользователей, но базовый функционал останется бесплатным.',
    },
  ];
}
