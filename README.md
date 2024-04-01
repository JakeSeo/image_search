# 다음 이미지 검색 애플리케이션

카카오 다음 검색 Open API를 활용한 간단한 이미지 검색 애플리케이션

https://developers.kakao.com/docs/latest/ko/daum-search/dev-guide 

## 주요 기능

- 이미지 검색
- 검색기록 저장 (로컬)
- 이미지 즐겨찾기 등록 (로컬)
- 이미지 상세 보기 (이미지 공유)
- 이미지 출처 사이트 보기 (웹뷰)

### 스크린샷 

<img src = "https://github.com/JakeSeo/image_search/assets/10471865/13d569e6-93da-43e2-9f5f-49cc33217767" width="25%"/>
<img src = "https://github.com/JakeSeo/image_search/assets/10471865/8cec641f-434e-4a30-addd-2db87d05bd13" width="25%"/>
<img src = "https://github.com/JakeSeo/image_search/assets/10471865/1283d540-5d17-4924-9057-c151869b6d99" width="25%"/>
<img src = "https://github.com/JakeSeo/image_search/assets/10471865/86e2a064-1d19-439d-aee9-096dc95eff30" width="25%"/>
<img src = "https://github.com/JakeSeo/image_search/assets/10471865/d045a1ca-f6f7-4729-b8e8-61b63e4d08c0" width="25%"/>

## 빌드 방법

1. 앱을 빌드하기전 카카오 디벨로퍼스에서 내 애플리케이션을 생성한후 REST API 키와 Open API의 Base URL을 .env 파일에 아래와 같이 추가해줍니다. 

```
// ./.env 파일
REST_API_KEY=...
BASE_URL=https://dapi.kakao.com
```

2. 아래 명령들을 통해 애플리케이션을 빌드해줍니다. 

```
% flutter pub get
% dart pub run build_runner build --delete-conflicting-outputs
% flutter run
```

## 개발 환경

```
% flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.16.9, on macOS 14.4 23E214 darwin-arm64, locale en-KR)
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0)
[✓] Xcode - develop for iOS and macOS (Xcode 15.3)
[✓] Android Studio (version 2021.2)
[✓] VS Code (version 1.87.2)
[✓] Connected device (5 available)
```

## 사용된 패키지 목록
```yaml
dependencies:
  flutter:
    sdk: flutter

  cached_network_image: ^3.3.1
  dio: ^5.4.2+1
  flutter_dotenv: ^5.1.0
  flutter_bloc: ^8.1.5
  get_it: ^7.6.7
  go_router: ^13.2.2
  json_annotation: ^4.8.1
  retrofit: ^4.1.0
  shared_preferences: ^2.2.2
  equatable: ^2.0.5
  share_plus: ^7.2.2
  webview_flutter: ^4.7.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  build_runner: ^2.4.8
  flutter_lints: ^2.0.0
  json_serializable: ^6.7.1
  retrofit_generator: ^8.1.0
```
