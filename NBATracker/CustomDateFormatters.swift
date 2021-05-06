//
//  CustomDateFormatters.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-04.
//

import Foundation

class CustomDateFormatters {

    public static var iso8601FullFormatter: DateFormatter {
        print("Entered public static iso8601FullFormatter")
        return CustomDateFormatters.iso8601Full
    }
    
    public static var yyyyMMddFormatter: DateFormatter {
        print("Entered public static yyyyMMddFormatter")
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
        print("Instanciate private formatter iso8601Full")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
      }()
    
    private static let yyyyMMdd: DateFormatter = {
        print("Instanciate private formatter yyyyMMdd")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
      }()
    
    private static let localTimeShort: DateFormatter = {
        print("Instanciate private formatter localTimeShort")
        let formatter = DateFormatter()
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "UTC" }
        formatter.locale = Locale.init(identifier: localTimeZoneAbbreviation)
        formatter.timeStyle = .short
        return formatter
    }()
    
    private static let localDateMedium: DateFormatter = {
        print("Instanciate private formatter localDateMedium")
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
