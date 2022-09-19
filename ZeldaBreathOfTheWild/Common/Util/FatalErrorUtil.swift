//
//  FatalErrorUtil.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 18/09/22.
//

import Foundation

func fatalError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never {
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
}

struct FatalErrorUtil {
    private static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }
    
    static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure
    
    static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }
    static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}
