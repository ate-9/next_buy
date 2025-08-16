## NextBuy（買い物リスト管理）

Rails 8 で実装されたシンプルな買い物リスト管理アプリです。ユーザー登録・ログインを行い、リストとアイテムを作成・管理できます。リストは作成者のみが閲覧・編集可能です。

## 主な機能
- ユーザー登録／ログイン（Cookie ベースのセッション管理）
- リストの作成・編集・削除（作成者限定）
- アイテムの追加・編集・削除（リスト配下）
- PWA 用のマニフェスト／Service Worker 下書き（任意で有効化可能）

## 技術スタック
- Ruby: 3.4.3
- Rails: 8.0.2
- DB: SQLite3（開発／テスト）
- Web サーバ: Puma
- フロントエンド: Importmap + Hotwire（Turbo / Stimulus）、Tailwind CSS（`tailwindcss-rails`）
- アセット: Propshaft
- ジョブ／キャッシュ／ケーブル: `solid_queue` / `solid_cache` / `solid_cable`
- デプロイ: Docker（マルチステージ） + Thruster + Kamal

## 必要要件
- Ruby 3.4 系（`.ruby-version` は 3.4.3）
- Bundler（`gem install bundler`）
- SQLite3（開発用）

## セットアップ
1. 依存関係のインストール
   - `bundle install`
2. データベースの作成／マイグレーション
   - `bin/rails db:prepare`
3. 初期データ（任意）
   - `bin/rails db:seed`（必要に応じて `db/seeds.rb` を編集）

## 開発サーバの起動
- Rails サーバ: `bin/rails server`
- Tailwind の監視: `bin/rails tailwindcss:watch`
- Procfile.dev を使う場合（foreman / overmind など）:
  - `foreman start -f Procfile.dev` または `overmind start -f Procfile.dev`

## 環境設定
- タイムゾーンは `Tokyo` に設定済み（`config/application.rb`）
- Importmap のピンは `config/importmap.rb` を参照
- PWA を有効化する場合は、`config/routes.rb` の該当行（`rails/pwa#manifest` 等）を有効化し、`app/views/pwa/*` を調整してください

## 認証・セッション
- `Authentication` concern による未認証アクセスの制御
- 署名付き Cookie（`cookies.signed[:session_id]`）でセッションを復元
- ログイン: `SessionsController#create`
- ログアウト: `SessionsController#destroy`

## データモデル（概要）
- User: `has_secure_password`、`name` / `email_address` はユニーク
- List: 作成者（author: User）必須、購入者（buyer: User）は任意、複数の Item を保持
- Item: List に所属、`name` 必須
- Session: User に所属（セッション記録）

## テスト／静的解析
- Rails 標準の `test/` ディレクトリあり（最小限）
- セキュリティ診断: `brakeman`
- Lint: `rubocop-rails-omakase`

## デプロイ（概要）
### Docker イメージのビルド／実行
```
docker build -t next_buy .
docker run -d -p 80:80 -e RAILS_MASTER_KEY=<config/master.key の値> --name next_buy next_buy
```

### Kamal によるデプロイ
- 設定: `config/deploy.yml`
- レジストリ資格情報や `RAILS_MASTER_KEY` は `.kamal/secrets` 経由で注入
- SQLite を永続化するためのボリューム設定（例: `next_buy_storage:/rails/storage`）を利用

## 環境変数（例）
- `RAILS_MASTER_KEY`: 本番用資格情報の復号に必須
- `SOLID_QUEUE_IN_PUMA`: `true`（デフォルト、Puma 内で Solid Queue を実行）

## 既知の事項／今後の改善
- パスワードリセットは下書き状態（通知メッセージに「未対応」）。実運用時はトークン発行と検証フローを整備してください。
- Stimulus の初期化とコントローラ定義が一部重複しています。`app/javascript/application.js` に初期化を集約し、`app/javascript/controllers/*_controller.js` にコントローラを配置する構成へ整理を検討してください。
- `ItemsController#update` で `@item` の取得とパラメータ許可の見直しが必要です（`@item = @list.items.find(params[:id])`、`item_params` の利用など）。
- `ItemsController#create` のエラーパスでテンプレート名を指定するよう修正が必要です（例: `render "lists/show", status: :unprocessable_entity`）。

## コントリビュート指針（ブランチ戦略）
- `main` へは直接コミットせず、トピックブランチで PR を作成してください。
- 例: `docs/readme-ja-draft`, `feat/<機能名>`, `fix/<不具合名>` などの命名を推奨します。

---

何か不明点があれば Issue／PR で相談してください。
