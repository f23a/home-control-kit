//
//  TableView.swift
//  HomeControlAdapterSungrowInverter
//
//  Created by Christoph Pageler on 14.10.24.
//

import SwiftUI

public struct TableView: View {
    public let table: TableData

    public init(table: TableData) {
        self.table = table
    }

    public var body: some View {
        GroupBox(table.title) {
            Table(table.rows) {
                TableColumn("Title", value: \.title)
                TableColumn("Value", content: { AnyView($0.view) })
            }
        }
    }
}

#Preview {
    TableView(table: .init(title: "Sample", rows: [.init(title: "Title", value: "Value")]))
}
