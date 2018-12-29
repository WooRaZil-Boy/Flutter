import "dart:math" as math;

import "package:flutter/material.dart";
import "package:meta/meta.dart";

import "category.dart";

const double _kFlingVelocity = 2.0;

class _BackdropPanel extends StatelessWidget {
  const _BackdropPanel({
    Key key,
    this.onTap,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.title,
    this.child,
  })  : super(key: key);

  final VoidCallback onTap; //VoidCallback은 반환 형이 없는 function
  final GestureDragUpdateCallback onVerticalDragUpdate; //스크린의 포인터가 다시 움직이기 시작했을 때 호출 된다.
  final GestureDragEndCallback onVerticalDragEnd; //스크린의 포인터의 움직임이 종료되었을 때 호출된다.
  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.only( //0이 아닌 값을 가지는 BorderRadius를 생성. 나머지 값은 모두 직각이 된다.
        topLeft: Radius.circular(16.0), //x와 y가 같은 값을 가지는 Radius
        topRight: Radius.circular(16.0)
      ),
      child: Column( //Column은 Vertical Array로 생각할 수 있다.
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector( //GestureDetector로 묶어 제스처를 지정해 줄 수 있다.
            behavior: HitTestBehavior.opaque,
            onVerticalDragUpdate: onVerticalDragUpdate, //시작될 때
            onVerticalDragEnd: onVerticalDragEnd, //끝날 때
            onTap: onTap,
            child: Container(
              height: 48.0,
              padding: EdgeInsetsDirectional.only(start: 16.0), //지정 값 외에 0인 세트
              alignment: AlignmentDirectional.centerStart,
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.subhead,
                child: title,
              ),
            ),
          ),
          Divider( //수평선. 양쪽에 패딩이 있다.
            height: 1.0,
          ),
          Expanded( //Row, Column, Flex의 자식 위젯을 확장한다.
            child: child,
          )
        ],
      ),
    );
  }
}

class _BackdropTitle extends AnimatedWidget { 
  //AnimatedWidget은 Listenable 값이 변경되면 다시 build 되는 위젯
  //애니메이션이 있는 StatelessWidget에 적합하다.
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    Key key,
    Listenable listenable, //Listenable는 객체가 업데이트 될 때 클라이언트에 알리는데 사용된다.
    this.frontTitle,
    this.backTitle,
  }) : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;
    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis, //텍스트가 영역 벗어날 때 설정
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: CurvedAnimation(
              parent: ReverseAnimation(animation),
              curve: Interval(0.5, 1.0)
            ).value,
            child: backTitle,
          ),
          
          Opacity(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Interval(0.5, 1.0)
            ).value,
            child: frontTitle,
          ),
        ],
      ),
    );
  }
}

class Backdrop extends StatefulWidget {
  final Category currentCategory;
  final Widget frontPanel;
  final Widget backPanel;
  final Widget frontTitle;
  final Widget backTitle;
  //위의 각 요소들로 Backdrop이 구성된다.

  const Backdrop({
    @required this.currentCategory,
    @required this.frontPanel,
    @required this.backPanel,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(currentCategory != null),
        assert(frontPanel != null),
        assert(backPanel != null),
        assert(frontTitle != null),
        assert(backTitle != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop> with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller; //애니메이션용 컨트롤러

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this, //TickerProvider 여기서는 SingleTickerProviderStateMixin
      //Ticker는 애니메이션 프레임마다 콜백을 한 번 호출한다.
    );
  }

  @override
  void didUpdateWidget(Backdrop old) {
    super.didUpdateWidget(old);

    if (widget.currentCategory != old.currentCategory) {
      setState(() {
        _controller.fling( //스프링 애니메이션
          velocity: _backdropPanelVisible ? -_kFlingVelocity : _kFlingVelocity);     
      });
    } else if (!_backdropPanelVisible) {
      setState(() {
        _controller.fling(velocity: _kFlingVelocity);
      });
    }
  }

  @override
  void dispose() { //리소스 해제
    _controller.dispose();
    super.dispose();
  }

  bool get _backdropPanelVisible { //computed property
    final AnimationStatus status = _controller.status;

    return status == AnimationStatus.completed || 
        status == AnimationStatus.forward;
  }

  void _toggleBackdropPanelVisibility() {
    _controller.fling(
      velocity: _backdropPanelVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  double get _backdropHeight {
    final RenderBox renderBox = _backdropKey.currentContext.findRenderObject(); //좌표계의 렌더링 객체
    //findRenderObject으로 위젯의 현재 렌더링 객체를 찾는다.

    return renderBox.size.height;
  }

  void _handleDragUpdate(DragUpdateDetails details) { //panel은 swipe 제스처로만 열 수 있도록 한다.
    //DragUpdateDetails는 drag로 업데이트 되면 받아오는 콜백
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    _controller.value -= details.primaryDelta / _backdropHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy / _backdropHeight;

    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(_kFlingVelocity, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-_kFlingVelocity, -flingVelocity));
    else
      _controller.fling(
          velocity:
              _controller.value < 0.5 ? -_kFlingVelocity : _kFlingVelocity);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double panelTitleHeight = 48.0;
    final Size panelSize = constraints.biggest;
    final double panelTop = panelSize.height - panelTitleHeight;

    Animation<RelativeRect> panelAnimation = RelativeRectTween(
      //RelativeRect는 CGRect와 비슷. frame으로 생각하고 쓰면 된다.
      begin: RelativeRect.fromLTRB(
          0.0, panelTop, 0.0, panelTop - panelSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);

    return Container(
      key: _backdropKey,
      color: widget.currentCategory.color,
      child: Stack(
        children: <Widget>[
          widget.backPanel,
          PositionedTransition(
            rect: panelAnimation,
            child: _BackdropPanel(
              onTap: _toggleBackdropPanelVisibility,
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              title: Text(widget.currentCategory.name),
              child: widget.frontPanel,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.currentCategory.color,
        elevation: 0.0,
        leading: IconButton(
          onPressed: _toggleBackdropPanelVisibility,
          icon: AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: _controller.view,
          ),
        ),
        title: _BackdropTitle(
          listenable: _controller.view,
          frontTitle: widget.frontTitle,
          backTitle: widget.backTitle,
        ),
      ),
      body: LayoutBuilder(
        builder: _buildStack,
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}

//많은 Widget들이 Gesture를 이미 포함하고 있다.
//따로 제스처를 지정해 줘야 할 때에는 GestureDetector 객체로 해당 Widget을 감싸주면 된다.

//◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤와 함께 노란색과 검은색이 섞여 나온다면, overflow 된 것이다.





