//
//  RuTravelButton.swift
//  RuTravel
//
//  Created by kalinin on 05.05.2022.
//

import UIKit

final class RuTravelButton: UIButton {

    // MARK: - Nested types

    enum Style {
        typealias BorderSettings = (borderWidth: CGFloat, borderColor: CGColor)
        typealias TitleSettings = (color: UIColor, font: UIFont)

        case blue
        case exit
    }

    // MARK: - Private Properties

    private var style: Style = .blue

    // MARK: - Internal methods

    func set(_ title: String) {
        setTitle(title, for: .normal)
    }

    func applyStyle(_ style: Style) {
        self.style = style
        applyTitleSettings(style.titleProperties)
        applyBackgroundColor(style)
        applyRoundedCorners(style.cornerRadius)

        if style.isBorderNeeded {
            applyBorderSettings(style.borderProperties)
        }
    }

    func setEnabled(_ enabled: Bool) {
        isEnabled = enabled

        if style == .blue {
            backgroundColor = enabled ? ColorName.blue.color : ColorName.lightBlue.color
        }
    }

    // MARK: - Configuration

    private func applyTitleSettings(_ settings: Style.TitleSettings) {
        setTitleColor(settings.color, for: .normal)
        setTitleColor(settings.color, for: .disabled)
        setTitleColor(settings.color, for: .highlighted)
        titleLabel?.font = settings.font
    }

    private func applyBorderSettings(_ settings: Style.BorderSettings) {
        layer.borderWidth = settings.borderWidth
        layer.borderColor = settings.borderColor
    }

    private func applyBackgroundColor(_ style: Style) {
        backgroundColor = style.backgroundColor
    }

    private func applyRoundedCorners(_ cornerRadius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }

}

// MARK: - LabirintButton.Style

extension RuTravelButton.Style {

    var backgroundColor: UIColor {
        switch self {
        case .exit:
            return ColorName.white.color
        case .blue:
            return ColorName.blue.color
        }
    }

    var borderProperties: BorderSettings {
        switch self {
        case .exit:
            return (1.0, ColorName.crimson.color.cgColor)
        case .blue:
            return (0.0, ColorName.clear.color.cgColor)
        }
    }

    var isBorderNeeded: Bool {
        switch self {
        case .exit:
            return true
        case .blue:
            return false
        }
    }

    var titleProperties: TitleSettings {
        switch self {
        case .blue:
            return (ColorName.white.color, FontFamily.SFProDisplay.regular.font(size: 20.0))
        case .exit:
            return (ColorName.crimson.color, FontFamily.SFProDisplay.regular.font(size: 20.0))
        }
    }

    var cornerRadius: CGFloat {
        switch self {
        case .blue, .exit:
            return 5.0
        }
    }

}

// MARK: - UIResponder

extension RuTravelButton {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0.5
        }
        super.touchesBegan(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        }
        super.touchesEnded(touches, with: event)
    }

}
