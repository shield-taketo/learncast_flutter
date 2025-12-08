# LearnCast Flutter

学習動画を快適に視聴できる **クロスプラットフォーム学習アプリ** の **サンプルコード** です。

Flutter（Dart）をベースに、Riverpod / go_router / freezed などで構築しています。

Web / iOS / Android の 3プラットフォームに対応しています。

## 動作環境

- Dart SDK: `>=3.8.0 <4.0.0`
- Flutter: 3.38 系
- FVM を利用して Flutter SDK を管理しています

## 依存パッケージ

- go_router: 画面遷移
- hooks_riverpod / riverpod_generator: 状態管理
- freezed / json_serializable: モデル生成
- dio: API クライアント
- video_player: 動画再生
- golden_toolkit / mocktail: テスト

## 環境構築

本プロジェクトは **FVM（Flutter Version Management）** を利用しています。

[fvmのインストール方法はこちら](https://fvm.app/documentation/getting-started)

## envファイル

`asstes/.env`を用意する必要があります。

```txt:.env
API_BASE_URL=https://jsonplaceholder.typicode.com
WEB_BASE_URL=
```

## コマンド一覧

| Make                | 実行する処理 |
| ------------------- | -----------|
| make run-ios        | iOSアプリの起動|
| make run-android    | Androidアプリの起動|
| make run-web        | Webアプリの起動|
| make run-web-5173   | Webアプリの起動 (ポート5173で固定)|
| make clean          | キャッシュの削除|
| make get            | 依存パッケージ取得|
| make analyze        | 静的解析|
| make format         | 自動フォーマット (line-length 120)|
| make test           | Unit / UI テスト (coverage 含む)|
| make gen            | 一回生成|
| make gen-watch      | 監視しながら自動生成|
| make ci             | CI 用の一括実行 (get → analyze → test)|
