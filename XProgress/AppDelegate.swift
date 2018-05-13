//
//  AppDelegate.swift
//  XProgress
//
//  Created by Hugo Striedinger on 5/13/18.
//  Copyright © 2018 Hugo Striedinger. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var dayPercent:Int?
    var monthPercent:Int?
    var yearPercent:Int?
    var timer = Timer()
    var dayPercentText:NSMenuItem?
    var monthPercentText:NSMenuItem?
    var yearPercentText:NSMenuItem?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        statusItem.title = "XProgress"
        dayPercent = getDayProgress()
        monthPercent = getMonthProgress()
        yearPercent = getYearProgress()
        constructMenu()
        timer = Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func constructMenu() {
        let menu = NSMenu()
        dayPercentText = NSMenuItem(title: "Day: \(dayPercent!)%", action: #selector(AppDelegate.showChoice(_:)), keyEquivalent: "")
        menu.addItem(dayPercentText!)
        monthPercentText = NSMenuItem(title: "Month: \(monthPercent!)%", action: #selector(AppDelegate.showChoice(_:)), keyEquivalent: "")
        menu.addItem(monthPercentText!)
        yearPercentText = NSMenuItem(title: "Year: \(yearPercent!)%", action: #selector(AppDelegate.showChoice(_:)), keyEquivalent: "")
        menu.addItem(yearPercentText!)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(AppDelegate.showPreferences(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "Q"))
        statusItem.menu = menu
    }
    
    @objc func updateProgress(){
        dayPercent = getDayProgress()
        dayPercentText!.title = "Day: \(dayPercent!)%"
        monthPercent = getMonthProgress()
        monthPercentText!.title = " Month: \(dayPercent!)%"
        yearPercent = getYearProgress()
        yearPercentText!.title = "Year: \(dayPercent!)%"
        print("doing something")
    }
    
    func getYearProgress() -> Int{
        let calendar = Calendar.current
        let date = Date()
        let interval = calendar.dateInterval(of: .year, for: date)!
        let day = calendar.ordinality(of: .day, in: .year, for: date)!
        let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        let result:Double = (Double(day)/Double(days))*100
        return Int(result)
    }
    
    func getMonthProgress() -> Int{
        let calendar = Calendar.current
        let date = Date()
        let interval = calendar.dateInterval(of: .month, for: date)!
        let day = calendar.ordinality(of: .day, in: .month, for: date)!
        let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        let result:Double = (Double(day)/Double(days))*100
        return Int(result)
    }
    
    func getDayProgress() -> Int {
        let hour = Calendar.current.component(.hour, from: Date())
        let result:Double = (Double(hour)/24)*100
        return Int(result)
    }

    @objc func showPreferences(_ sender: Any?){
        print("showing preferences...")
    }
    
    @objc func showChoice(_ sender: Any?){
        print(getDayProgress())
        //let day = calendar.ordinality(of: .day, in: .year, for: date)
        //print("Days \(day)")
    }

}

