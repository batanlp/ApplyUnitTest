//
//  AirQualityData.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 12/10/2021.
//

import Foundation

class AirQualityData: Codable {
    let aqi: Int?
    let idx: Int?
    let attributions: [Attributions]?
    let city: CityObject?
    let dominentpol: String?
    let iaqi: IAQI?
    let time: TimeValue?
    let forecast: Forecast?
    let debug: DebugObject?
}

class DebugObject: Codable {
    let sync: String?
}

class Attributions: Codable {
    let url: String?
    let name: String?
    let logo: String?
}

class CityObject: Codable {
    let geo: [Double]?
    let name: String?
    let url: String?
}

class IAQI: Codable {
    let co: AirQualityValue?
    let h: AirQualityValue?
    let no2: AirQualityValue?
    let o3: AirQualityValue?
    let p: AirQualityValue?
    let pm10: AirQualityValue?
    let pm25: AirQualityValue?
    let so2: AirQualityValue?
    let t: AirQualityValue?
    let w: AirQualityValue?
}

class AirQualityValue: Codable {
    let v: Double?
}

class TimeValue: Codable {
    let s: String?
    let tz: String?
    let v: Int?
    let iso: String?
}

class Forecast: Codable {
    let daily: DailyForeCastData?
}

class DailyForeCastData: Codable {
    let o3: [DetailForecaseValue]?
    let pm10: [DetailForecaseValue]?
    let pm25: [DetailForecaseValue]?
    let uvi: [DetailForecaseValue]?
}

class DetailForecaseValue: Codable {
    let avg: Int?
    let day: String?
    let max: Int?
    let min: Int?
}
