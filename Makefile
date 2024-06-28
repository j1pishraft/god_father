build_prod_apk:
				flutter build apk --release -t lib/main_pro.dart --flavor prod
build_qa_apk_release:
				flutter build apk --release -t lib/main_qa.dart --flavor qa
runApp:
				flutter run --debug -t lib/main_dev.dart --flavor dev
buildApk:
				flutter run build apk --release -t lib/main_dev.dart --flavor dev
buildBundle:
				flutter build appbundle --release -t lib/main_pro.dart --flavor prod
buildHuaweiBundle:
				flutter build appbundle --release -t lib/main_pro.dart --flavor qa
build_prod_apk_huawei:
				flutter build apk --release -t lib/main_huawei_prod.dart --flavor huaweiProd
build_prod_bundle_huawei:
				flutter build appbundle --release -t lib/main_huawei_prod.dart --flavor huaweiProd
build_ios:
				flutter build ios --flavor prod -t lib/main_pro.dart