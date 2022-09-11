//
//  UIColor+.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/11.
//

import UIKit

extension UIColor {
  convenience init(_ red: Int, _ green: Int, _ blue: Int, alpha: CGFloat = 1.0) {
    self.init(
      red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255),
      alpha: alpha
    )
  }

  convenience init(hexString: String, alpha: CGFloat = 1.0) {
    let scanner = Scanner(string: hexString)
    scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
    let hexInt = UInt32(bitPattern: scanner.scanInt32(representation: .hexadecimal) ?? 0)

    let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
    let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
    let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
