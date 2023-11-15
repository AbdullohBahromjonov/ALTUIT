//
//  Extenstions.swift
//  TATU litsey
//
//  Created by Abdulloh on 07/09/23.
//

import SwiftUI

var error = ""

let subgroups = ["2", "1"]
let groups = ["101", "102", "103", "104", "105", "106", "107", "108", "109", "201", "202", "203", "204", "205", "206", "207", "208"]

var color: (String) -> Color = {(day: String) -> Color in
    switch day {
    case "Dushanba":
        return Color.assets.yellow
    case "Seshanba":
        return Color.assets.red
    case "Chorshanba":
        return Color.assets.purple
    case "Payshanba":
        return Color.assets.blue
    case "Juma":
        return Color.assets.green
    case "Shanba":
        return Color.assets.orange
    default:
        return Color.assets.scarlet
    }
}

extension String {
    func define() -> (color: String, emoji: String) {
        switch self {
        case "Algebra":
            return (color: "C24B4B", emoji: "🧮")
        case "Nemis tili":
            return (color: "AD4646", emoji: "🇩🇪")
        case "Biologiya":
            return (color: "46AD82", emoji: "🪴")
        case "Geometriya":
            return (color: "465DAD", emoji: "📐")
        case "Kimyo":
            return (color: "BC5DE9", emoji: "🧪")
        case "Fizika":
            return (color: "FFC700", emoji: "💡")
        case "Ingliz tili":
            return (color: "E95D5D", emoji: "🇬🇧")
        case "Jismoniy tarbiya":
            return (color: "E9A05D", emoji: "🏋️")
        case "Rus tili":
            return (color: "5D8DE9", emoji: "🇷🇺")
        case "O'zbek tili":
            return (color: "46AD82", emoji: "🇺🇿")
        case "Ona tili":
            return (color: "46AD82", emoji: "🇺🇿")
        case "Tarbiya":
            return (color: "56BAD0", emoji: "👩‍🏫")
        case "Informatika":
            return (color: "29278B", emoji: "💾")
        case "Geografiya":
            return (color: "3C72FF", emoji: "🌍")
        case "O'zbekiston tarixi":
            return (color: "E9A05D", emoji: "🕌")
        case "Jaxon tarixi":
            return (color: "5B3D99", emoji: "🏛️")
        case "Adabiyot":
            return (color: "0D643F", emoji: "📚")
        case "Kasbiy ta'lim":
            return (color: "DD7B21", emoji: "👷")
        case "Veb dasturlash":
            return (color: "184BFF", emoji: "🌐")
        case "CH.Q.B.T.":
            return (color: "0D643F", emoji: "🪖")
        default:
            return (color: "5B3D99", emoji: "")
        }
    }
    
    func day() -> String {
        switch self {
        case "dushanba", "Monday":
            return "1"
        case "seshanba", "Tuesday":
            return "2"
        case "chorshanba", "Wednesday":
            return "3"
        case "payshanba", "Thursday":
            return "4"
        case "juma", "Friday":
            return "5"
        case "shanba", "Saturday":
            return "6"
        default:
            return ""
        }
    }
}

func today(_ now: Date) -> (weekday: String, month: String, date: String) {
    let weekFormatter = DateFormatter()
    let monthFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    
    weekFormatter.dateFormat = "EEEE"
    monthFormatter.dateFormat = "MMM"
    dateFormatter.dateFormat = "dd.MM"
    
    return (
        weekFormatter.string(from: now),
        monthFormatter.string(from: now),
        dateFormatter.string(from: now)
    )
}

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    static let assets = Assets()
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct Assets {
    let blue = Color("Blue")
    let green = Color("Green")
    let navy = Color("Navy")
    let orange = Color("Orange")
    let purple = Color("Purple")
    let red = Color("Red")
    let scarlet = Color("Scarlet")
    let yellow = Color("Yellow")
    let secondary = Color("Secondary")
    let darkGray = Color("Dark gray")
}
