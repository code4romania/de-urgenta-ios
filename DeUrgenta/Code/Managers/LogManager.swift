//
//  LogManager.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import Foundation
import FirebaseCrashlytics

enum LoggerError: Error {
    case generic(reason: String)
    var localizedDescription: String {
        switch self {
        case .generic(let reason):
            return reason
        }
    }
}

func shouldPrintDebugLogsToConsole() -> Bool {
    #if DEBUG
    return true
    #else
    return false
    #endif
}

fileprivate func getFormattedMessage(withMessage message: String,
                                     file: StaticString,
                                     function: StaticString,
                                     line: Int) -> String {
    let output: String
    if let filename = URL(fileURLWithPath: file.description).lastPathComponent.components(separatedBy: ".").first {
        output = "\(filename):\(line) \(function) $ \(message)"
    } else {
        output = "\(file):\(line) \(function) $ \(message)"
    }
    return output
}

/// Only prints to the console if we're in debug mode, doesn't use CLS
func LogDebug(_ message: String, file: StaticString = #file, function: StaticString = #function, line: Int = #line) {
    let output = getFormattedMessage(withMessage: message,
                                     file: file,
                                     function: function,
                                     line: line)
    if shouldPrintDebugLogsToConsole() {
        print("DEBUG: \(output)")
    }
    Crashlytics.crashlytics().log(format: "DEBUG: %@", arguments: getVaList([output]))
}

/// Logs an error message
func LogError(_ message: String, file: StaticString = #file, function: StaticString = #function, line: Int = #line) {
    let output = getFormattedMessage(withMessage: message,
                                     file: file,
                                     function: function,
                                     line: line)
    #if targetEnvironment(simulator)
    print("ERROR: " + output)
    #else
    if shouldPrintDebugLogsToConsole() {
        print("ERROR: " + output)
    }
    Crashlytics.crashlytics().log(format: "ERROR: %@", arguments: getVaList([output]))
    Crashlytics.crashlytics().record(error: LoggerError.generic(reason: message))
    #endif
}

/// Logs an error message
func LogError(_ error: Error, file: StaticString = #file, function: StaticString = #function, line: Int = #line) {
    let output = getFormattedMessage(withMessage: error.localizedDescription,
                                     file: file,
                                     function: function,
                                     line: line)
    #if targetEnvironment(simulator)
    print("ERROR: " + output)
    #else
    if shouldPrintDebugLogsToConsole() {
        print("ERROR: " + output)
    }
    Crashlytics.crashlytics().log(format: "ERROR: %@", arguments: getVaList([output]))
    Crashlytics.crashlytics().record(error: error)
    #endif
}

/// Logs an info message
func LogInfo(_ message: String, file: StaticString = #file, function: StaticString = #function, line: Int = #line) {
    let output = getFormattedMessage(withMessage: message,
                                     file: file,
                                     function: function,
                                     line: line)
    #if targetEnvironment(simulator)
    print("INFO: \(output)")
    #else
    if shouldPrintDebugLogsToConsole() {
        print("INFO: \(output)")
    }
    Crashlytics.crashlytics().log(format: "INFO: %@", arguments: getVaList([output]))
    #endif
}

