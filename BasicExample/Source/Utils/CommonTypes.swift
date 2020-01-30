//
//  CommonTypes.swift
//  BasicExample
//
//  Created by Serik on 28.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import Foundation

typealias VoidCompletion = (() -> Void)
typealias BoolCompletion = ((Bool) -> Void)
typealias AnyCompletion = ((Any?) -> Void)
typealias AnyObjectCompletion = ((AnyObject) -> Void)
typealias UserCompletion = ((User) -> Void)
typealias StringCompletion = ((String) -> Void)
typealias ErrorCompletion = ((String) -> Void)
typealias ErrorsCompletion = ((String, String) -> Void)

