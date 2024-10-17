//
//  TableRow.swift
//  HomeControlAdapterSungrowInverter
//
//  Created by Christoph Pageler on 14.10.24.
//

import SwiftUI

public struct TableDataRow: Identifiable {
    public var id: String { title }
    public var title: String
    public var view: any View

    public init (title: String, view: any View) {
        self.title = title
        self.view = view
    }

    public init(title: String, value: String) {
        self.title = title
        self.view = Text(value)
    }
}
