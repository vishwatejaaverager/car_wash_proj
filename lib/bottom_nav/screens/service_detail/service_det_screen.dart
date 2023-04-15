import 'dart:developer';

import 'package:car_wash_proj/bottom_nav/navigation_drawer.dart';
import 'package:car_wash_proj/bottom_nav/screens/scedule_screen.dart';
import 'package:car_wash_proj/models/service_model.dart';
import 'package:car_wash_proj/utils/color.dart';
import 'package:car_wash_proj/utils/navigation/navigator.dart';
import 'package:car_wash_proj/utils/routes.dart';
import 'package:car_wash_proj/utils/utils.dart';
import 'package:car_wash_proj/utils/widget/button.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_expandable_widget/flutter_expandable_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constants/constants.dart';
import '../../providers/home_provider.dart';

class ServiceDetailScreen extends ConsumerStatefulWidget {
  final ServiceModel serviceModel;
  static const id = AppRoutes.serviceDetScreen;
  const ServiceDetailScreen({super.key, required this.serviceModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends ConsumerState<ServiceDetailScreen> {
  final List<VideoPlayerController> _controllers = [];
  // final List videos = [
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
  // ];

  // final List servDet = [
  //   'Full Exterior Car Wash',
  //   'Vaccuming of Interior',
  //   'Dashboard & Door pads Cleaning',
  //   'Wheel & Wheel Arch Cleaning',
  //   'Boot cleaning',
  //   'Windshield cleaning',
  //   'Tyres dressing'
  // ];

  // late ChewieController chewieController;

  @override
  void initState() {
    for (var element in widget.serviceModel.serviceVideos) {
      log(element);
      _controllers.add(VideoPlayerController.network(element,
          videoPlayerOptions: VideoPlayerOptions())
        ..initialize().then((val) {
          _controllers.first.setLooping(true);
          _controllers[0].play();
          setState(() {});
        }));
    }
    super.initState();
  }

  @override
  void dispose() {
    for (var element in _controllers) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8),
        child: Button(
          text: "Book",
          onTap: () {
            log("clicked");
            Navigation.instance
                .navigateTo(ScheduleScreen.id.path, args: widget.serviceModel);
          },
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        backgroundColor: Colors.white,
        elevation: 0,
        // title: const Text("Home"),
      ),
      drawer: const CustomNavigation(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _controllers[0].value.isInitialized
                ? SizedBox(
                    height: 200,
                    child: PageView.builder(
                      onPageChanged: (value) {
                        ref.read(homeProv).configActiveImage(value);
                        _controllers[value].play();
                      },
                      itemCount: _controllers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Display the video thumbnail
                            InkWell(
                                onTap: () {
                                  _controllers[index].pause();
                                },
                                child: VideoPlayer(_controllers[index])),
                            Positioned(
                              bottom: 8,
                              child: Consumer(
                                builder: (context, ref, child) {
                                  log("built simple indicator");
                                  final homePros = ref.watch(homeProv);
                                  return Center(
                                    child: AnimatedSmoothIndicator(
                                      effect: ExpandingDotsEffect(
                                          dotColor: Colors.grey,
                                          expansionFactor: 3,
                                          dotHeight: 6,
                                          activeDotColor: primaryColor),
                                      activeIndex: homePros.activeImage,
                                      count: widget
                                          .serviceModel.serviceVideos.length,
                                      curve: Curves.linear,
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Display a play icon overlay on top of the thumbnail
                          ],
                        );
                      },
                    ),
                  )
                : const CircularProgressIndicator(),
            ListTile(
              minLeadingWidth: 0,
              minVerticalPadding: 0,
              horizontalTitleGap: 4,
              title: Text(
                widget.serviceModel.serviceName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Service Time :${widget.serviceModel.serviceTime}",
                style: const TextStyle(fontSize: 12),
              ),
              trailing: Text(
                "Rs${widget.serviceModel.servicePrice}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Constants.hour,
                        scale: 20,
                        color: primaryColor,
                      ),
                      sbw(4),
                      Text(
                        "${widget.serviceModel.serviceTime}Minutes",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Constants.like,
                        scale: 20,
                        color: primaryColor,
                      ),
                      sbw(4),
                      Text(
                        "${widget.serviceModel.recommendation}(Recommended)",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "What's Included",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.serviceModel.included.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_box,
                          color: primaryColor,
                        ),
                        sbw(12),
                        SizedBox(
                            width: size.width / 1.3,
                            child: Text(widget.serviceModel.included[index])),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "What happens after booking ? ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Image.asset(
                  Constants.qstn,
                  scale: 18,
                )
              ],
            ),
            Stepper(
                physics: const NeverScrollableScrollPhysics(),
                currentStep: 2,
                controlsBuilder: (context, details) {
                  return const SizedBox();
                },
                steps: const [
                  Step(
                      title: Text("Agent"),
                      subtitle: Text('Agent will arrive at your door step'),
                      state: StepState.indexed,
                      isActive: true,
                      content: SizedBox()),
                  Step(
                      title: Text("Waching"),
                      subtitle: Text('Agent Will Wash Your Car in 30mins '),
                      state: StepState.indexed,
                      isActive: true,
                      content: SizedBox()),
                  Step(
                      title: Text("Completion"),
                      subtitle: Text(
                          'Agent will complete service and take your feedback'),
                      state: StepState.complete,
                      isActive: true,
                      content: SizedBox()),
                ]),
            const Faqs(),
            sbh(32)

            // CupertinoStepper(
            //   controlsBuilder: (context, details) {
            //     return const SizedBox();
            //   },
            //   steps: const [
            //     Step(
            //         title: Text("Agent"),

            //         subtitle: Text('Agent will arrive at your door step'),
            //         state: StepState.indexed,
            //         isActive: true,
            //         content: SizedBox())
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

class Faqs extends StatelessWidget {
  const Faqs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      trailing: const Icon(Icons.arrow_downward),
      trailingStartTurns: 1,
      trailingEndTurns: 0.75,
      trailingDuration: const Duration(milliseconds: 350),
      trailingPosition: TrailingPosition.right,
      title: const Text(
        'Frequently Asked Questions',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      childrenPadding: const EdgeInsets.only(top: 16),
      children: [
        Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        "Q .",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: size.width / 1.4,
                        child: const Center(
                          child: Text(
                            "Do You offer any Warranty with this service ?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        "A .",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: size.width / 1.4,
                        child: const Center(
                          child: Text(
                            "We do not offer any warranty on this service.",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
