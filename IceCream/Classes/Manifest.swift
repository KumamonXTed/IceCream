//
//  LogConfig.swift
//  IceCream
//
//  Created by 蔡越 on 30/01/2018.
//

import Foundation

/// This file is for setting some develop configs for IceCream framework.

public protocol Log {
    func print(
        _ items: Any...,
        separator: String,
        terminator: String,
        file: StaticString,
        function: StaticString,
        line: UInt
    )
}

public class IceCream {
    
    public static let shared = IceCream()
    
    /// There are quite a lot `print`s in the IceCream source files.
    /// If you don't want to see them in your console, just set `enableLogging` property to false.
    /// The default value is true.
    public var enableLogging: Bool = true

    public var log: Log?
}

/// If you want to know more,
/// this post would help: https://medium.com/@maxcampolo/swift-conditional-logging-compiler-flags-54692dc86c5f
internal func logInfo(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
) {
    let separator = " "
    let terminator = "\n"
    if (IceCream.shared.enableLogging) {
        if let logger = IceCream.shared.log {
            logger.print(items, separator: separator, terminator: terminator, file: file, function: function, line: line)
        } else {
            #if DEBUG
            var i = items.startIndex
            repeat {
                Swift.print(items[i], separator: separator, terminator: i == (items.endIndex - 1) ? terminator : separator)
                i += 1
            } while i < items.endIndex
            #endif
        }
    }
}
