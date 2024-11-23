//
//  DotEnv.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 28.09.24.
//

import Foundation

public struct DotEnv<T: Codable> {
    public private(set) var content: T

    public init(string: String) throws(DotEnvError) {
        guard let data = string.data(using: .utf8) else { throw .failedToLoadContent }
        try self.init(data: data)
    }

    public init(data: Data) throws(DotEnvError) {
        do {
            content = try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw .failedToParseFile
        }
    }

    public init(url: URL) throws(DotEnvError) {
        guard let data = try? Data(contentsOf: url) else {
            throw .failedToLoadFile
        }

        try self.init(data: data)
    }

    public static func fromMainBundle() throws(DotEnvError) -> DotEnv {
        guard let url = Bundle.main.url(forResource: ".env", withExtension: "json") else {
            throw .failedToBuildURL
        }
        return try DotEnv(url: url)
    }

    public static func fromWorkingDirectory() throws(DotEnvError) -> DotEnv {
        let workingDirectory = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        return try DotEnv(url: workingDirectory.appending(path: ".env.json"))
    }
}

public enum DotEnvError: Swift.Error {
    case failedToLoadContent
    case failedToBuildURL
    case failedToLoadFile
    case failedToParseFile
    case failedToGetEnvironmentVariable
}

extension DotEnv where T == [String: String] {
    public func get(_ key: String) -> String? { content[key] }

    public func require(_ key: String) throws(DotEnvError) -> String {
        guard let value = get(key) else { throw .failedToGetEnvironmentVariable }
        return value
    }
}

