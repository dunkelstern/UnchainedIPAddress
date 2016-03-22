//
//  twohundredTests.swift
//  twohundredTests
//
//  Created by Johannes Schriewer on 01/11/15.
//  Copyright © 2015 Johannes Schriewer. All rights reserved.
//

import XCTest
@testable import UnchainedIPAddress

class IPAddressTests: XCTestCase {

    func testIPv4FromString() throws {
        guard let ip = IPAddress(fromString: "127.0.0.1") else {
            XCTFail("Could not parse string")
            return
        }
        if case .IPv4(let s1, let s2, let s3, let s4) = ip {
            XCTAssertEqual(s1, 127)
            XCTAssertEqual(s2, 0)
            XCTAssertEqual(s3, 0)
            XCTAssertEqual(s4, 1)
        } else {
            XCTFail("Parsed string was not IPv4 type")
        }
    }

    func testIPv4ToString() throws {
        let ip = IPAddress.IPv4(127, 0, 0, 1)
        XCTAssertEqual(ip.description, "127.0.0.1")
    }

    func testIPv6FromString() throws {
        guard let ip = IPAddress(fromString: "::1") else {
            XCTFail("Could not parse string")
            return
        }
        if case .IPv6(let s1, let s2, let s3, let s4, let s5, let s6, let s7, let s8) = ip {
            XCTAssertEqual(s1, 0)
            XCTAssertEqual(s2, 0)
            XCTAssertEqual(s3, 0)
            XCTAssertEqual(s4, 0)
            XCTAssertEqual(s5, 0)
            XCTAssertEqual(s6, 0)
            XCTAssertEqual(s7, 0)
            XCTAssertEqual(s8, 1)
        } else {
            XCTFail("Parsed string was not IPv6 type")
        }
    }

    func testIPv6FromString2() throws {
        guard let ip = IPAddress(fromString: "1:2:3:4::1") else {
            XCTFail("Could not parse string")
            return
        }
        if case .IPv6(let s1, let s2, let s3, let s4, let s5, let s6, let s7, let s8) = ip {
            XCTAssertEqual(s1, 1)
            XCTAssertEqual(s2, 2)
            XCTAssertEqual(s3, 3)
            XCTAssertEqual(s4, 4)
            XCTAssertEqual(s5, 0)
            XCTAssertEqual(s6, 0)
            XCTAssertEqual(s7, 0)
            XCTAssertEqual(s8, 1)
        } else {
            XCTFail("Parsed string was not IPv6 type")
        }
    }

    func testIPv6FromString3() throws {
        guard let ip = IPAddress(fromString: "1:0:0:4::1") else {
            XCTFail("Could not parse string")
            return
        }
        if case .IPv6(let s1, let s2, let s3, let s4, let s5, let s6, let s7, let s8) = ip {
            XCTAssertEqual(s1, 1)
            XCTAssertEqual(s2, 0)
            XCTAssertEqual(s3, 0)
            XCTAssertEqual(s4, 4)
            XCTAssertEqual(s5, 0)
            XCTAssertEqual(s6, 0)
            XCTAssertEqual(s7, 0)
            XCTAssertEqual(s8, 1)
        } else {
            XCTFail("Parsed string was not IPv6 type")
        }
    }

    func testIPv6ToString() throws {
        var ip = IPAddress.IPv6(0, 0, 0, 0, 0, 0, 0, 1)
        XCTAssertEqual(ip.description, "::1")

        ip = IPAddress.IPv6(1, 2, 3, 4, 0, 0, 0, 1)
        XCTAssertEqual(ip.description, "1:2:3:4::1")

        ip = IPAddress.IPv6(1, 0, 0, 4, 0, 0, 0, 1)
        XCTAssertEqual(ip.description, "1:0:0:4::1")
    }
    
    func testIPv4SocketStruct() throws {
        let ip = IPAddress.IPv4(127, 0, 0, 1)
        if let sin = ip.sin_addr() {
            XCTAssertEqual(sin.description, "127.0.0.1")
        } else {
            XCTFail("Could not convert to socket struct")
        }
    }

    func testIPv6SocketStruct() throws {
        let ip = IPAddress(fromString: "::1")!
        if let sin = ip.sin6_addr() {
            XCTAssertEqual(sin.description, "::1")
        } else {
            XCTFail("Could not convert to socket struct")
        }
    }
    
    func testWildcards() throws {
        let ip = IPAddress.Wildcard
        XCTAssertEqual(ip.description, "*")
        if let sin = ip.sin_addr() {
            XCTAssertEqual(sin.description, "0.0.0.0")
        } else {
            XCTFail("Could not convert to socket struct")
        }
        if let sin = ip.sin6_addr() {
            XCTAssertEqual(sin.description, "::")
        } else {
            XCTFail("Could not convert to socket struct")
        }
    }
}

#if os(Linux)
extension IPAddressTests {
    static var allTests : [(String, IPAddressTests -> () throws -> Void)] {
        return [
            ("testIPv4FromString", testIPv4FromString),
            ("testIPv4ToString", testIPv4ToString),
            ("testIPv6FromString", testIPv6FromString),
            ("testIPv6FromString2", testIPv6FromString2)
        ]
    }
}
#endif
