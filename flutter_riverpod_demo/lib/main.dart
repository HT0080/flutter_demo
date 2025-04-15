import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hello = ref.watch(helloProvider);
    final count = ref.watch(counterNotifierProvider);
    final asyncUser = ref.watch(userProvider);
    // 监听变化
    ref.listen<int>(counterNotifierProvider, (prev, next) {
      print('counter changed from $prev to $next');
    });
    // 依赖注入
    final asyncValue = ref.watch(fetchProvider);

    // 使用selet() 精准监听属性
    final userName = ref.watch(userSelectProvider.select((user) => user.name));

    // 使用select() 精准监听属性
    final stateNotifierCount = ref.watch(
      counterStateNotifierProvider.select((state) => state.count),
    );
    final countNotifier = ref.read(counterStateNotifierProvider.notifier);

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(hello),
              Text(ref.watch(counterProvider).toString()),
              ElevatedButton(
                onPressed: () => ref.read(counterProvider.notifier).state++,
                child: Text("点击+1"),
              ),
              Text('$count'),
              ElevatedButton(
                onPressed: () {
                  ref.read(counterNotifierProvider.notifier).increment();
                  ref.read(userSelectProvider.notifier).state = ref
                      .read(userSelectProvider)
                      .copyWith(name: "张三");
                  countNotifier.increment();
                },
                child: const Text('Increment'),
              ),
              asyncUser.when(
                data: (user) => Text("Hello ${user.name}"),
                error: (e, _) => Text('Error: $e'),
                loading: () => const CircularProgressIndicator(),
              ),
              asyncValue.when(
                data: (data) => Text('$data'),
                error: (e, _) => Text('错误'),
                loading: () => const CircularProgressIndicator(),
              ),
              Text('$userName'),
              Text('count: $count'),
            ],
          ),
        ),
      ),
    );
  }
}

final helloProvider = Provider<String>((ref) {
  return "Hello Riverpod";
});
// 简单状态管理
final counterProvider = StateProvider<int>((ref) => 0);
// 使用StateNotifierProvider

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  void increment() => state++;
}

final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>((
  ref,
) {
  return CounterNotifier();
});

// 使用FutureProvider/StreamProvider(异步)
final userProvider = FutureProvider<User>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return User(name: "Alice");
});

// 依赖注入
class ApiService {
  Future<String> fetchData() async => "From server";
}

final apiServiceProvider = Provider((ref) => ApiService());

// 注入
final fetchProvider = FutureProvider((ref) {
  final api = ref.watch(apiServiceProvider);
  return api.fetchData();
});

// 状态组合
final searchKeywordProvider = StateProvider<String>((ref) => "");
final fullItemListProvider = Provider<List<String>>(
  (ref) => ["apple", "banana", "grape", "orange"],
);

final filteredListProvider = Provider<List<String>>((ref) {
  final keyword = ref.watch(searchKeywordProvider);
  final items = ref.watch(fullItemListProvider);
  return items.where((item) => item.contains(keyword)).toList();
});

// 使用selet() 精准监听属性
class User {
  final String name;
  User({required this.name});

  User copyWith({String? name}) {
    return User(name: name ?? this.name);
  }
}

final userSelectProvider = StateProvider((ref) => User(name: 'alice'));

// 使用select 精准监听属性

class CounterState {
  final int count;
  final String name;
  CounterState({required this.count, required this.name});

  CounterState copyWith({int? count, String? name}) {
    return CounterState(count: count ?? this.count, name: name ?? this.name);
  }
}

class CounterStateNotifier extends StateNotifier<CounterState> {
  CounterStateNotifier() : super(CounterState(count: 0, name: "张三"));

  void increment() {
    state = state.copyWith(count: state.count + 1);
  }

  void changeName(String newName) {
    state = state.copyWith(name: newName);
  }
}

final counterStateNotifierProvider = StateNotifierProvider<CounterStateNotifier, CounterState>(
  (ref) => CounterStateNotifier(),
);
