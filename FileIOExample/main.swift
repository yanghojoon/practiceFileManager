//
//  main.swift
//  FileIOExample
//
//  Created by 양호준 on 2022/01/10.
//

import Foundation

let fileManager = FileManager.default

let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first! // 왜 first를 붙이는 것일까??
let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
let tempURL = fileManager.temporaryDirectory // 이건 시스템에 위치한 tmp 폴더임. NSTemporaryDirectory와 동일


