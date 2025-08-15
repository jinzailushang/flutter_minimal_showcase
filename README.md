# Flutter 最小演示项目

一个用于展示的最小 Flutter 项目，覆盖状态管理、网络、性能与工程化（CI/CD、Docker）。
IOS
<img width="898" height="1910" alt="image" src="https://github.com/user-attachments/assets/9db2db96-838e-4826-975c-6f34e734aa15" />
Android
<img width="946" height="1868" alt="image" src="https://github.com/user-attachments/assets/c618a633-19a7-46c2-8338-1c12ccebe25d" />
web
<img width="2302" height="1604" alt="image" src="https://github.com/user-attachments/assets/ef20a61e-a84f-43f3-aae6-3a6c5e190976" />

## 亮点
- Riverpod 状态管理、Dio 网络、Navigator 2.0（go_router）
- 错误态与重试、收藏本地状态、列表/详情闭环
- 性能优化：避免不必要 rebuild、列表优化、DevTools 采样
- 工程化：analyze/test/build CI、可选 Docker 部署 Web 产物

## 目录结构
```
lib/
  main.dart
  app.dart
  router.dart
  common/dio_client.dart
  features/repo_browser/
    data/{github_api.dart, repo_model.dart, repo_repository.dart}
    logic/{repo_search_provider.dart, favorites_provider.dart}
    ui/{repo_list_page.dart, repo_detail_page.dart, widgets/repo_tile.dart}
.github/workflows/ci.yml
Dockerfile
analysis_options.yaml
```

## 架构
- 分层：data（API/Model/Repo）/ logic（StateNotifier+Provider）/ ui（Pages+Widgets）
- 依赖注入：`Provider` 组合（`dioProvider` → `apiProvider` → `repoRepositoryProvider`）
- 路由：`go_router` 声明式路由栈，可深链

## 状态管理说明
- 搜索：`StateNotifier<RepoSearchState>` 管理 `loading/items/error`
- 收藏：`StateNotifier<Set<String>>`，当前内存态，易于扩展为 Hive 持久化

## 性能实践
- 列表 `ListView.builder`，`RepoTile` 控制重绘范围
- 使用 DevTools Timeline 采样定位 jank；避免在 `build` 中执行重逻辑
- 可扩展：输入节流/懒加载/图片占位、`RepaintBoundary`

## 本地运行
```bash
# 需安装 Flutter SDK（stable）
flutter pub get
flutter run
# web 体验
flutter run -d chrome
```

## 测试
```bash
flutter test
```

## 持续集成（CI）
- 见 `.github/workflows/ci.yml`：checkout → flutter-action → 依赖安装（pub get）→ 代码静态检查（analyze）→ 单元测试（test）→ 构建产物（apk/web）→ 上传产物

## Docker（可选，Web 产物）
```bash
docker build -t flutter-showcase .
docker run -p 8080:80 flutter-showcase
```

## 可展示的扩展点
- Hive/Isar 做收藏与离线缓存；Etag 协商缓存
- 指标：首屏、滚动帧率、错误率；Sentry 崩溃与日志
- 平台通道：相册/剪贴板；权限处理
