//
//  LitenLogger.swift
//  LitenLogger
//
//  Copyright (c) 2019 Ajith R Nayak
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

/// Wrapping Swift.print() within DEBUG flag
/// - Note: Xcode 8 had introduced a new type of Swift compilation flag called Active Compilation Conditions, by default which contains a DEBUG flag.
///
/// - Parameter item: An object to print
func print(_ item: @autoclosure () -> Any,
           separator: String = " ",
           terminator: String = "\n") {
    #if DEBUG
    Swift.print(item(), separator:separator, terminator: terminator)
    #endif
}


/// A tiny logging framework
/* - Usage:
 Log.verbose("Hello, LitenLogger")
 Log.debug("Document saved successfully!")
 Log.info("Date right now: \(Date())")
 Log.warning("Force Cast Violation: Force casts should be avoided. ")
 Log.error(error.localizedDescription + " while saving comment")
 Log.fatal("May Day! May Day!")
 */
public final class Log {
    
    // MARK: Public
    
    public class func verbose(_ item: @autoclosure () -> Any,
                              filePath: String = #file,
                              line: Int = #line,
                              funcName: String = #function) {
        Log.log(event: .verbose, item: item(),
                filePath: filePath, line: line, funcName: funcName)
    }
    
    public class func debug(_ item: @autoclosure () -> Any,
                            filePath: String = #file,
                            line: Int = #line,
                            funcName: String = #function) {
        Log.log(event: .debug, item: item(),
                filePath: filePath, line: line, funcName: funcName)
    }
    
    public class func info(_ item: @autoclosure () -> Any,
                           filePath: String = #file,
                           line: Int = #line,
                           funcName: String = #function) {
        Log.log(event: .info, item: item(),
                filePath: filePath, line: line, funcName: funcName)
    }
    
    public class func warning(_ item: @autoclosure () -> Any,
                              filePath: String = #file,
                              line: Int = #line,
                              funcName: String = #function) {
        Log.log(event: .warning, item: item(),
                filePath: filePath, line: line, funcName: funcName)
    }
    
    public class func error(_ item: @autoclosure () -> Any,
                            filePath: String = #file,
                            line: Int = #line,
                            funcName: String = #function) {
        Log.log(event: .error, item: item(),
                filePath: filePath, line: line, funcName: funcName)
    }
    
    public class func fatal(_ item: @autoclosure () -> Any,
                            filePath: String = #file,
                            line: Int = #line,
                            funcName: String = #function) {
        Log.log(event: .fatal, item: item(),
                filePath: filePath, line: line, funcName: funcName)
    }
    
    // MARK: Private
    
    private enum LogEventType: String {
        case verbose    = "Verbose"
        case debug      = "Debug"
        case info       = "Info"
        case warning    = "Warning"
        case error      = "Error"
        case fatal      = "Fatal"
        
        var flair: String {
            switch self {
            case .verbose:
                return "📝"
            case .debug:
                return "🎯"
            case .info:
                return "📣"
            case .warning:
                return "⚠️"
            case .error:
                return "🚨"
            case .fatal:
                return "🔥"
            }
        }
    }
    
    private class func log(event: LogEventType,
                           item: @autoclosure () -> Any,
                           filePath: String,
                           line: Int,
                           funcName: String) {
        let date: String        = Date().asString()
        let eventFlair: String  = event.flair
        let eventLabel: String  = event.rawValue.uppercased()
        let fileName: String    = Log.sourceFileName(fromFilePath: filePath)
        print("\(date) \(eventFlair)|\(eventLabel)|[\(fileName)]:\(line) \(funcName) -> \(item())")
    }
    
    static var dateFormat = "yyyy-MM-dd hh:mm:ss"
    static var dateFormatter: DateFormatter {
        let formatter           = DateFormatter()
        formatter.dateFormat    = dateFormat
        formatter.locale        = Locale.current
        formatter.timeZone      = TimeZone.current
        return formatter
    }
    
    private class func sourceFileName(fromFilePath filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return !components.isEmpty ? components.last! : ""
    }
}

internal extension Date {
    func asString() -> String {
        return Log.dateFormatter.string(from: self)
    }
}
