//
//  TableData.swift
//  HomeControlAdapterSungrowInverter
//
//  Created by Christoph Pageler on 14.10.24.
//

import SwiftUI

public struct TableData {
    public var title: String
    public var rows: [TableDataRow]

    public init(title: String, rows: [TableDataRow]) {
        self.title = title
        self.rows = rows
    }

    public init(title: String, rowBuilder rowBuilderClosure: (RowBuilder) -> Void) {
        self.title = title
        let rowBuilder = RowBuilder()
        rowBuilderClosure(rowBuilder)
        self.rows = rowBuilder.rows
    }
}

public class RowBuilder {
    var rows: [TableDataRow] = []

    public func append<T>(title: String, _ t: T?, closure: (T) -> any View) {
        guard let t else { return }
        rows.append(.init(title: title, view: closure(t)))
    }

    public func append(title: String, value: String?) {
        guard let value else { return }
        rows.append(.init(title: title, value: value))
    }
}
