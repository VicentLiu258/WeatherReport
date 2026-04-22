# Weather Report

Flutter 天气预报应用基础工程，当前已完成 Android/iOS 可运行项目骨架、应用入口、路由框架与天气业务分层占位。

## 已完成内容

- Android 与 iOS 平台工程初始化
- `main -> App -> AppRouter` 入口链路
- 天气模块分层目录：`data / domain / presentation`
- 核心占位能力：`constants / errors / network`

## 目录结构

```text
lib/
  app/
    app.dart
    router/
      app_router.dart
  core/
    constants/
    errors/
    network/
  features/
    weather/
      data/
      domain/
      presentation/
  main.dart
```

## 本地运行

```bash
flutter pub get
flutter analyze
flutter run -d ios
flutter run -d android
```

## 后续建议

- 接入天气 API（例如 OpenWeather 或和风天气）
- 在 `weather` 模块中补充 DTO、数据源与仓储实现
- 根据设计稿完善 `presentation` 层 UI 与状态管理
