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
    let progressController = ProgressController()
    var selectedPercent = 0
    var dayPercent:Int?
    var monthPercent:Int?
    var yearPercent:Int?
    var timer = Timer()
    var dayPercentText:NSMenuItem?
    var monthPercentText:NSMenuItem?
    var yearPercentText:NSMenuItem?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        handleCurrentPercent()
        constructMenu()
        timer = Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func constructMenu() {
        let menu = NSMenu()
        dayPercentText = NSMenuItem(title: progressController.getProgressText(option: 0, value: dayPercent!), action: #selector(AppDelegate.showChoice(_:)), keyEquivalent: "")
        dayPercentText?.tag = 0
        menu.addItem(dayPercentText!)
        monthPercentText = NSMenuItem(title: progressController.getProgressText(option: 1, value: monthPercent!), action: #selector(AppDelegate.showChoice(_:)), keyEquivalent: "")
        monthPercentText?.tag = 1
        menu.addItem(monthPercentText!)
        yearPercentText = NSMenuItem(title: progressController.getProgressText(option: 2, value: yearPercent!), action: #selector(AppDelegate.showChoice(_:)), keyEquivalent: "")
        yearPercentText?.tag = 2
        menu.addItem(yearPercentText!)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(AppDelegate.showPreferences(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "Q"))
        statusItem.menu = menu
    }
    
    func handleCurrentPercent(){
        dayPercent = progressController.getDayProgress()
        monthPercent = progressController.getMonthProgress()
        yearPercent = progressController.getYearProgress()
        switch(selectedPercent){
            case 0:
                statusItem.title = progressController.getProgressText(option: selectedPercent, value: dayPercent!)
            break
            case 1:
                statusItem.title = progressController.getProgressText(option: selectedPercent, value: monthPercent!)
            break
            default:
                statusItem.title = progressController.getProgressText(option: selectedPercent, value: yearPercent!)
        }
    }
    
    @objc func updateProgress(){
        dayPercent = progressController.getDayProgress()
        dayPercentText!.title = "Day: \(dayPercent!)%"
        monthPercent = progressController.getMonthProgress()
        monthPercentText!.title = " Month: \(dayPercent!)%"
        yearPercent = progressController.getYearProgress()
        yearPercentText!.title = "Year: \(dayPercent!)%"
        print("doing something")
    }

    @objc func showPreferences(_ sender: Any?){
        print("showing preferences...")
    }
    
    @objc func showChoice(_ sender: NSMenuItem){
        selectedPercent = sender.tag
        handleCurrentPercent()
    }

}

