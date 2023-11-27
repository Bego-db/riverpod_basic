import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/model/user_model.dart';
import 'package:riverpod_app/riverpod/riverpod_controller.dart';
import 'package:riverpod_app/view/Loading.dart';

final controller = ChangeNotifierProvider((ref) => Controller());

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    ref.read(controller).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(controller);
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: LoadingWidget(
        isLoad: watch.isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        watch.pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 2000),
                            curve: Curves.fastLinearToSlowEaseIn);
                      },
                      child: Text("Kullanıcılar (${watch.userData.length})")),
                  ElevatedButton(
                      onPressed: () {
                        watch.pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.fastLinearToSlowEaseIn);
                      },
                      child: Text("Kaydedilenler (${watch.saveUser.length})"))
                ],
              ),
              SizedBox(height: 15),
              Expanded(
                child: PageView(
                  controller: watch.pageController,
                  children: [
                    ListView.separated(
                        separatorBuilder: (BuildContext context, int ince) {
                          return const PaddingDivider();
                        },
                        itemCount: watch.userData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UserCard(
                            watch: watch,
                            user: watch.userData,
                            index: index,
                          );
                        }),
                    ListView.separated(
                        separatorBuilder: (BuildContext context, int ince) {
                          return const PaddingDivider();
                        },
                        itemCount: watch.saveUser.length,
                        itemBuilder: (BuildContext context, int indexs) {
                          return UserCardSaved(
                            watch: watch,
                            user: watch.saveUser,
                            index: indexs,
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
    required this.index,
    required this.watch,
  });

  final List<Data?> user;
  final int index;
  final Controller watch;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        watch.addUser(watch.userData[index]!);
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
              backgroundImage: NetworkImage("${user[index]!.avatar}")),
          title: Text("${user[index]!.firstName} ${user[index]!.lastName}"),
          subtitle: Text("${user[index]!.email}"),
        ),
      ),
    );
  }
}

class UserCardSaved extends StatelessWidget {
  const UserCardSaved({
    super.key,
    required this.user,
    required this.index,
    required this.watch,
  });

  final List<Data?> user;
  final int index;
  final Controller watch;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        watch.incramentUser(watch.saveUser[index]!);
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
              backgroundImage: NetworkImage("${user[index]!.avatar}")),
          title: Text("${user[index]!.firstName} ${user[index]!.lastName}"),
          subtitle: Text("${user[index]!.email}"),
        ),
      ),
    );
  }
}

class PaddingDivider extends StatelessWidget {
  const PaddingDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Divider(color: Colors.amber),
    );
  }
}
