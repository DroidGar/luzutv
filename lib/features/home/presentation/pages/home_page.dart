import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luzu/core/services/di_service.dart';
import 'package:luzu/core/widgets/loading_widget.dart';
import 'package:luzu/features/home/presentation/manager/home_cubit.dart';
import 'package:luzu/features/home/presentation/widgets/app_bar.dart';
import 'package:luzu/features/home/presentation/widgets/drawer.dart';
import 'package:luzu/features/survey/presentation/widgets/survey_widget.dart';
import 'package:luzu/features/user/presentation/pages/complete_profile_page.dart';
import 'package:luzu/features/video/video_widget.dart';
import 'package:luzu/features/video/video_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  String title = 'En vivo';
  YoutubePlayerController? controller;
  final floating = Floating();
  final _cubit = getIt<HomeCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cubit.loadMe();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('AppLifecycleState: $state');
  }

  @override
  Widget build(BuildContext context) {
    final videoId = Provider.of<VideoProvider>(context).videoId;
    if (videoId.isEmpty) {
      return const Text('No video selected');
    }

    final videoWidget = VideoWidget(
      videoId: videoId,
      onMetadataChange: (metadata) {
        title = metadata.title;
        if (title.isEmpty) {
          title = 'En vivo';
        }
        setState(() {});
      },
      onControllerLoad: (ctrl) {
        controller = ctrl;
      },
    );

    return BlocConsumer<HomeCubit, HomeState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is HomeFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.failure.message)));
        }

        if (state is HomeLoaded) {
          if (!state.user.isProfileComplete) {
            // context.pushReplacement(CompleteProfilePage.routeName);
          }
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const LoadingWidget();
        }
        if (state is HomeFailure) {
          return Center(
              child: Text(state.failure.message,
                  style: Theme.of(context).textTheme.bodyLarge));
        }
        return PiPSwitcher(
          childWhenDisabled: Scaffold(
            endDrawer: drawer(context),
            body: body(videoWidget),
          ),
          childWhenEnabled: videoWidget,
        );
      },
    );
  }

  Widget body(videoWidget) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              MyAppBar(),
              ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: videoWidget,
              ),
              SizedBox(height: 14),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 14),
              SurveyWidget(),
              ElevatedButton(
                onPressed: () {
                  // final floating = Floating();
                  // floating.isPipAvailable.then((isPipAvailable) async {
                  //   await floating.enable(const ImmediatePiP());
                  // });
                },
                child: const Text('Enable PiP'),
              ),
            ],
          ),
        ),
      );
}
