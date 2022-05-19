lass_SplashScreenStateextendsState<SplashScreen> {

@override
voidinitState() {
  super.initState();
  Timer(
    constDuration(seconds: 3),
        () =>
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => constMyHomePage(),
        ),
        ),
  );
}

@override
Widgetbuild(BuildContextcontext) {
  returnScaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          logo(160, 160),
          constSizedBox(
            height: 25,
          ),
          richText(30),
        ],
      ),
    ),
  );
}

Widgetlogo(doubleheight_, doublewidth_) {
  returnSvgPicture.asset(
    'assets/logo.svg',
    height: height_,
    width: width_,
  );
}

WidgetrichText(doublefontSize) {
  returnText.rich(
    TextSpan(
      style: GoogleFonts.inter(
        fontSize: fontSize,
        color: constColor(0xFF21899C),
        letterSpacing: 3,
        height: 1.03,
      ),
      children: const [
        TextSpan(
          text: 'UIC',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        TextSpan(
          text: 'NOTIFIER \n HELLO ',
          style: TextStyle(
            color: Color(0xFFFE9879),
            fontWeight: FontWeight.w800,
          ),
        ),
        TextSpan(
          text: 'KIT',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
    textAlign: TextAlign.center,
  );
}
}