import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp()); // 앱 실행 시 HomeScreen을 첫 화면으로 표시
}

/// 앱의 메인 클래스 (홈 화면을 실행)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

/// 홈 화면을 정의하는 클래스
class HomeScreen extends StatelessWidget {
  /// 버튼 클릭 시 메시지를 출력하는 함수
  void _onButtonPressed() {
    print("버튼이 눌렸습니다.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 상단 앱바 설정
      appBar: AppBar(
        backgroundColor: Colors.blue, // 앱바 색상 지정
        title: Text("프레임 앱 만들기"), // 앱 제목
        leading: Icon(FontAwesomeIcons.dungeon), // 좌측 아이콘 추가 (둠 아이콘)
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert), // 우측 버튼 추가
            onPressed: _onButtonPressed, // 버튼 클릭 시 콘솔 출력
          ),
        ],
      ),
      backgroundColor: Colors.grey[300], // 전체 배경 색상 설정
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// 화면 중앙에 버튼 배치
          Center(
            child: ElevatedButton(
              onPressed: _onButtonPressed,
              child: Text("Text"),
            ),
          ),
          SizedBox(height: 20),

          /// 컨테이너들을 버튼 하단에 배치 (좌상단 기준 계단식 형태 유지)
          Center(
            child: SizedBox(
              width: 300,
              height: 300, // Stack 크기 고정
              child: Stack(
                children: [
                  Positioned(left: 0, top: 0, child: Container(width: 300, height: 300, color: Colors.blue)), // 가장 큰 컨테이너
                  Positioned(left: 0, top: 0, child: Container(width: 240, height: 240, color: Colors.green)), // 두 번째 컨테이너
                  Positioned(left: 0, top: 0, child: Container(width: 180, height: 180, color: Colors.yellow)), // 세 번째 컨테이너
                  Positioned(left: 0, top: 0, child: Container(width: 120, height: 120, color: Colors.orange)), // 네 번째 컨테이너
                  Positioned(left: 0, top: 0, child: Container(width: 60, height: 60, color: Colors.red)), // 가장 작은 컨테이너
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
///컨테이너 위치 설정에 애를 좀 먹었습니다. 위치와 사이즈를 반대로 입력해버려서 그리되기도 하고, 공간지각력이 부족하기도 했나봅니다.