compile:
	cd playground && flutter build web --web-renderer canvaskit --no-tree-shake-icons

deploy:
	cd playground && firebase deploy

compile_and_deploy: compile deploy

publish:
	dart pub publish

# Agent/dev workflow targets (mirror CI: .github/workflows/flutter-test.yaml)
.PHONY: setup lint test check
setup:
	flutter pub get
	cd cli && dart pub get
	cd playground && flutter pub get

lint:
	flutter analyze

test:
	flutter test

check: lint test
