// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// キャンセル
  internal static let cancel = L10n.tr("Localizable", "cancel", fallback: "キャンセル")
  /// マイセット呼び出し
  internal static let diaryEntryCallMySet = L10n.tr("Localizable", "diaryEntryCallMySet", fallback: "マイセット呼び出し")
  /// メモ
  internal static let diaryEntryMemoHeader = L10n.tr("Localizable", "diaryEntryMemoHeader", fallback: "メモ")
  /// 付け合わせなど（例：白米、味噌汁...）
  internal static let diaryEntryMemoPlaceholder = L10n.tr("Localizable", "diaryEntryMemoPlaceholder", fallback: "付け合わせなど（例：白米、味噌汁...）")
  /// 日時を選択
  internal static let diaryEntrySelectDateHeader = L10n.tr("Localizable", "diaryEntrySelectDateHeader", fallback: "日時を選択")
  /// 画像を追加
  internal static let diaryEntrySelectImageHeader = L10n.tr("Localizable", "diaryEntrySelectImageHeader", fallback: "画像を追加")
  /// タイトル
  internal static let diaryEntryTitleHeader = L10n.tr("Localizable", "diaryEntryTitleHeader", fallback: "タイトル")
  /// メイン料理など（例：焼き鮭、唐揚げ...）
  internal static let diaryEntryTitlePlaceholder = L10n.tr("Localizable", "diaryEntryTitlePlaceholder", fallback: "メイン料理など（例：焼き鮭、唐揚げ...）")
  /// MealNote
  internal static let diaryTopNavigationTitle = L10n.tr("Localizable", "diaryTopNavigationTitle", fallback: "MealNote")
  /// Localizable.strings
  ///   MealNote
  /// 
  ///   Created by shimadamio on 2025/04/11.
  internal static let save = L10n.tr("Localizable", "save", fallback: "保存")
  /// 決定
  internal static let `set` = L10n.tr("Localizable", "set", fallback: "決定")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
