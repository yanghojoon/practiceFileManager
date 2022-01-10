//
//  main.swift
//  FileIOExample
//
//  Created by 양호준 on 2022/01/10.
//

import Foundation

let fileManager = FileManager.default // default는 fileManager의 싱글톤 인스턴스를 생성해줌

let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first! // 왜 first를 붙이는 것일까??
let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
let tempURL = fileManager.temporaryDirectory // 이건 시스템에 위치한 tmp 폴더임. NSTemporaryDirectory와 동일

// create subdirectory
let appSupportDirectoryURL = appSupportURL.appendingPathComponent("FileIOExample")
let documentsDirectoryURL = documentsURL.appendingPathComponent("FileIOExample")
let tempDirectoryURL = tempURL.appendingPathComponent("FileIOExample")
try? fileManager.createDirectory(at: appSupportDirectoryURL, withIntermediateDirectories: true, attributes: nil)
try? fileManager.createDirectory(at: documentsDirectoryURL, withIntermediateDirectories: true, attributes: nil)
try? fileManager.createDirectory(at: tempDirectoryURL, withIntermediateDirectories: true, attributes: nil)

// create file
let appSupportFile = appSupportDirectoryURL.appendingPathComponent("abc.txt")
let documentsFile = documentsDirectoryURL.appendingPathComponent("abc.txt")
let tmpFile = tempDirectoryURL.appendingPathComponent("abc.txt")

// write file
let textString = "Hello, Files"
try? textString.write(to: appSupportFile, atomically: true, encoding: .utf8)
try? textString.write(to: documentsFile, atomically: true, encoding: .utf8)
try? textString.write(to: tmpFile, atomically: true, encoding: .utf8)
// write는 NSString의 인스턴스 메서드

// read file
let appSupportContent = fileManager.contents(atPath: appSupportFile.path)!
let documentsContent = fileManager.contents(atPath: documentsFile.path)!
let tmpContent = fileManager.contents(atPath: tmpFile.path)!
var appSupportContentString = String(data: appSupportContent, encoding: .utf8)!
var documentsContentString = String(data: documentsContent, encoding: .utf8)!
var tmpContentString = String(data: tmpContent, encoding: .utf8)!
print(appSupportContentString)
print(documentsContentString)
print(tmpContentString)

// modify file
let modifyTextString = "Hello, World"
try? modifyTextString.write(to: appSupportFile, atomically: true, encoding: .utf8)
try? modifyTextString.write(to: documentsFile, atomically: true, encoding: .utf8)
try? modifyTextString.write(to: tmpFile, atomically: true, encoding: .utf8)


