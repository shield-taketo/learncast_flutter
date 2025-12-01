FVM = fvm flutter
FVMD = fvm dart

.PHONY: run-ios run-android run-web run-web-5173 \
    clean get analyze format test gen gen-watch ci

run-ios:
	$(FVM) run -d ios

run-android:
	$(FVM) run -d android

run-web:
	$(FVM) run -d chrome

run-web-5173:
	$(FVM) run -d chrome --web-port=5173

clean:
	$(FVM) clean

get:
	$(FVM) pub get

analyze:
	$(FVM) analyze

format:
	$(FVM) format . --line-length=120

test:
	$(FVM) test --coverage

gen:
	$(FVMD) run build_runner build --delete-conflicting-outputs

gen-watch:
	$(FVMD) pub run build_runner watch --delete-conflicting-outputs

ci: get gen analyze test
