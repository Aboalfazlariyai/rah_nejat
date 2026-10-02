import 'package:flutter/material.dart';

void main() {
  runApp(const RahNejatApp());
}

class RahNejatApp extends StatelessWidget {
  const RahNejatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'راه نجات',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF176B3A),
        scaffoldBackgroundColor: const Color(0xFFF7F9F5),
        fontFamily: 'sans',
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'احادیث',
      'icon': Icons.menu_book_rounded,
      'page': const HadithPage(),
    },
    {
      'title': 'دعا و اذکار',
      'icon': Icons.pan_tool_alt_rounded,
      'page': const TextPage(
        title: 'دعا و اذکار',
        text: 'سُبْحَانَ اللَّهِ\nالْحَمْدُ لِلَّهِ\nاللَّهُ أَکْبَرُ',
      ),
    },
    {
      'title': 'مطالب مذهبی',
      'icon': Icons.auto_stories_rounded,
      'page': const TextPage(
        title: 'مطالب مذهبی',
        text:
            'خداوند متعال در قرآن کریم انسان را به نیکی، صبر، راستگویی و کمک به دیگران دعوت کرده است.',
      ),
    },
    {
      'title': 'حکایت‌های آموزنده',
      'icon': Icons.favorite_rounded,
      'page': const TextPage(
        title: 'حکایت‌های آموزنده',
        text:
            'گاهی یک کار کوچک و خالصانه می‌تواند زندگی یک انسان را تغییر دهد. نیکی را کوچک نشماریم.',
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'راه نجات',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: selectedIndex == 0
          ? _home()
          : selectedIndex == 1
              ? const SearchPage()
              : const FavoritesPage(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: 'خانه',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            label: 'جستجو',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_rounded),
            label: 'ذخیره‌ها',
          ),
        ],
      ),
    );
  }

  Widget _home() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF124D2A),
                Color(0xFF2E8B57),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'راه نجات',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'یادآوری خوبی‌ها، آرامش دل و نزدیکی به خدا',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'دسته‌بندی‌ها',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final item = categories[index];

            return InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => item['page'],
                  ),
                );
              },
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item['icon'],
                      size: 44,
                      color: const Color(0xFF176B3A),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 25),

        const Text(
          'حدیث امروز',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        const HadithCard(
          text: 'اِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ',
          meaning: 'همانا ارزش اعمال به نیت‌هاست.',
          source: 'پیامبر اکرم (ص)',
        ),
      ],
    );
  }
}

class HadithPage extends StatelessWidget {
  const HadithPage({super.key});

  final List<Map<String, String>> hadiths = const [
    {
      'text': 'اِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ',
      'meaning': 'همانا ارزش اعمال به نیت‌هاست.',
      'source': 'پیامبر اکرم (ص)',
    },
    {
      'text': 'خَیْرُ النَّاسِ أَنْفَعُهُمْ لِلنَّاسِ',
      'meaning': 'بهترین مردم کسی است که برای مردم سودمندتر باشد.',
      'source': 'پیامبر اکرم (ص)',
    },
    {
      'text': 'مَنْ صَبَرَ ظَفِرَ',
      'meaning': 'هر کس صبر کند، پیروز می‌شود.',
      'source': 'امام علی (ع)',
    },
    {
      'text': 'اَلْعِلْمُ خَیْرٌ مِنَ الْمَالِ',
      'meaning': 'دانش بهتر از مال و ثروت است.',
      'source': 'امام علی (ع)',
    },
    {
      'text': 'اذْکُرُوا اللَّهَ ذِکْراً کَثِیراً',
      'meaning': 'خدا را بسیار یاد کنید.',
      'source': 'قرآن کریم',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('احادیث'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: hadiths.length,
        itemBuilder: (context, index) {
          final h = hadiths[index];

          return HadithCard(
            text: h['text']!,
            meaning: h['meaning']!,
            source: h['source']!,
          );
        },
      ),
    );
  }
}

class HadithCard extends StatelessWidget {
  final String text;
  final String meaning;
  final String source;

  const HadithCard({
    super.key,
    required this.text,
    required this.meaning,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                height: 1.8,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              meaning,
              style: const TextStyle(
                fontSize: 15,
                height: 1.8,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              source,
              style: const TextStyle(
                color: Color(0xFF176B3A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextPage extends StatelessWidget {
  final String title;
  final String text;

  const TextPage({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 19,
                height: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'جستجو\n\nدر نسخه بعدی جستجوی مطالب اضافه می‌شود.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '⭐\n\nهنوز مطلبی ذخیره نشده است.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
