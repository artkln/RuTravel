// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 100% <br/> (0x000000ff)
  internal static let black = ColorName(rgbaValue: 0x000000ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#0650c2"></span>
  /// Alpha: 100% <br/> (0x0650c2ff)
  internal static let blue = ColorName(rgbaValue: 0x0650c2ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 0% <br/> (0x00000000)
  internal static let clear = ColorName(rgbaValue: 0x00000000)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#dc143c"></span>
  /// Alpha: 100% <br/> (0xdc143cff)
  internal static let crimson = ColorName(rgbaValue: 0xdc143cff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#808080"></span>
  /// Alpha: 100% <br/> (0x808080ff)
  internal static let gray = ColorName(rgbaValue: 0x808080ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#9bb9e6"></span>
  /// Alpha: 100% <br/> (0x9bb9e6ff)
  internal static let lightBlue = ColorName(rgbaValue: 0x9bb9e6ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ededed"></span>
  /// Alpha: 100% <br/> (0xedededff)
  internal static let lightGray = ColorName(rgbaValue: 0xedededff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let white = ColorName(rgbaValue: 0xffffffff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
