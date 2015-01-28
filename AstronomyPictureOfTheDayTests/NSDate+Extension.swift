//
//  File.swift
//  AstronomyPicture
//
//  Created by Håkon Bogen on 22.08.14.
//  Copyright (c) 2014 haaakon. All rights reserved.
//

import Foundation

extension NSDate {
    func dateByAddingDays(days: Int) -> NSDate {
        let components = NSDateComponents()
        components.day = days
        let calendar = NSCalendar.currentCalendar()
        return calendar.dateByAddingComponents(components, toDate: self, options: nil)!
    }
    
    func dateBySubtractingDays(days: Int) -> NSDate {
        let components = NSDateComponents()
        components.day = -days
        let calendar = NSCalendar.currentCalendar()
        return calendar.dateByAddingComponents(components, toDate: self, options: nil)!
    }
    
    func currentCalendarComponents() -> NSDateComponents{
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.SecondCalendarUnit | .MinuteCalendarUnit | .HourCalendarUnit | .DayCalendarUnit | .MonthCalendarUnit |  .YearCalendarUnit , fromDate: self)
        return components
    }
    func startOfDay() -> NSDate {
        let components = currentCalendarComponents()
        let calendar = NSCalendar.currentCalendar()
        components.hour = 0
        components.minute = 0
        components.second = 0
        return calendar.dateFromComponents(components)!
    }
    func endOfDay() -> NSDate {
        let components = currentCalendarComponents()
        components.minute = 59
        components.hour = 23
        components.second = 59
        let calendar = NSCalendar.currentCalendar()
        return calendar.dateFromComponents(components)!
    }
    func days() -> Int {
        let components = currentCalendarComponents()
        return components.day
    }
    
    func weekOfYear() -> Int {
        let components = currentCalendarComponents()
        return components.weekOfYear
    }
    
    func month() -> Int {
        let components = currentCalendarComponents()
        return components.month
    }
}