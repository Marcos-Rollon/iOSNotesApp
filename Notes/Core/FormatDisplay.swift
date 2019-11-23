//
//  FormatDisplay.swift
//
//  Created by Marcos Rollón Rivas on 26/2/19.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

///Set of functions to convert data to be shown in the UI
struct FormatDisplay {
    ///Time from seconds ( Int ) to Hours, minutes, seconds with format
    static func time (_ seconds : Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute , .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from : TimeInterval(seconds))!
    }
    
    ///Time from seconds ( Int ) to Hours and minutes with format
    static func timeShort( _ seconds : Int) -> String{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from : TimeInterval(seconds))!
    }
    
    ///Date from Date() to string formatted in the long way
    static func longDate (_ date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return formatter.string(from: date)
    }
    
    ///Date from Date() to string formatted in a short way
    static func shortDate ( _ date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy HH:mm"
        return formatter.string(from: date)
    }
    
    ///Date from Date() to string without the hours
    static func dateNoHours( _ date : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        return formatter.string(from: date)
    }
    
    ///Distance from meters (double) to km (String) with format, 2 decimals
    static func distanceToKm ( _ distanceInMeters : Double ) -> String {
        let distanceKm = distanceInMeters / 1000
        let distanceRounded = String(format: "%.2f Km", distanceKm)
        return distanceRounded
    }
    
    ///Distance from meters (double) to km ( Sting ) with format, 1 decimal
    static func distanceToKmShort ( _ distanceInMeters : Double ) -> String {
        let distanceKm = distanceInMeters / 1000
        let distanceRounded = String(format: "%.1f Km", distanceKm)
        return distanceRounded
    }
    
    ///Distance from meters ( double ) to km ( string ) with format, no decimals
    static func distanceToKmNoDecimals( _ distanceInMeters : Double) -> String{
        let distanceKm = distanceInMeters / 1000
        let distanceRounded = String(format: "%.0f Km", distanceKm)
        return distanceRounded
    }
    
    
    ///Speed from m/s (Double) to min/km with format
    static func speedToMinPerKm ( _ speedInMetersPerSecond : Double) -> String {
        if speedInMetersPerSecond <= 0.8 {  //Less than 1 m/s is too low to show it in this format
            return " - "
        }
        let speedInMinPerKm = 16.6667 / speedInMetersPerSecond
        let remainder = speedInMinPerKm.truncatingRemainder(dividingBy: 1)

        if(speedInMinPerKm == Double.nan){
            return " - "
        }
        let minutesValue = Int(speedInMinPerKm - remainder)
        let secondsValue = Int((remainder * 60).rounded())

        let minutesString = addZeros(String(minutesValue))
        let secondsString = addZeros(String(secondsValue))
        return "\(minutesString):\(secondsString) min/Km"
    }
    
    ///Speed from m/s ( Double) to km/h string with format
    static func speedToKmPerHour ( _ speedInMetersPerSecond : Double, decimals : Int? = nil) -> String {
        let speedInKmPerHour = speedInMetersPerSecond * 3.6
        let speedString : String
        if let decimals = decimals{
            speedString = stringfyNumber(number: speedInMetersPerSecond, dividedBy: 1, numOfDecimals: decimals) + " Km/h"
        }else{
            speedString = String(format: "%.2f Km/h", speedInKmPerHour)
        }
        return speedString
    }
    
    ///Speed from m/s ( Double ) to km/h string with no decimals
    static func speedToKmPerHourSimple ( _ speedInMetersPerSecond : Double) -> String {
        let speedInKmPerHour = speedInMetersPerSecond * 3.6
        let speedString = String(format: "%.0f Km/h", speedInKmPerHour)
        return speedString
    }
    
    ///Distance from m (Double) to m (String) with format
    static func meters ( _ meters : Double) -> String{
        let metersString = String(format: "%.0f", meters.rounded())
        return "\(metersString)m"
    }
    
    ///Percentaje from Double to string with format
    static func percentage( _ percent : Double) -> String {
        let percentageString = String(format: "%.1f", percent)
        return "\(percentageString) %"
    }
    
    ///Helper to add 0 infront off single digit numbers
    static func addZeros(_ stringToAddZeros : String) -> String{
        if( stringToAddZeros.count == 1){
            return "0\(stringToAddZeros)"
        }
        else {
            return stringToAddZeros
        }
    }
    /// Format calories to kCal
    static func calories(_ calories : Double) -> String {
        if calories < 1000{
            return "\(stringfyNumber(number: calories, dividedBy: 1, numOfDecimals: 1)) cal"
        }else {
            return "\(stringfyNumber(number: calories, dividedBy: 100, numOfDecimals: 1)) Kcal"
        }
    }
    
    ///Function to convert height(Double) to m or Km with format
    static func height(_ height : Double)->String{
        if height > 1000{
            return stringfyNumber(number: height, dividedBy: 1000, numOfDecimals: 2) + " Km"
        }else{
            return stringfyNumber(number: height, dividedBy: 1, numOfDecimals: 1) + " m"
        }
    }
    
    ///Function to convert a number (Double) to a string, with a factor and a chosed decimal numbers
    static func stringfyNumber(number : Double, dividedBy : Double, numOfDecimals : Int ) -> String {
        guard dividedBy != 0 else {return ""}
        let numberToConvert = number / dividedBy
        let numberString = String(format: "%.\(numOfDecimals)f", numberToConvert)
        return numberString
    }
}

