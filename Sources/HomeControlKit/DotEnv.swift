//
//  DotEnv.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 28.09.24.
//

import Foundation

public class DotEnv {
    private var url: URL
    private var fileContent: [String: Any]?

    public init(url: URL) throws(Error) {
        self.url = url
        try readFileContent()
    }

    public static func fromMainBundle() throws(Error) -> DotEnv {
        guard let url = Bundle.main.url(forResource: ".env", withExtension: "json") else {
            throw .failedToBuildURL
        }
        return try DotEnv(url: url)
    }

    public static func fromWorkingDirectory() throws(Error) -> DotEnv {
        let workingDirectory = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        return try DotEnv(url: workingDirectory.appending(path: ".env.json"))
    }

    private func readFileContent() throws(Error) {
        guard let data = try? Data(contentsOf: url) else {
            throw .failedToLoadFile
        }

        guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw .failedToParseFile
        }

        fileContent = jsonObject
    }

    public func get(_ key: String) -> String? {
        return fileContent?[key] as? String
    }

    public func require(_ key: String) throws(Error) -> String {
        guard let value = get(key) else { throw .failedToGetEnvironmentVariable }
        return value
    }

    public enum Error: Swift.Error {
        case failedToBuildURL
        case failedToLoadFile
        case failedToParseFile
        case failedToGetEnvironmentVariable
    }
}
