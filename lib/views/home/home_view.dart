library home_view;

import 'dart:math';

import 'package:covid_care_app/theme/colors.dart';
import 'package:stacked/stacked.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'home_view_model.dart';

part 'home_mobile.dart';
part 'home_tablet.dart';
part 'home_desktop.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  Widget _buildBody() {
    return AnimatedBuilder(
      animation:
          CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildContainer(150 * _controller.value),
            _buildContainer(200 * _controller.value),
            _buildContainer(250 * _controller.value),
            _buildContainer(300 * _controller.value),
            _buildContainer(350 * _controller.value),
            _buildContainer(400 * _controller.value),
            _buildContainer(450 * _controller.value),
            Align(
                child: Icon(
              Icons.play_arrow,
              size: 44,
            )),
          ],
        );
      },
    );
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue.withOpacity(1 - _controller.value),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.share),
                  color: kPrimaryColor500,
                  tooltip: 'Show Snackbar',
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  color: kPrimaryColor500,
                  tooltip: 'Next page',
                  onPressed: () {},
                ),
              ],
            ),
            body: _buildBody(),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
              },
              label: Text('Test Report'.toUpperCase()),
              icon: Icon(Icons.add),
              //backgroundColor: Colors.pink,
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: _onItemTapped, // new
              currentIndex: _selectedIndex, // new
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              items: [
                new BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                ),
                new BottomNavigationBarItem(
                  icon: Icon(Icons.map),
                  title: Text('Messages'),
                ),
                new BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_active),
                  title: Text('Profile'),
                ),
              ],
            ),
          );
        });
  }
}

// class SpritePainter extends CustomPainter {
//   final Animation<double> _animation;

//   SpritePainter(this._animation) : super(repaint: _animation);

//   void circle(Canvas canvas, Rect rect, double value) {
//     double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
//     Color color = new Color.fromRGBO(0, 117, 194, opacity);

//     double size = rect.width / 2;
//     double area = size * size;
//     double radius = sqrt(area * value / 4);

//     final Paint paint = new Paint()..color = color;
//     canvas.drawCircle(rect.center, radius, paint);
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     Rect rect = new Rect.fromLTRB(0.0, 0.0, size.width, size.height);

//     for (int wave = 3; wave >= 0; wave--) {
//       circle(canvas, rect, wave + _animation.value);
//     }
//   }

//   @override
//   bool shouldRepaint(SpritePainter oldDelegate) {
//     return true;
//   }
// }

// class SpriteDemo extends StatefulWidget {
//   @override
//   SpriteDemoState createState() => new SpriteDemoState();
// }

// class SpriteDemoState extends State<SpriteDemo>
//     with SingleTickerProviderStateMixin {
//   AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = new AnimationController(
//       vsync: this,
//     );
//     //_startAnimation();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _startAnimation() {
//     _controller.stop();
//     _controller.reset();
//     _controller.repeat(
//       period: Duration(seconds: 1),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(title: const Text('Pulse')),
//       body: new CustomPaint(
//         painter: new SpritePainter(_controller),
//         child: new SizedBox(
//           width: 200.0,
//           height: 200.0,
//         ),
//       ),
//       floatingActionButton: new FloatingActionButton(
//         onPressed: _startAnimation,
//         child: new Icon(Icons.play_arrow),
//       ),
//     );
//   }
// }
