//
//  Package.swift
//  UnchainedIPAddress
//
//  Created by Johannes Schriewer on 2015-12-20.
//  Copyright © 2015 Johannes Schriewer. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "UnchainedIPAddress",
    targets: [
        Target(name:"UnchainedIPAddressTests", dependencies: [.Target(name: "UnchainedIPAddress")]),
        Target(name:"UnchainedIPAddress")
    ],
    dependencies: [
		.Package(url: "https://github.com/dunkelstern/UnchainedString.git", majorVersion: 1)
    ]
)
