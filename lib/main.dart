import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const TabeebakAlnateqApp());
}

class TabeebakAlnateqApp extends StatelessWidget {
  const TabeebakAlnateqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'طبيبك الناطق',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF0D7377),
        scaffoldBackgroundColor: const Color(0xFFF0F4F8),
        fontFamily: 'Roboto',
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: WelcomeScreen(),
      ),
    );
  }
}

class VoiceHelper {
  static final FlutterTts _tts = FlutterTts();

  static Future<void> speak(String text) async {
    await _tts.stop();
    await _tts.setLanguage('ar');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
    await _tts.speak(text);
  }

  static Future<void> stop() async {
    await _tts.stop();
  }
}

class ThreeDButton extends StatefulWidget {
  final Widget child;
  final Color color;
  final Color shadowColor;
  final VoidCallback onTap;
  final double height;

  const ThreeDButton({
    super.key,
    required this.child,
    required this.color,
    required this.shadowColor,
    required this.onTap,
    this.height = 140,
  });

  @override
  State<ThreeDButton> createState() => _ThreeDButtonState();
}

class _ThreeDButtonState extends State<ThreeDButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: widget.height,
        margin: EdgeInsets.only(
          top: _isPressed ? 8 : 0,
          bottom: _isPressed ? 0 : 8,
        ),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: widget.shadowColor,
                    offset: const Offset(0, 8),
                    blurRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    offset: const Offset(0, 12),
                    blurRadius: 15,
                  ),
                ],
        ),
        child: widget.child,
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      VoiceHelper.speak(
        'مرحباً بكم في تطبيق طبيبك الناطق، مبادرة مجتمعية إنسانية، إعداد وتطوير الأستاذ المهندس محمد عبدالواحد الهمداني. اضغط على الزر الأخضر الكبير للدخول.',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A4D68), Color(0xFF088395), Color(0xFF05BFDB)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.health_and_safety_rounded,
                        size: 90,
                        color: Color(0xFF0D7377),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'طبيبك الناطق',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black38,
                            offset: Offset(2, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'مرشدك الصحي والمجتمعي بالصوت والصورة\nيعمل بالكامل بدون إنترنت',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber, width: 2.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'إعداد وتطوير',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF555555),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'أ. م. محمد عبدالواحد الهمداني',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0A4D68),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ThreeDButton(
                    height: 85,
                    color: const Color(0xFF2ECC71),
                    shadowColor: const Color(0xFF1E8449),
                    onTap: () {
                      VoiceHelper.stop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Directionality(
                            textDirection: TextDirection.rtl,
                            child: HomeScreen(),
                          ),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_circle_fill_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'ابدأ الاستخدام الآن',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      VoiceHelper.speak(
        'اختر القسم المطلوب: الأحمر للإسعافات الطارئة، الأزرق لمنبه الأدوية، الأخضر لصحة الأم والطفل، والبرتقالي للاتصال السريع بالطوارئ.',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A4D68),
        foregroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 75,
        title: const Column(
          children: [
            Text(
              'طبيبك الناطق',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'أ. م. محمد عبدالواحد الهمداني',
              style: TextStyle(fontSize: 13, color: Colors.amberAccent),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up_rounded, size: 32),
            onPressed: () {
              VoiceHelper.speak(
                'الشاشة الرئيسية: اختر الأحمر للإسعافات، الأزرق للأدوية، الأخضر للأم والطفل، البرتقالي للاتصال السريع.',
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ThreeDButton(
                color: const Color(0xFFE74C3C),
                shadowColor: const Color(0xFF922B21),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Directionality(
                        textDirection: TextDirection.rtl,
                        child: FirstAidScreen(),
                      ),
                    ),
                  );
                },
                child: _buildCardContent(
                  icon: Icons.medical_services_rounded,
                  title: 'الإسعافات الطارئة',
                  subtitle: 'إرشادات صوتية فورية للحالات الحرجة',
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ThreeDButton(
                color: const Color(0xFF2980B9),
                shadowColor: const Color(0xFF1A5276),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Directionality(
                        textDirection: TextDirection.rtl,
                        child: MedicineScreen(),
                      ),
                    ),
                  );
                },
                child: _buildCardContent(
                  icon: Icons.camera_alt_rounded,
                  title: 'منبه الأدوية المصور',
                  subtitle: 'صوّر علبة الدواء واسمع طريقة الاستخدام',
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ThreeDButton(
                color: const Color(0xFF27AE60),
                shadowColor: const Color(0xFF196F3D),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Directionality(
                        textDirection: TextDirection.rtl,
                        child: MaternalChildScreen(),
                      ),
                    ),
                  );
                },
                child: _buildCardContent(
                  icon: Icons.child_friendly_rounded,
                  title: 'صحة الأم والطفل',
                  subtitle: 'التطعيمات وعلامات الخطر بالصوت',
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ThreeDButton(
                color: const Color(0xFFF39C12),
                shadowColor: const Color(0xFFB9770E),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Directionality(
                        textDirection: TextDirection.rtl,
                        child: EmergencyContactsScreen(),
                      ),
                    ),
                  );
                },
                child: _buildCardContent(
                  icon: Icons.phone_in_talk_rounded,
                  title: 'اتصال الطوارئ السريع',
                  subtitle: 'اتصل بأقرب مسعف أو قريب بضغطة صورة',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardContent({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 46, color: Colors.white),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
          const Icon(Icons.volume_up_rounded, color: Colors.white, size: 30),
        ],
      ),
    );
  }
}

class FirstAidScreen extends StatefulWidget {
  const FirstAidScreen({super.key});

  @override
  State<FirstAidScreen> createState() => _FirstAidScreenState();
}

class _FirstAidScreenState extends State<FirstAidScreen> {
  int? _playingIndex;

  final emergencyList = [
    {
      'title': 'إيقاف النزيف الحاد',
      'icon': Icons.bloodtype_rounded,
      'color': const Color(0xFFC0392B),
      'advice':
          'اضغط بقوة ومباشرة على مكان الجرح باستخدام قطعة قماش نظيفة أو شاش معقم. ارفع العضو المصاب فوق مستوى القلب إن أمكن، ولا تنزع القماش إذا امتلأ بالدم بل ضع فوقه قطعة أخرى واستمر بالضغط حتى وصول المسعف.',
    },
    {
      'title': 'إسعاف الحروق',
      'icon': Icons.local_fire_department_rounded,
      'color': const Color(0xFFD35400),
      'advice':
          'أبعد المصاب عن مصدر النار فوراً. اسكب ماءً بارداً جارياً من الصنبور على مكان الحرق لمدة عشر دقائق على الأقل. إياك أن تضع معجون الأسنان أو الثلج أو الزيوت على الحرق، وغطّه بقطعة قماش نظيفة مبللة.',
    },
    {
      'title': 'الاختناق وابتلاع جسم غريب',
      'icon': Icons.air_rounded,
      'color': const Color(0xFF2980B9),
      'advice':
          'إذا كان المصاب يسعل بقوة فشجعه على الاستمرار. أما إذا عجز عن التنفس أو الكلام، قف خلفه ولف ذراعيك حول خصره، وضع قبضة يدك فوق سرته واضغط بقوة إلى الداخل والأعلى خمس مرات متتالية حتى يخرج الجسم العالق.',
    },
    {
      'title': 'لدغات العقارب والثعابين',
      'icon': Icons.pest_control_rounded,
      'color': const Color(0xFF8E44AD),
      'advice':
          'هدّئ المصاب وامنع حركته تماماً لأن الحركة تنشر السم بسرعة. اجعل الطرف الملدوغ منخفضاً عن مستوى القلب. لا تحاول مص السم بالفم ولا تجرح مكان اللدغة، وانقل المصاب فوراً لأقرب مركز صحي.',
    },
    {
      'title': 'الإغماء وفقدان الوعي',
      'icon': Icons.personal_injury_rounded,
      'color': const Color(0xFF16A085),
      'advice':
          'مدّد المصاب على ظهره في مكان جيد التهوية، وارفع ساقيه قليلاً للأعلى. فك الملابس الضيقة حول رقبته. إذا كان يتنفس ولكنه فاقد للوعي، اقلبه بلطف على جانبه الأيمن لمنع اختناقه باللسان أو القيء، ولا تسقِه أي ماء وهو فاقد للوعي.',
    },
    {
      'title': 'الإسهال الشديد والجفاف',
      'icon': Icons.water_drop_rounded,
      'color': const Color(0xFF2C3E50),
      'advice':
          'أعطِ المصاب محلول الإرواء الفموي فوراً بعد كل مرة إسهال. إذا لم يتوفر المحلول الجاهز، أذب ست ملاعق صغيرة ممسوحة من السكر ونصف ملعقة صغيرة من الملح في لتر واحد من الماء النظيف المغلي والمبرد، وأعطِه للمريض رشفات متكررة.',
    },
  ];

  @override
  void initState() {
    super.initState();
    VoiceHelper.speak('قسم الإسعافات الطارئة. اضغط على أي حالة لسماع طريقة إسعافها فوراً.');
  }

  @override
  void dispose() {
    VoiceHelper.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC0392B),
        foregroundColor: Colors.white,
        title: const Text('الإسعافات الطارئة', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: emergencyList.length,
        itemBuilder: (context, index) {
          final item = emergencyList[index];
          final bool isPlaying = _playingIndex == index;
          final Color itemColor = item['color'] as Color;
          final IconData itemIcon = item['icon'] as IconData;
          final String itemTitle = item['title'] as String;
          final String itemAdvice = item['advice'] as String;

          return Card(
            elevation: 6,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isPlaying ? Colors.amber : itemColor,
                width: isPlaying ? 3.5 : 1.5,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                setState(() => _playingIndex = index);
                VoiceHelper.speak('$itemTitle. $itemAdvice');
              },
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: itemColor,
                          child: Icon(itemIcon, color: Colors.white, size: 32),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            itemTitle,
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: itemColor,
                            ),
                          ),
                        ),
                        Icon(
                          isPlaying ? Icons.graphic_eq_rounded : Icons.volume_up_rounded,
                          size: 38,
                          color: isPlaying ? Colors.amber[800] : itemColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      itemAdvice,
                      style: const TextStyle(fontSize: 17, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({super.key});

  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  List medicines = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadMedicines();
    VoiceHelper.speak('منبه الأدوية المصور. اضغط على الزر الأزرق في الأسفل لتصوير علبة الدواء وحفظ موعدها.');
  }

  Future<void> _loadMedicines() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('saved_medicines');
    if (data != null) {
      final decoded = jsonDecode(data) as List;
      setState(() {
        medicines = List.from(decoded);
      });
    }
  }

  Future<void> _saveMedicines() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_medicines', jsonEncode(medicines));
  }

  Future<void> _addNewMedicine() async {
    VoiceHelper.speak('افتح الكاميرا وصور علبة الدواء بوضوح.');
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo == null) return;

    if (!mounted) return;
    String selectedTime = 'بعد الإفطار صباحاً';
    String selectedDose = 'حبة واحدة';

    await showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: const Text('حدد موعد وجرعة هذا الدواء', style: TextStyle(fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField(
                  value: selectedTime,
                  decoration: const InputDecoration(labelText: 'وقت أخذ الدواء'),
                  items: const [
                    DropdownMenuItem(value: 'بعد الإفطار صباحاً', child: Text('بعد الإفطار صباحاً')),
                    DropdownMenuItem(value: 'بعد الغداء ظهراً', child: Text('بعد الغداء ظهراً')),
                    DropdownMenuItem(value: 'بعد العشاء مساءً', child: Text('بعد العشاء مساءً')),
                    DropdownMenuItem(value: 'قبل النوم ليلاً', child: Text('قبل النوم ليلاً')),
                    DropdownMenuItem(value: 'كل ثمان ساعات', child: Text('كل ثمان ساعات')),
                  ],
                  onChanged: (val) => setDialogState(() => selectedTime = val.toString()),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField(
                  value: selectedDose,
                  decoration: const InputDecoration(labelText: 'الجرعة المطلوبة'),
                  items: const [
                    DropdownMenuItem(value: 'نصف حبة', child: Text('نصف حبة')),
                    DropdownMenuItem(value: 'حبة واحدة', child: Text('حبة واحدة')),
                    DropdownMenuItem(value: 'حبتان', child: Text('حبتان')),
                    DropdownMenuItem(value: 'ملعقة صغيرة', child: Text('ملعقة صغيرة')),
                    DropdownMenuItem(value: 'ملعقة كبيرة', child: Text('ملعقة كبيرة')),
                  ],
                  onChanged: (val) => setDialogState(() => selectedDose = val.toString()),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2980B9), foregroundColor: Colors.white),
                onPressed: () {
                  setState(() {
                    medicines.add({
                      'imagePath': photo.path,
                      'time': selectedTime,
                      'dose': selectedDose,
                    });
                  });
                  _saveMedicines();
                  VoiceHelper.speak('تم حفظ الدواء بنجاح. الجرعة $selectedDose، $selectedTime.');
                  Navigator.pop(ctx);
                },
                child: const Text('حفظ الدواء'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2980B9),
        foregroundColor: Colors.white,
        title: const Text('منبه الأدوية المصور', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: medicines.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'لا توجد أدوية مصورة بعد.\nاضغط على الزر بالأسفل لتصوير علبة الدواء.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                final med = medicines[index];
                final String imgPath = med['imagePath'].toString();
                final String time = med['time'].toString();
                final String dose = med['dose'].toString();

                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      VoiceHelper.speak('هذا الدواء يؤخذ $dose، $time.');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.file(
                              File(imgPath),
                              width: 95,
                              height: 95,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 95,
                                height: 95,
                                color: Colors.blue[100],
                                child: const Icon(Icons.medication, size: 50, color: Colors.blue),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dose,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A5276),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  time,
                                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              const Icon(Icons.volume_up_rounded, size: 36, color: Color(0xFF2980B9)),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.red),
                                onPressed: () {
                                  setState(() => medicines.removeAt(index));
                                  _saveMedicines();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ThreeDButton(
          height: 75,
          color: const Color(0xFF2980B9),
          shadowColor: const Color(0xFF1A5276),
          onTap: _addNewMedicine,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt_rounded, color: Colors.white, size: 34),
              SizedBox(width: 12),
              Text(
                'صوّر دواءً جديداً',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaternalChildScreen extends StatefulWidget {
  const MaternalChildScreen({super.key});

  @override
  State<MaternalChildScreen> createState() => _MaternalChildScreenState();
}

class _MaternalChildScreenState extends State<MaternalChildScreen> {
  final maternalList = [
    {
      'title': 'علامات الخطر أثناء الحمل',
      'icon': Icons.warning_amber_rounded,
      'color': const Color(0xFFC0392B),
      'advice':
          'يجب التوجه فوراً للمستشفى عند ظهور أي من هذه العلامات: نزيف مهبلي، صداع شديد مستمر مع زغللة في العينين، تورم مفاجئ في الوجه واليدين، ارتفاع شديد في الحرارة، أو توقف حركة الجنين.',
    },
    {
      'title': 'جدول تطعيمات الطفل الأساسية',
      'icon': Icons.vaccines_rounded,
      'color': const Color(0xFF27AE60),
      'advice':
          'التطعيم يحمي طفلك من الشلل والحصبة والسعال الديكي. المواعيد الأساسية هي: عند الولادة مباشرة، ثم عند إتمام الشهر الأول ونصف، ثم الشهر الثاني ونصف، ثم الشهر الثالث ونصف، وعند إتمام الشهر التاسع.',
    },
    {
      'title': 'أهمية الرضاعة الطبيعية',
      'icon': Icons.child_care_rounded,
      'color': const Color(0xFF2980B9),
      'advice':
          'ابدئي بإرضاع طفلك خلال الساعة الأولى بعد الولادة، لأن حليب اللبأ الأصفر هو أول لقاح طبيعي يحمي مناعة الطفل. اكتفي بالرضاعة الطبيعية وحدها دون ماء أو أعشاب خلال الأشهر الستة الأولى.',
    },
    {
      'title': 'علامات الخطر عند حديثي الولادة',
      'icon': Icons.monitor_heart_rounded,
      'color': const Color(0xFF8E44AD),
      'advice':
          'انقلي الرضيع فوراً للطبيب إذا لاحظتِ: صعوبة أو سرعة في التنفس، رفض الرضاعة تماماً، خمول شديد، اصفرار يمتد إلى باطن اليدين والقدمين، أو ارتفاع درجة حرارة جسمه.',
    },
  ];

  @override
  void initState() {
    super.initState();
    VoiceHelper.speak('قسم صحة الأم والطفل. اضغط على أي بطاقة لسماع الإرشادات الصحية.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF27AE60),
        foregroundColor: Colors.white,
        title: const Text('صحة الأم والطفل', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: maternalList.length,
        itemBuilder: (context, index) {
          final item = maternalList[index];
          final Color cardColor = item['color'] as Color;
          final IconData cardIcon = item['icon'] as IconData;
          final String cardTitle = item['title'] as String;
          final String cardAdvice = item['advice'] as String;

          return Card(
            elevation: 6,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => VoiceHelper.speak('$cardTitle. $cardAdvice'),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: cardColor,
                          child: Icon(cardIcon, size: 30, color: Colors.white),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            cardTitle,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: cardColor,
                            ),
                          ),
                        ),
                        Icon(Icons.volume_up_rounded, size: 36, color: cardColor),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      cardAdvice,
                      style: const TextStyle(fontSize: 17, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() => _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  List contacts = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadContacts();
    VoiceHelper.speak('اتصال الطوارئ السريع. اضغط على صورة الشخص للاتصال به مباشرة.');
  }

  Future<void> _loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('emergency_contacts');
    if (data != null) {
      final decoded = jsonDecode(data) as List;
      setState(() {
        contacts = List.from(decoded);
      });
    }
  }

  Future<void> _saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emergency_contacts', jsonEncode(contacts));
  }

  Future<void> _addContact() async {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    String? imagePath;

    await showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: const Text('إضافة رقم طوارئ سريع', style: TextStyle(fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                      if (photo != null) {
                        setDialogState(() => imagePath = photo.path);
                      }
                    },
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.orange[100],
                      backgroundImage: imagePath != null ? FileImage(File(imagePath!)) : null,
                      child: imagePath == null
                          ? const Icon(Icons.add_a_photo_rounded, size: 38, color: Colors.orange)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('اضغط لاختيار صورة الشخص (اختياري)', style: TextStyle(fontSize: 13)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'الاسم (مثلاً: ولدي أحمد / الطبيب)'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'رقم الهاتف'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF39C12), foregroundColor: Colors.white),
                onPressed: () {
                  if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {
                    setState(() {
                      contacts.add({
                        'name': nameController.text,
                        'phone': phoneController.text,
                        'imagePath': imagePath ?? '',
                      });
                    });
                    _saveContacts();
                    Navigator.pop(ctx);
                  }
                },
                child: const Text('حفظ الرقم'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _callNumber(String name, String phone) async {
    VoiceHelper.speak('جاري الاتصال بـ $name');
    final Uri uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF39C12),
        foregroundColor: Colors.white,
        title: const Text('اتصال الطوارئ السريع', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: contacts.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'لا توجد أرقام طوارئ محفوظة.\nأضف رقم قريبك أو مسعف القرية ليتصل به كبار السن بضغطة واحدة.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 19, color: Colors.black54),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final c = contacts[index];
                final String name = c['name'].toString();
                final String phone = c['phone'].toString();
                final String img = c['imagePath'].toString();

                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => _callNumber(name, phone),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: const Color(0xFFF39C12),
                            backgroundImage: img.isNotEmpty ? FileImage(File(img)) : null,
                            child: img.isEmpty
                                ? const Icon(Icons.person_rounded, size: 42, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  phone,
                                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          const CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.green,
                            child: Icon(Icons.call_rounded, color: Colors.white, size: 30),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () {
                              setState(() => contacts.removeAt(index));
                              _saveContacts();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ThreeDButton(
          height: 75,
          color: const Color(0xFFF39C12),
          shadowColor: const Color(0xFFB9770E),
          onTap: _addContact,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_add_alt_1_rounded, color: Colors.white, size: 34),
              SizedBox(width: 12),
              Text(
                'إضافة رقم طوارئ جديد',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
