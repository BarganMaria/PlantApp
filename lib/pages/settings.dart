import 'package:flutter/material.dart';
import '../widgets/flower_background.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top + kToolbarHeight + 12;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Profil si setari'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: FlowerBackground()),
          ListView(
            padding: EdgeInsets.fromLTRB(20, topInset, 20, 20),
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFF3E8FB),
                    child: Icon(Icons.person, color: Color(0xFFC57AE6)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Elena', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      Text('Incepator • Chisinau'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _SettingsTile(title: 'Notificari', subtitle: 'Mementouri, quiz, sfaturi', trailing: Switch(value: true, onChanged: (_) {})),
              _SettingsTile(title: 'Limba', subtitle: 'Romana / Engleza / Rusa', trailing: const Icon(Icons.chevron_right)),
              _SettingsTile(title: 'Unitati', subtitle: 'Celsius', trailing: const Icon(Icons.chevron_right)),
              _SettingsTile(title: 'Utilizare date', subtitle: 'Descarca doar prin WiFi', trailing: const Icon(Icons.chevron_right)),
              _SettingsTile(title: 'Afiseaza numele stiintifice', subtitle: 'Activat', trailing: Switch(value: true, onChanged: (_) {})),
              const SizedBox(height: 16),
              Text('Despre', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              _SettingsTile(title: 'Versiune aplicatie', subtitle: '1.0.0', trailing: const Icon(Icons.info_outline)),
              _SettingsTile(title: 'Politica de confidentialitate', subtitle: '', trailing: const Icon(Icons.chevron_right)),
              _SettingsTile(title: 'Termeni de utilizare', subtitle: '', trailing: const Icon(Icons.chevron_right)),
              _SettingsTile(title: 'Contact si feedback', subtitle: '', trailing: const Icon(Icons.chevron_right)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget trailing;
  const _SettingsTile({
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyLarge),
                if (subtitle.isNotEmpty)
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}



