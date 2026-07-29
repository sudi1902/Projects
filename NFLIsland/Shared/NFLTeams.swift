import SwiftUI

struct NFLTeam: Identifiable, Hashable {
    let id: Int
    let city: String
    let name: String
    let abbreviation: String
    let primaryHex: String
    let secondaryHex: String

    var fullName: String { "\(city) \(name)" }
    var primaryColor: Color { Color(hex: primaryHex) }
    var secondaryColor: Color { Color(hex: secondaryHex) }
}

enum NFLTeams {
    static let all: [NFLTeam] = [
        NFLTeam(id: 0,  city: "Arizona",      name: "Cardinals",  abbreviation: "ARI", primaryHex: "97233F", secondaryHex: "FFB612"),
        NFLTeam(id: 1,  city: "Atlanta",      name: "Falcons",    abbreviation: "ATL", primaryHex: "A71930", secondaryHex: "A5ACAF"),
        NFLTeam(id: 2,  city: "Baltimore",    name: "Ravens",     abbreviation: "BAL", primaryHex: "241773", secondaryHex: "9E7C0C"),
        NFLTeam(id: 3,  city: "Buffalo",      name: "Bills",      abbreviation: "BUF", primaryHex: "00338D", secondaryHex: "C60C30"),
        NFLTeam(id: 4,  city: "Carolina",     name: "Panthers",   abbreviation: "CAR", primaryHex: "0085CA", secondaryHex: "BFC0BF"),
        NFLTeam(id: 5,  city: "Chicago",      name: "Bears",      abbreviation: "CHI", primaryHex: "0B162A", secondaryHex: "C83803"),
        NFLTeam(id: 6,  city: "Cincinnati",   name: "Bengals",    abbreviation: "CIN", primaryHex: "FB4F14", secondaryHex: "FFFFFF"),
        NFLTeam(id: 7,  city: "Cleveland",    name: "Browns",     abbreviation: "CLE", primaryHex: "311D00", secondaryHex: "FF3C00"),
        NFLTeam(id: 8,  city: "Dallas",       name: "Cowboys",    abbreviation: "DAL", primaryHex: "003594", secondaryHex: "869397"),
        NFLTeam(id: 9,  city: "Denver",       name: "Broncos",    abbreviation: "DEN", primaryHex: "FB4F14", secondaryHex: "002244"),
        NFLTeam(id: 10, city: "Detroit",      name: "Lions",      abbreviation: "DET", primaryHex: "0076B6", secondaryHex: "B0B7BC"),
        NFLTeam(id: 11, city: "Green Bay",    name: "Packers",    abbreviation: "GB",  primaryHex: "203731", secondaryHex: "FFB612"),
        NFLTeam(id: 12, city: "Houston",      name: "Texans",     abbreviation: "HOU", primaryHex: "03202F", secondaryHex: "A71930"),
        NFLTeam(id: 13, city: "Indianapolis", name: "Colts",      abbreviation: "IND", primaryHex: "002C5F", secondaryHex: "A2AAAD"),
        NFLTeam(id: 14, city: "Jacksonville", name: "Jaguars",    abbreviation: "JAX", primaryHex: "006778", secondaryHex: "D7A22A"),
        NFLTeam(id: 15, city: "Kansas City",  name: "Chiefs",     abbreviation: "KC",  primaryHex: "E31837", secondaryHex: "FFB81C"),
        NFLTeam(id: 16, city: "Las Vegas",    name: "Raiders",    abbreviation: "LV",  primaryHex: "000000", secondaryHex: "A5ACAF"),
        NFLTeam(id: 17, city: "Los Angeles",  name: "Chargers",   abbreviation: "LAC", primaryHex: "0080C6", secondaryHex: "FFC20E"),
        NFLTeam(id: 18, city: "Los Angeles",  name: "Rams",       abbreviation: "LAR", primaryHex: "003594", secondaryHex: "FFA300"),
        NFLTeam(id: 19, city: "Miami",        name: "Dolphins",   abbreviation: "MIA", primaryHex: "008E97", secondaryHex: "FC4C02"),
        NFLTeam(id: 20, city: "Minnesota",    name: "Vikings",    abbreviation: "MIN", primaryHex: "4F2683", secondaryHex: "FFC62F"),
        NFLTeam(id: 21, city: "New England",  name: "Patriots",   abbreviation: "NE",  primaryHex: "002244", secondaryHex: "C60C30"),
        NFLTeam(id: 22, city: "New Orleans",  name: "Saints",     abbreviation: "NO",  primaryHex: "101820", secondaryHex: "D3BC8D"),
        NFLTeam(id: 23, city: "New York",     name: "Giants",     abbreviation: "NYG", primaryHex: "0B2265", secondaryHex: "A71930"),
        NFLTeam(id: 24, city: "New York",     name: "Jets",       abbreviation: "NYJ", primaryHex: "125740", secondaryHex: "FFFFFF"),
        NFLTeam(id: 25, city: "Philadelphia", name: "Eagles",     abbreviation: "PHI", primaryHex: "004C54", secondaryHex: "A5ACAF"),
        NFLTeam(id: 26, city: "Pittsburgh",   name: "Steelers",   abbreviation: "PIT", primaryHex: "FFB612", secondaryHex: "101820"),
        NFLTeam(id: 27, city: "San Francisco", name: "49ers",     abbreviation: "SF",  primaryHex: "AA0000", secondaryHex: "B3995D"),
        NFLTeam(id: 28, city: "Seattle",      name: "Seahawks",   abbreviation: "SEA", primaryHex: "002244", secondaryHex: "69BE28"),
        NFLTeam(id: 29, city: "Tampa Bay",    name: "Buccaneers", abbreviation: "TB",  primaryHex: "D50A0A", secondaryHex: "FF7900"),
        NFLTeam(id: 30, city: "Tennessee",    name: "Titans",     abbreviation: "TEN", primaryHex: "0C2340", secondaryHex: "4B92DB"),
        NFLTeam(id: 31, city: "Washington",   name: "Commanders", abbreviation: "WAS", primaryHex: "5A1414", secondaryHex: "FFB612"),
    ]

    /// Safe lookup that wraps any integer into the valid range.
    static func team(at index: Int) -> NFLTeam {
        let count = all.count
        return all[((index % count) + count) % count]
    }
}

extension Color {
    /// Creates a color from a 6-digit RRGGBB hex string.
    init(hex: String) {
        var value: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&value)
        self.init(
            red: Double((value >> 16) & 0xFF) / 255.0,
            green: Double((value >> 8) & 0xFF) / 255.0,
            blue: Double(value & 0xFF) / 255.0
        )
    }
}
