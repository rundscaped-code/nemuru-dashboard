# 永遠ねむる Analytics Dashboard

VTuber「永遠ねむる」のYouTube/Twitch/Xアナリティクス統合ダッシュボード。

## アクセス
GitHub Pages 公開URL（デプロイ後反映）：
- https://rundscaped-code.github.io/nemuru-dashboard/

## 構成
- `index.html` — メインダッシュボード（Tailwind CDN + Chart.js + Lucide icons）
- `data/` — CSV等のデータ（公開リポジトリの場合、含めない方が良い場合は `.gitignore` で除外）

## 更新フロー
1. ローカルでデータ取得（`scripts/run_analytics.bat` 等）
2. ダッシュボード値を更新（手動 or 自動スクリプト）
3. `deploy_to_github.bat` を叩く → GitHub に push → Pages 自動再デプロイ

## ライセンス
個人用ダッシュボード。データの再配布は禁止。
