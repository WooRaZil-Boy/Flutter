import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'model/product.dart';
import 'login.dart';

const double _kFlingVelocity = 2.0;

class Backdrop extends StatefulWidget {
  final Category currentCategory; //필터링할 범주
  final Widget frontLayer; //내용을 표시
  final Widget backLayer; //작업 및 필터를 표시
  final Widget frontTitle;
  final Widget backTitle;
  //이렇게 Layer를 나 interactive한 작업을 구현할 수 있다.

  const Backdrop({
    @required this.currentCategory,
    @required this.frontLayer,
    @required this.backLayer,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(currentCategory != null),
        assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null);
  //제약조건
  //기본값이 없는 경우, null이 되어선 안 되는 속성에 설정해 준다.

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop> with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop'); //GlobalKey는 앱 전체에서의 유일한 키이다.
  //다른 객체에 대한 액세스를 제공한다. 반드시 GlobalKey를 사용해야 하는 경우가 아니라면,
  //Key, ValueKey, ObjectKey, UniqueKey 등을 사용하는 것이 좋다.
  AnimationController _controller; //애니메이션 조정, 제어

  @override
  void initState() { //initState 메서드는 위젯이 위젯 트리에 포함되기 전에 단 한 번만 호출된다.
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 300), //지속시
      value: 1.0,
      vsync: this, //Ticker(여기서는 TickerProviderStateMixin)를 구현한 객체가 vsync가 된다.
    );
  }

  @override
  void dispose() { //메모리 해제될때 한 번만 호출된다.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar( //iOS의 Navigation Bar에 해당한다.
        brightness: Brightness.light,
        elevation: 0.0,
        titleSpacing: 0.0,
//        leading: IconButton(
//          icon: Icon(Icons.menu),
//          onPressed: _toggleBackdropLayerVisibility,
//        ),
//        title: Text("SHRINE"), //AppBar의 title에서 플랫폼 별로 차이가 있다.
//        iOS는 title이 AppBar의 중앙에 위치하지만(UIKit의 기본), Android는 왼쪽으로 정렬된다.
        title: _BackdropTitle(
          listenable: _controller.view,
          onPress: _toggleBackdropLayerVisibility,
          frontTitle: widget.frontTitle,
          backTitle: widget.backTitle,
        ),
        actions: <Widget>[ //leading과 반대로 trailing에 위치하는 버튼들을 actions이라고 한다.
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: "login",
              //Icon 클래스의 SemanticLabel 필드는 Flutter에서 접근성을 추가하는 일반적인 방법으로 UI에 표시되지는 않는다.
              //VoiceOver 같은 특수 목적의 앱에 정보를 전달하는 역할을 한다.
              //UIAccessibility의 accessibilityLabel와 매우 유사하다.
              //SemanticLabel 필드가 따로 없는 위젯의 경우에는 Semantics 위젯으로 감싸면 된다.
            ),
            onPressed: () {
              Navigator.push( //로그인 화면으로 이동
                context,
                MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: "filter",
            ),
            onPressed: () {
              Navigator.push( //로그인 화면으로 이동
                context,
                MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
              );
            },
          ),
        ],
      );

    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(builder: _buildStack), //부모 위젯의 크기에 의존하는 위젯 트리 생성
      //부모 위젯의 크기를 알아야 자식 위젯을 레이아웃 할 수 있고, 부모 위젯의 크기는 하위 위젯에 의존하지 않는다.
    );
  }

  @override
  void didUpdateWidget(Backdrop old) { //위젯 업데이트 이후
    super.didUpdateWidget(old);

    if (widget.currentCategory != old.currentCategory) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _controller.fling(velocity: _kFlingVelocity);
    }
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween( //두 rect 보간
      begin: RelativeRect.fromLTRB(0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack( //Stack은 하위 위젯을 겹칠 수 있다. 하위 위젯의 크기와 위치는 스택을 기준으로 지정된다.
      key: _backdropKey, //GlobalKey를 위젯의 키로 사용하면, state를 잃지 않고 위젯트리를 이동할 수 있다(부모 위젯 변경할 수 있다).
      //일반적으로 자식이 하나인 경우에는 키가 필요하지 않다.
      children: <Widget>[
        ExcludeSemantics( //자식 위젯을 위젯 트리에서 제외한다.
          child: widget.backLayer, //제외할 위젯
          excluding: _frontLayerVisible, //제외 여
        ),
        PositionedTransition( //위치 애니메이션
          rect: layerAnimation,
          child: _FrontLayer(
              onTap: _toggleBackdropLayerVisibility,
              child: widget.frontLayer,
          ),
        ),
        //Flutter Inspector에서 실제 backLayer와 frontLayer의 앞 뒤 관계를 파악할 수 있다.
      ],
    );
  }

  bool get _frontLayerVisible { //읽기 전용 (computable property라 생각하면 될 듯)
    final AnimationStatus status = _controller.status; //animation의 상태를 가져온다.

    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling( //스프링 애니메이션
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }
}




class _FrontLayer extends StatelessWidget {
  const _FrontLayer({
    Key key,
    this.onTap,
    this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(46.0)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              height: 40.0,
              alignment: AlignmentDirectional.centerStart,
            ),
          ),
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }
}

class _BackdropTitle extends AnimatedWidget {
  final Function onPress;
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    Key key,
    Listenable listenable,
    this.onPress,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(frontTitle != null),
        assert(backTitle != null),
        super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;

    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Row(children: <Widget>[
        // branded icon
        SizedBox(
          width: 72.0,
          child: IconButton(
            padding: EdgeInsets.only(right: 8.0),
            onPressed: this.onPress,
            icon: Stack(children: <Widget>[
              Opacity(
                opacity: animation.value,
                child: ImageIcon(AssetImage('assets/slanted_menu.png')),
              ),
              FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(1.0, 0.0),
                ).evaluate(animation),
                child: ImageIcon(AssetImage('assets/diamond.png')),
              )]),
          ),
        ),
        // Here, we do a custom cross fade between backTitle and frontTitle.
        // This makes a smooth animation between the two texts.
        Stack(
          children: <Widget>[
            Opacity(
              opacity: CurvedAnimation(
                parent: ReverseAnimation(animation),
                curve: Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(0.5, 0.0),
                ).evaluate(animation),
                child: backTitle,
              ),
            ),
            Opacity(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset(-0.25, 0.0),
                  end: Offset.zero,
                ).evaluate(animation),
                child: frontTitle,
              ),
            ),
          ],
        )
      ]),
    );
  }
}