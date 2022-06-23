CRATE_NAME = $(shell cargo metadata --format-version 1 | jq -r '.packages[0].name' | tr '-' '_')
xcframework: aarch64 x86_64
	@rm -rf target/xcframework_template.xcframework
	@xcodebuild -create-xcframework \
		-library "target/aarch64-apple-ios/release/lib$(CRATE_NAME).a" \
		-headers "includes" \
		-library "target/x86_64-apple-ios/release/lib$(CRATE_NAME).a" \
		-headers "includes" \
		-output "target/$(CRATE_NAME).xcframework"

aarch64:
	@cargo build --release --target aarch64-apple-ios

x86_64:
	@cargo build --release --target x86_64-apple-ios
