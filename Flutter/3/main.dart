import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    ); //첫번째 페이지 선언언
  }
}

// 첫 번째 페이지 (고양이 페이지)
class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool isCat = true; // 초기값은 고양이

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        leading: Icon(Icons.pets), // 고양이 아이콘 추가
        title: Text('First Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(isCat: isCat),
                  ), //두번째 페이지 선언언
                );

                // 화면이 돌아오자마자 즉시 상태 업데이트가 되도록 추가했지만 실패패
                if (result != null) {
                  setState(() => isCat = result);
                }
              },
              child: Text('Next'),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() => isCat = !isCat); // 값 반전
                print('isCat 상태 변경됨: $isCat'); // 상태 출력
              },
              child: Image.asset(
                isCat ? 'assets/cat_image_resized.png' : 'assets/dog_image_resized.png', // 이미지 변경
                width: 300,
                height: 300,
              ),//고양이 에셋
            ),//버튼누르기감지 선언언
          ],
        ),
      ),
    );
  }
}

// 두 번째 페이지 (강아지 페이지)
class SecondPage extends StatelessWidget {
  final bool isCat;

  const SecondPage({required this.isCat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        leading: Icon(Icons.pets), // 강아지 아이콘 추가
        title: Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, !isCat); // 돌아갈 때 isCat 값을 반대로 변경
              },
              child: Text('Back'),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                print('isCat 상태 변경됨: ${!isCat}'); // 상태 변경된 값 출력
              },
              child: Image.asset(
                'assets/dog_image_resized.png', // 강아지 이미지 고정
                width: 300,
                height: 300,
              ),//강아지 이미지 에셋 설정
            ), //버튼 누르기 감지 선언
          ],
        ),
      ),
    );
  }
}
///이미지를 누르면 변경이 잘되지만 버튼으로 누를때는 변경이 바로 안된다. 
///이유는 버튼을 누르면 두번째 페이지로 넘어가기 때문에 두번째 페이지에서 변경된 값을 다시 받아오지 못하기 떄문이라고 코파일럿 선생님이 그러셨다.
///그래서 버튼을 누르는것 보다는 이미지를 누르는것을 추천드립니다.