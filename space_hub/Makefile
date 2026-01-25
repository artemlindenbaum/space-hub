get:
	fvm flutter pub get --no-example

gen:
	fvm dart run build_runner build --delete-conflicting-outputs

clean:
	flutter clean

deps:
	flutter pub deps > dependencies_tree.txt

package:
	flutter create --template=package packages/$(name)
# make lib name=my_lib

plugin:
	flutter create --org plugin.sdk --template=plugin --platforms=android,ios $(name)
# make plug name=my_plugin

format:
	dart format -l 80 .

fix_dry:
	dart fix --dry-run

fix:
	dart fix --apply

build:
	flutter build apk --split-per-abi

intl:
	fvm dart run intl_utils:generate

run_browser:
	fvm flutter run -d chrome
