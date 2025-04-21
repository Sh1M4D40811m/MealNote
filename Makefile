# モックサーバーコマンド
.PHONY: mockoon-run nginx-run mock-run mockoon-stop mockoon-clean check-docker project
# モックサーバ起動
mock-run: mockoon-run nginx-run
	echo "🚀 Mock Run Complete!!"
# APIモックサーバ起動
mockoon-run: check-docker
	@docker rm -f mealnote-mockoon > /dev/null 2>&1 || true
	@docker run -d \
		--name mealnote-mockoon \
		-p 3000:3000 \
		-v ~/api-response/mealnote/mealnote-env.json:/data/environment.json \
		mockoon/cli:latest \
		-d /data/environment.json -p 3000
	@if [ $$? -eq 0 ]; then \
		echo "✅ Mockoon is running at http://localhost:3000"; \
	else \
		echo "❌ Docker failed to start Mockoon. Please check logs."; \
	fi
# 画像モックサーバー起動
nginx-run: check-docker
	@docker rm -f mealnote-nginx > /dev/null 2>&1 || true
	@docker run -d \
		--name mealnote-nginx \
		-p 8080:80 \
		-v ~/api-response/mealnote/images:/usr/share/nginx/html:ro \
		nginx
	@if [ $$? -eq 0 ]; then \
		echo "✅ Nginx is running at http://localhost:8080"; \
	else \
		echo "❌ Docker failed to start Nginx. Please check logs."; \
	fi
# コンテナ停止
mockoon-stop:
	@docker stop mealnote-mockoon || true
	@docker stop mealnote-nginx || true
# コンテナ削除
mockoon-clean:
	@docker rm -f mealnote-mockoon || true
	@docker rm -f mealnote-nginx || true
# Docker の起動チェック & 自動起動 & 起動完了待機
check-docker:
	@if ! docker info > /dev/null 2>&1; then \
		echo "🚀 Docker Desktop を起動します..."; \
		open -a Docker; \
		echo "⏳ Docker の起動を待っています..."; \
		while ! docker info > /dev/null 2>&1; do \
			sleep 1; \
		done; \
		echo "✅ Docker が起動しました！"; \
	else \
		echo "✅ Docker はすでに起動しています"; \
	fi

# プロジェクト生成
.PHONY: project
project:
	@xcodegen generate
	@if [ $$? -eq 0 ]; then \
		echo "✅ Xcode project generated!"; \
	else \
		echo "❌ Failed to generate Xcode project."; \
	fi
