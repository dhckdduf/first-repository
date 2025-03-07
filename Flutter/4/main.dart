import 'package:flutter/material.dart';

void main() {
  runApp(const CreativeCocktailsApp());
}

///
/// [CreativeCocktailsApp]은 Flutter 애플리케이션의 루트 위젯입니다.
/// - MaterialApp을 설정하고, 메인 페이지 [MainPage]를 home으로 지정합니다.
/// - 테마나 스플래시 화면 등을 여기서 설정할 수 있습니다.
///
class CreativeCocktailsApp extends StatelessWidget {
  const CreativeCocktailsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Creative Cocktails with LLM',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        // Scaffold 배경색을 회색 톤으로 설정
        scaffoldBackgroundColor: Colors.grey.shade200,
      ),
      // 메인 페이지를 [MainPage]로 지정
      home: const MainPage(),
    );
  }
}

///
/// [MainPage]는 하단 네비게이션 바를 통해
/// Home, Chat, Inspiration 세 화면을 전환할 수 있는 구조입니다.
///
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 현재 선택된 화면의 인덱스 (0=Home, 1=Chat, 2=Inspiration)
  int _selectedIndex = 0;

  // 네비게이션으로 전환할 페이지들을 리스트로 관리
  final List<Widget> _pages = const [
    HomeScreen(),
    ChatScreen(),
    InspirationScreen(),
  ];

  /// 하단 네비게이션 아이템을 탭했을 때 호출되는 메서드
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 앱바
      appBar: AppBar(
        title: const Text('Creative Cocktails with LLM'),
        centerTitle: true,
      ),
      // 현재 인덱스에 맞는 화면을 Body로 표시
      body: _pages[_selectedIndex],

      // 하단 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Inspiration',
          ),
        ],
      ),
    );
  }
}

///
/// [HomeScreen]은 로그인과 간단한 칵테일/LLM 대화 예시가 포함된 화면입니다.
/// - 사용자 이름과 믹솔로지스트 레벨(Beginner, Intermediate, Expert)을 입력받는 예시
/// - LLM과의 대화를 가정한 샘플 UI
///
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 사용자 이름 입력 필드 컨트롤러
  final TextEditingController _usernameController = TextEditingController();

  // 믹솔로지스트 레벨 기본값
  String _mixologistLevel = 'Beginner';

  // LLM 응답을 가정한 더미 데이터
  String _cocktailIdea = 'Try creating a summer cocktail with a hint of mint!';
  String _cocktailAuthor = 'MixMaster22';
  String _ingredientQuestion = 'Where can I find fresh passion fruit?';
  String _ingredientAuthor = 'CocktailQueen99';

  @override
  Widget build(BuildContext context) {
    return Center(
      // 큰 화면에서 너비가 너무 넓어지지 않도록 제한
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LLM 소개 영역
              Text(
                'LLM',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Let\'s create something unique together!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              // 로그인 섹션: 사용자 이름 입력
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Enter your username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // 믹솔로지스트 레벨 선택
              Text(
                'Choose your mixologist level',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Beginner'),
                      value: 'Beginner',
                      groupValue: _mixologistLevel,
                      onChanged: (val) {
                        setState(() {
                          _mixologistLevel = val ?? 'Beginner';
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Intermediate'),
                      value: 'Intermediate',
                      groupValue: _mixologistLevel,
                      onChanged: (val) {
                        setState(() {
                          _mixologistLevel = val ?? 'Beginner';
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Expert'),
                      value: 'Expert',
                      groupValue: _mixologistLevel,
                      onChanged: (val) {
                        setState(() {
                          _mixologistLevel = val ?? 'Beginner';
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 로그인 버튼
              ElevatedButton(
                onPressed: () {
                  // 간단한 로그인 피드백
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Logged in as ${_usernameController.text} ($_mixologistLevel)',
                      ),
                    ),
                  );
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),

              // 기능 버튼들 (Discuss with LLM, Share Results)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.forum),
                    label: const Text('Discuss with LLM'),
                    onPressed: () {
                      // 클릭 시 처리할 로직 (예: LLM 대화 화면으로 이동 등)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Discuss feature clicked'),
                        ),
                      );
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.share),
                    label: const Text('Share Results'),
                    onPressed: () {
                      // 클릭 시 처리할 로직 (예: SNS 공유 등)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Share feature clicked'),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // LLM 대화 예시 영역
              Text(
                'Discuss with LLM',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              _buildChatBubble(
                title: 'Cocktail Recipe Idea',
                content: _cocktailIdea,
                author: _cocktailAuthor,
              ),
              const SizedBox(height: 8),
              _buildChatBubble(
                title: 'Ingredient Recommendation',
                content: _ingredientQuestion,
                author: _ingredientAuthor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 간단한 메시지 버블 형태의 위젯을 만드는 메서드
  Widget _buildChatBubble({
    required String title,
    required String content,
    required String author,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // 흰색 배경 + 모서리 둥글게
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title  ', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(content),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.person_pin, size: 18),
              const SizedBox(width: 4),
              Text(author),
            ],
          )
        ],
      ),
    );
  }
}

///
/// [ChatScreen]은 LLM과의 채팅을 가정한 화면입니다.
/// - 메시지를 입력해 목록에 추가하고,
/// - 검색 필드로 메시지를 필터링할 수 있는 예시를 보여줍니다. (실제 필터링 로직은 미구현)
///
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // 메시지 입력 컨트롤러
  final TextEditingController _messageController = TextEditingController();
  // 검색어 입력 컨트롤러
  final TextEditingController _searchController = TextEditingController();

  // 샘플 메시지 목록
  final List<String> _messages = [
    'Hi! I am the LLM. How can I help you today?',
    'Do you have any cocktail suggestions?',
  ];

  /// 메시지를 전송하는 메서드
  void _sendMessage() {
    if (_messageController.text.isEmpty) return;
    setState(() {
      _messages.add(_messageController.text);
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // 큰 화면에서 너비 제한
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 가짜 탭 UI 예시 (Settings, Contacts)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Column(
                    children: [
                      Icon(Icons.settings, size: 32),
                      Text('Settings'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.contacts, size: 32),
                      Text('Contacts'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // LLM 채팅 안내 텍스트
              Text(
                'LLM Chat',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),

              // 메시지 입력 필드
              TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Type your message here...',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 메시지 전송 버튼
              ElevatedButton(
                onPressed: _sendMessage,
                child: const Text('Send'),
              ),
              const SizedBox(height: 16),

              // 메시지 검색 필드 (실제 필터 로직은 추가 필요)
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search in chat',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // 메시지 목록 표시
              const Text(
                'Messages:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // _messages 리스트를 순회하며 각 메시지를 표시
              ..._messages.map(
                (msg) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(msg),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
/// [InspirationScreen]은 칵테일 영감을 얻을 수 있는 화면입니다.
/// - 추천 상품 목록
/// - 저장된 칵테일 목록
/// 를 예시로 보여줍니다.
///
class InspirationScreen extends StatelessWidget {
  const InspirationScreen({Key? key}) : super(key: key);

  // 추천 상품 목록 (임의 데이터)
  final List<Map<String, String>> _recommendedProducts = const [
    {
      'title': 'Premium Vodka Bottle',
      'price': '\$29.99',
    },
    {
      'title': 'Fresh Fruit Basket',
      'price': '\$12.99',
    },
    {
      'title': 'Craft Gin Set',
      'price': '\$19.99',
    },
  ];

  // 저장된 칵테일 목록 (임의 데이터)
  final List<Map<String, String>> _savedCreations = const [
    {
      'title': 'Tropical Bliss Cocktail',
      'date': '05/15/2022',
      'rating': '4.5',
    },
    {
      'title': 'Summer Sunset Spritz',
      'date': '05/20/2022',
      'rating': '4.7',
    },
    {
      'title': 'Minty Fresh Delight',
      'date': '06/01/2022',
      'rating': '4.6',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      // 큰 화면에서 너비 제한
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 화면 제목
              Text(
                'Explore Cocktail Inspiration',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // 추천 상품 섹션
              Text(
                'Recommended Products',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Wrap을 이용해 상품 카드들을 가로/세로로 나열
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _recommendedProducts.map((product) {
                  return _buildProductCard(product);
                }).toList(),
              ),
              const SizedBox(height: 16),

              // 저장된 칵테일 목록 섹션
              Text(
                'Saved Creations',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // 저장된 칵테일들을 Card 형태로 표시
              Column(
                children: _savedCreations.map((cocktail) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.star_rate_rounded, color: Colors.amber),
                      title: Text('${cocktail['title']}'),
                      subtitle: Text(
                        'Created on ${cocktail['date']} | Rating: ${cocktail['rating']}',
                      ),
                      onTap: () {
                        // 클릭 시 상세 화면 이동 등의 로직을 추가할 수 있음
                      },
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 추천 상품을 표시하는 간단한 카드 위젯
  Widget _buildProductCard(Map<String, String> product) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            product['title'] ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(product['price'] ?? ''),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () {
              // 상품 상세 페이지 이동 등의 로직
            },
            child: const Text('View Details'),
          )
        ],
      ),
    );
  }
}
