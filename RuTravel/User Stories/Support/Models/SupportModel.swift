//
//  SupportModel.swift
//  RuTravel
//
//  Created by kalinin on 23.05.2022.
//

import Foundation

struct SupportModel {

    let mainText = "Есть вопросы? Свяжитесь с нами любым из следующих способов, и мы обязательно Вам ответим:"

    let phoneText = "+7 (921) 857-32-85"

    var vkLink: NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "Профиль VK")
        attributedString.addAttribute(
            .link,
            value: "https://vk.com/tom_klnn",
            range: NSRange(location: 0, length: attributedString.length)
        )
        attributedString.addAttribute(
            .font,
            value: FontFamily.SFProDisplay.regular.font(size: 19) as Any,
            range: NSRange(location: 0, length: attributedString.length)
        )
        return attributedString
    }

    var telegramLink: NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "Профиль Telegram")
        attributedString.addAttribute(
            .link,
            value: "https://t.me/art_kln",
            range: NSRange(location: 0, length: attributedString.length)
        )
        attributedString.addAttribute(
            .font,
            value: FontFamily.SFProDisplay.regular.font(size: 19) as Any,
            range: NSRange(location: 0, length: attributedString.length)
        )
        return attributedString
    }

    let copyrightText = "© 2022 Artem Kalinin. All rights reserved."

}
