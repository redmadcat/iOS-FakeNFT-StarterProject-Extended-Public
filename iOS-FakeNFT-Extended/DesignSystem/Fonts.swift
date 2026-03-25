import UIKit
import SwiftUI

extension UIFont {
    // Ниже приведены примеры шрифтов, настоящие шрифты надо взять из фигмы

    // Headline Fonts
    static var headline1 = UIFont.systemFont(ofSize: 34, weight: .bold)
    static var headline2 = UIFont.systemFont(ofSize: 28, weight: .bold)
    static var headline3 = UIFont.systemFont(ofSize: 22, weight: .bold)
    static var headline4 = UIFont.systemFont(ofSize: 20, weight: .bold)

    // Body Fonts
    static var bodyRegular = UIFont.systemFont(ofSize: 17, weight: .regular)
    static var bodyBold = UIFont.systemFont(ofSize: 17, weight: .bold)

    // Caption Fonts
    static var caption1 = UIFont.systemFont(ofSize: 15, weight: .regular)
    static var caption2 = UIFont.systemFont(ofSize: 13, weight: .regular)
}

extension Font {
    static var smallRegular = Font.system(size: 13, weight: .regular)
    static var mediumRegular = Font.system(size: 15, weight: .regular)
    static var largeBold = Font.system(size: 17, weight: .bold)
    static var largeRegular = Font.system(size: 17, weight: .regular)
    static var extraLargeBold = Font.system(size: 22, weight: .bold)
}
