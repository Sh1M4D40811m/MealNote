# モックサーバーコマンド
.PHONY: mockoon-run
# モックサーバ起動
mockoon-run:
	@docker rm -f mealnote-mockoon > /dev/null 2>&1 || true
	@docker run -d \
		--name mealnote-mockoon \
		-p 3000:3000 \
		-v ~/mealnote-env.json:/data/environment.json \
		mockoon/cli:latest \
		-d /data/environment.json -p 3000 && \
	echo "✅ Docker restarted: Mockoon is running at http://localhost:3000" || \
	echo "❌ Docker failed to start. Please check logs."
# コンテナ停止
mockoon-stop:
	@docker stop mealnote-mockoon || true
# コンテナ削除
mockoon-clean:
	@docker rm -f mealnote-mockoon || true

# プロジェクト生成
.PHONY: project
project:
	@xcodegen generate && \
	echo "✅ Xcode project generated!" || \
	echo "❌ Failed to generate Xcode project."
