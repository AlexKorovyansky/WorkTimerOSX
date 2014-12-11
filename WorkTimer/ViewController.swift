//
//  ViewController.swift
//  WorkTimer
//
//  Created by Alex Korovyansky on 09/12/14.
//  Copyright (c) 2014 Alex Korovyansky. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {


    @IBOutlet var timer: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("update"), userInfo: nil, repeats: true)

    }

    override func viewDidAppear() {
        super.viewDidLoad()
        self.view.window?.movableByWindowBackground = true
        self.view.window?.level = Int(CGWindowLevelForKey(Int32(kCGFloatingWindowLevelKey)))
    }
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func update() {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        let seconds = components.second
        
        let targetTimeInSeconds = 18*60*60 + 0*60 + 0;
        let currentTimeInSeconds = hour*60*60 + minutes*60 + seconds;

        let diffInSeconds = (targetTimeInSeconds - currentTimeInSeconds > 0)
            ? targetTimeInSeconds - currentTimeInSeconds
            : currentTimeInSeconds - targetTimeInSeconds
        
        let diffHours = diffInSeconds / (60*60)
        let diffMinutes = (diffInSeconds - diffHours*60*60) / 60
        let diffSeconds = (diffInSeconds - diffHours*60*60 - diffMinutes*60)
        
        timer.stringValue = formatTimeComponent(diffHours)
            + ":" + formatTimeComponent(diffMinutes)
        if (targetTimeInSeconds - currentTimeInSeconds < 0) {
            timer.textColor = NSColor.redColor()
        }
    }
    
    func formatTimeComponent(timeComponent: Int) -> String{
        return timeComponent < 10 ? "0\(timeComponent)" : "\(timeComponent)"
    }
    
    


}

