import 'package:car_wash_proj/bottom_nav/components/stepper_stat.dart';
import 'package:car_wash_proj/bottom_nav/providers/booking_provider.dart';
import 'package:car_wash_proj/bottom_nav/providers/order_provider.dart';
import 'package:car_wash_proj/bottom_nav/screens/home_screen.dart';
import 'package:car_wash_proj/models/order_model.dart';
import 'package:car_wash_proj/models/user_model.dart';
import 'package:car_wash_proj/utils/color.dart';
import 'package:car_wash_proj/utils/navigation/navigator.dart';
import 'package:car_wash_proj/utils/routes.dart';
import 'package:car_wash_proj/utils/streams.dart';
import 'package:car_wash_proj/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_stepper/easy_stepper.dart';
import '../components/order_header.dart';
import '../navigation_drawer.dart';

class OrderStatusScreen extends ConsumerStatefulWidget {
  static const id = AppRoutes.orderStatScreen;
  final String orderId;
  const OrderStatusScreen({super.key, required this.orderId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderStatusScreenState();
}

class _OrderStatusScreenState extends ConsumerState<OrderStatusScreen> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> orderStream;
  late UserModel userModel;
  final Streams _streams = Streams();
  @override
  void initState() {
    userModel = ref.read(bookingProv).userModel!;
    orderStream = _streams.userQuery
        .doc(userModel.userId)
        .collection(Streams.orders)
        .doc(widget.orderId)
        .snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        backgroundColor: Colors.white,
        elevation: 0,
        // title: const Text("Home"),
      ),
      drawer: const CustomNavigation(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Track Your Request",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              StreamBuilder(
                stream: orderStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    OrderModel orderModel =
                        OrderModel.fromMap(snapshot.data!.data()!);
                    return Column(
                      children: [
                        OrderHeader(
                            widget: widget,
                            userModel: userModel,
                            orderModel: orderModel),
                        sbh(16),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 6,
                          margin: const EdgeInsets.all(16),
                          //  padding: const EdgeInsets.all(16.0),
                          child: Consumer(
                            builder: (context, ref, child) {
                              final order = ref.watch(orderProv);
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EasyStepper(
                                      lineSpace: 0,
                                      // padding: EdgeInsetsDirectional.symmetric(vertical: 0),
                                      lineLength: 30,
                                      alignment: Alignment.topLeft,
                                      showTitle: false,
                                      stepRadius: 12,
                                      // finishedStepBorderColor: whiteColor,
                                      finishedStepIconColor: primaryColor,
                                      //  finishedStepBackgroundColor: primaryColor,
                                      activeStepBackgroundColor: primaryColor,
                                      unreachedStepBackgroundColor: Colors.grey,
                                      activeStepIconColor: primaryColor,
                                      direction: Axis.vertical,
                                      activeStep: order.configActiveState(
                                          orderModel.orderStat),
                                      steps: [
                                        const EasyStep(
                                          // lineText: 'line text',
                                          customStep: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 6,
                                          ),
                                          //  title: '',
                                          //topTitle: false,
                                        ),
                                        const EasyStep(
                                          lineText: 'line text',
                                          customStep: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 6,
                                          ),
                                          //  title: '',
                                          //topTitle: false,
                                        ),
                                        const EasyStep(
                                          lineText: 'line text',
                                          customStep: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 6,
                                          ),
                                          //  title: '',
                                          //topTitle: false,
                                        ),
                                        EasyStep(
                                          lineText: 'line text',
                                          customStep: CircleAvatar(
                                            backgroundColor: primaryColor,
                                            radius: 6,
                                          ),
                                          //  title: '',
                                          //topTitle: false,
                                        ),
                                      ]),
                                  StepperWidget(orderModel: orderModel)
                                ],
                              );
                            },
                          ),
                        ),
                        sbh(24),
                        InkWell(
                          onTap: () {
                            Navigation.instance
                                .pushAndRemoveUntil(HomeScreen.id.path);
                          },
                          child: Center(
                            child: Text(
                              'Go Back To Home',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return const Text("datan");
                  }
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}
