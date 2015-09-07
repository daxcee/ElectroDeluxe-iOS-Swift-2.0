//
//  TimeFormatter.swift
//  ElectroDeluxe-Swift2.0
//
//  Convert milliseconds to a formatted output string containing hours:minutes:seconds
//  with padding zero.
//
//  Created by c0d3r on 21/08/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation

class TimeFormatter {
    
    func getFormattedDurationString(trackDuration: NSNumber?) -> String {
       
        guard let trackDuration = trackDuration where trackDuration.doubleValue > 1000.0 else {
            return "00:00:00"
        }
        
        let milliseconds = trackDuration.doubleValue
        var seconds = milliseconds / 1000;
        var minutes = seconds / 60;
        seconds %= 60;
        let hours = minutes / 60;
        minutes %= 60;

        var timeComponents = Dictionary<String,NSNumber>()
        timeComponents = ["hours":Int(hours), "minutes":Int(minutes),"seconds":Int(seconds)]
        
        return self.durationStringBuilder(timeComponents)
    }

    private func durationStringBuilder(timeComponents:NSDictionary?) -> String {
        
        var result:String = ""
        
        guard let timeComponents = timeComponents where timeComponents.count == 3 else {
            return result
        }
        
        let hours = setZeroPadding(timeComponents["hours"] as? Int, delimiter: false)
        let minutes = setZeroPadding(timeComponents["minutes"] as? Int, delimiter: false)
        let seconds = setZeroPadding(timeComponents["seconds"] as? Int, delimiter: true)
    
        result.append(hours)
        result.append(minutes)
        result.append(seconds)
        
        return result
    }
    
    private func setZeroPadding(timeComponent: Int?, delimiter: Bool) -> String {
        
        var result:String = ""
        
        guard let timeComponent = timeComponent where timeComponent > 0 else {
            if !delimiter {
                result.append("00:")
                return result
            } else {
                result.append("00")
                return result
            }
        }

        if(timeComponent < 10){
            if !delimiter {
                    result.append("0\(timeComponent):")
            } else{
                result.append("0\(timeComponent)")
            }
        } else {
            if !delimiter {
                result.append("\(timeComponent):")
            } else{
                result.append("\(timeComponent)")

            }
        }
        
        return result
    }
}


