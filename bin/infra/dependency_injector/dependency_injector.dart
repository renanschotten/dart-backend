typedef InstanceCreator<T> = T Function();

class DependencyInjector {
  DependencyInjector._();

  static final _instance = DependencyInjector._();

  factory DependencyInjector() => _instance;

  final Map<Type, _InstanceGenerator<Object>> _instanceMap = {};

  //Register

  void register<T extends Object>(
    InstanceCreator<T> instance, {
    bool isSingleton = true,
  }) {
    _instanceMap[T] = _InstanceGenerator(instance, isSingleton);
  }
  //Get

  T get<T extends Object>() {
    final instance = _instanceMap[T]?.getInstance();
    if (instance != null && instance is T) {
      return instance;
    }
    throw Exception("[ERROR] -> Instance ${T.toString()} not found");
  }

  call<T extends Object>() => get<T>();
}

class _InstanceGenerator<T> {
  T? _instance;
  bool _isFirstGet = false;

  final InstanceCreator<T> _instanceCreator;

  _InstanceGenerator(this._instanceCreator, bool isSingleton)
      : _isFirstGet = isSingleton;

  T? getInstance() {
    if (_isFirstGet) {
      _instance = _instanceCreator();
      _isFirstGet = false;
    }
    return _instance ?? _instanceCreator();
  }
}
