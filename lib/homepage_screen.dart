import 'dart:async';
import 'package:flutter/material.dart';
import 'package:oma_mobile/search.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final PageController pageController;
  int pageNumber = 0;
  int _selectedIndex = 0;

  List<Widget> pageList = [
    const MyHomePage(),
    const SearchPage(),
  ];

  Timer? carouselTimer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNumber == 4) {
        pageNumber = 0;
      }
      pageController.animateToPage(pageNumber,
          duration: const Duration(seconds: 1), curve: Curves.easeInOutCirc);
      pageNumber++;
    });
  }

  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
    );
    carouselTimer = getTimer();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageList.elementAt(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const SizedBox(
          width: double.infinity,
          height: 40,
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                suffixIconColor: Colors.amber,
                labelText: "Поиск по товарам",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey, width: 100),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 160,
              child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    pageNumber = index;
                    setState(() {});
                  },
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: pageController,
                      builder: (context, child) {
                        return child!;
                      },
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Страница № $index"),
                            ),
                          );
                        },
                        onPanDown: (d) {
                          carouselTimer?.cancel();
                          carouselTimer = null;
                        },
                        onPanCancel: () {
                          carouselTimer = getTimer();
                        },
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red,
                          ),
                          child: Image.asset(
                            'assets/images/fku.png',
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => SizedBox(
                  child: Icon(
                    Icons.circle,
                    size: 12,
                    color:
                        pageNumber == index ? Colors.amberAccent : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  "Популярные категории",
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SizedBox(
              height: 280,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchPage()),
                        );
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(width: 1, color: Colors.black12)),
                        elevation: 0,
                        color: Colors.white,
                        child:
                            Column(mainAxisSize: MainAxisSize.max, children: [
                          Container(
                            color: Colors.transparent,
                            height: 76,
                            width: 120,
                            child: Image.asset(
                              'assets/images/office.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Text(
                              "Канцелярские товары",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                          )
                        ]),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  "Недавно смотрели",
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SizedBox(
              height: 230,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 10,
                      childAspectRatio: (100 / 72),
                      crossAxisCount: 1),
                  itemCount: 16,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                              width: 1, color: Colors.black12)),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 0,
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          color: Colors.white,
                          height: 112,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/svetocopy.png',
                            fit: BoxFit.cover,
                          ),

                          // decoration: const BoxDecoration(
                          //     image: DecorationImage(
                          //   image: AssetImage(
                          //     'assets/images/coder.png',
                          //   ),
                          // )),
                          // child: Align(
                          //   alignment: Alignment.topRight,
                          //   child: IconButton(
                          //       onPressed: () {},
                          //       icon: const Icon(
                          //         Icons.favorite_border_outlined,
                          //         color: Colors.red,
                          //       )),
                          // )
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Канцелярские товары",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 14),
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: SizedBox(
                            height: 30,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  elevation: 0,
                                  // side: const BorderSide(
                                  //   width: 1,
                                  //   color: Colors.amber,
                                  // ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  "В корзину",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        )
                      ]),
                    );
                  }),
            ),
            const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  "Популярные категории",
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
