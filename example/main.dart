// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_thirukural/flutter_thirukural.dart';

/// Example app demonstrating the flutter_thirukural package.
///
/// This example shows how to use the various widgets provided by
/// the flutter_thirukural package to display Thirukural content.
void main() {
  runApp(const ThirukuralExampleApp());
}

/// Main example application widget.
class ThirukuralExampleApp extends StatelessWidget {
  const ThirukuralExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thirukural Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9C1C1C),
        ),
      ),
      // Define routes for web navigation
      onGenerateRoute: _generateRoute,
      home: const ExampleHomePage(),
    );
  }

  /// Route generator for web navigation support.
  Route<dynamic>? _generateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '/');

    switch (uri.path) {
      case ThirukuralRoutes.allKurals:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AllThirukurals(),
        );

      case ThirukuralRoutes.kuralOfTheDay:
        final date = uri.queryParameters['date'] ?? _getTodayDate();
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ThirukuralOfTheDay(date: date),
        );

      case ThirukuralRoutes.kuralByNumber:
        final number = int.tryParse(uri.queryParameters['number'] ?? '1') ?? 1;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ThirukuralByNumber(kuralNumber: number),
        );

      case ThirukuralRoutes.kuralsInRange:
        final from = int.tryParse(uri.queryParameters['from'] ?? '1') ?? 1;
        final to = int.tryParse(uri.queryParameters['to'] ?? '10') ?? 10;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ThirukuralsInRange(from: from, to: to),
        );

      case ThirukuralRoutes.sectionNames:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ThirukuralBySectionNames(),
        );

      case ThirukuralRoutes.tamilChapters:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ThirukuralByTamilChapterNames(),
        );

      case ThirukuralRoutes.englishChapters:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ThirukuralByEnglishChapterNames(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ExampleHomePage(),
        );
    }
  }

  static String _getTodayDate() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
  }
}

/// Example home page with navigation to all widgets.
class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thirukural Examples'),
        backgroundColor: const Color(0xFF9C1C1C),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildExampleCard(
            context,
            title: 'Kural of the Day',
            description: 'Display the Thirukural for today or any date',
            icon: Icons.today,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ThirukuralOfTheDay(
                  date: _getTodayDate(),
                ),
              ),
            ),
          ),
          _buildExampleCard(
            context,
            title: 'Kural by Number',
            description: 'Find any Kural by its number (1-1330)',
            icon: Icons.search,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ThirukuralByNumber(kuralNumber: 1),
              ),
            ),
          ),
          _buildExampleCard(
            context,
            title: 'All Thirukurals',
            description: 'Browse all 1330 Kurals with pagination',
            icon: Icons.list,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AllThirukurals(),
              ),
            ),
          ),
          _buildExampleCard(
            context,
            title: 'Kurals in Range',
            description: 'View Kurals within a specific range',
            icon: Icons.straighten,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ThirukuralsInRange(from: 1, to: 10),
              ),
            ),
          ),
          _buildExampleCard(
            context,
            title: 'Browse by Sections',
            description: 'Explore Kurals by Paal (Section)',
            icon: Icons.folder,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ThirukuralBySectionNames(),
              ),
            ),
          ),
          _buildExampleCard(
            context,
            title: 'Tamil Chapters',
            description: 'Browse by Tamil Adhikaram names',
            icon: Icons.translate,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ThirukuralByTamilChapterNames(),
              ),
            ),
          ),
          _buildExampleCard(
            context,
            title: 'English Chapters',
            description: 'Browse by English chapter names',
            icon: Icons.language,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ThirukuralByEnglishChapterNames(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF9C1C1C),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  String _getTodayDate() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
  }
}
