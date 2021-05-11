//
//  CustomFormatters.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-04.
//

import Foundation

class CustomDateFormatters {

    public static var iso8601FullFormatter: DateFormatter {
        return CustomDateFormatters.iso8601Full
    }
    
    public static var yyyyMMddFormatter: DateFormatter {
        return CustomDateFormatters.yyyyMMdd
    }
    
    public static var localTimeShortFormatter: DateFormatter {
        return CustomDateFormatters.localTimeShort
    }
    
    public static var localDateMediumFormatter: DateFormatter {
        return CustomDateFormatters.localDateMedium
    }
    
    public static var yyyyFormatter: DateFormatter {
        return CustomDateFormatters.yyyy
    }

    private static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
      }()
    
    private static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
      }()
    
    private static let localTimeShort: DateFormatter = {
        let formatter = DateFormatter()
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "UTC" }
        formatter.locale = Locale.init(identifier: localTimeZoneAbbreviation)
        formatter.timeStyle = .short
        return formatter
    }()
    
    private static let localDateMedium: DateFormatter = {
        let formatter = DateFormatter()
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "UTC" }
        formatter.locale = Locale.init(identifier: localTimeZoneAbbreviation)
        formatter.dateStyle = .medium
        return formatter
    }()
    
    private static let yyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static func convertDateTolocalTimeShortString(for date: Date) -> String {
        return CustomDateFormatters.localTimeShortFormatter.string(from: date)
    }
    
    static func convertDateTolocalDateMediumString(for date: Date) -> String {
        return CustomDateFormatters.localDateMediumFormatter.string(from: date)
    }
    
    static func convertDateToyyyyMMddString(for date: Date) -> String {
        return CustomDateFormatters.yyyyMMddFormatter.string(from: date)
    }
    
    static func convertDateToyyyyString(for date: Date) -> String {
        return CustomDateFormatters.yyyyFormatter.string(from: date)
    }
}

class CustomNumberFormatters {

    public static var decimalMaxThreeFractionDigitsFormatter: NumberFormatter {
        return CustomNumberFormatters.decimalMaxThreeFractionDigits
    }
    
    private static let decimalMaxThreeFractionDigits: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 3
        return formatter
      }()
    
    static func convertDoubleToDecimalString(for double: Double) -> String {
        let number = NSNumber(value: double)
        return CustomNumberFormatters.decimalMaxThreeFractionDigitsFormatter.string(from: number)!
    }
}
