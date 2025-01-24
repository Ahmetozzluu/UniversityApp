import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: const Text(
          'Bildirimler',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Tüm bildirimleri okundu olarak işaretle
            },
            icon: const Icon(
              Icons.done_all,
              color: Colors.white,
            ),
            label: const Text(
              'Tümünü Okundu İşaretle',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationGroup(
            title: 'Yeni',
            notifications: [
              NotificationItem(
                title: 'Yeni Yorum',
                message: 'Boğaziçi Üniversitesi hakkında yeni bir yorum yapıldı.',
                time: '5 dakika önce',
                type: NotificationType.comment,
                isUnread: true,
              ),
              NotificationItem(
                title: 'Etkinlik Hatırlatması',
                message: 'Üniversite tanıtım günleri yarın başlıyor!',
                time: '30 dakika önce',
                type: NotificationType.event,
                isUnread: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildNotificationGroup(
            title: 'Bu Hafta',
            notifications: [
              NotificationItem(
                title: 'Favori Üniversite',
                message: 'İTÜ hakkında yeni bir duyuru yayınlandı.',
                time: '2 gün önce',
                type: NotificationType.favorite,
                isUnread: false,
              ),
              NotificationItem(
                title: 'Karşılaştırma',
                message: 'Karşılaştırma listenize yeni bir üniversite eklendi.',
                time: '3 gün önce',
                type: NotificationType.compare,
                isUnread: false,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildNotificationGroup(
            title: 'Daha Eski',
            notifications: [
              NotificationItem(
                title: 'Sistem Bildirimi',
                message: 'Profiliniz başarıyla güncellendi.',
                time: '1 hafta önce',
                type: NotificationType.system,
                isUnread: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationGroup({
    required String title,
    required List<NotificationItem> notifications,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        ...notifications.map((notification) => _buildNotificationCard(notification)),
      ],
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: notification.isUnread ? Colors.blue.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: notification.type.color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            notification.type.icon,
            color: notification.type.color,
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isUnread ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(notification.message),
            const SizedBox(height: 4),
            Text(
              notification.time,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: notification.isUnread
            ? Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: () {
          // Bildirime tıklandığında yapılacak işlemler
        },
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final NotificationType type;
  final bool isUnread;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.isUnread,
  });
}

enum NotificationType {
  comment(
    icon: Icons.comment_outlined,
    color: Colors.green,
  ),
  event(
    icon: Icons.event_outlined,
    color: Colors.orange,
  ),
  favorite(
    icon: Icons.favorite_outlined,
    color: Colors.red,
  ),
  compare(
    icon: Icons.compare_arrows,
    color: Colors.purple,
  ),
  system(
    icon: Icons.info_outlined,
    color: Colors.blue,
  );

  final IconData icon;
  final Color color;

  const NotificationType({
    required this.icon,
    required this.color,
  });
} 