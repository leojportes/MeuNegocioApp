//
//  ReportViewController+Ext.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 01/10/22.
//

import UIKit
import PDFKit

extension ReportViewController: PDFConfigurableTableDataSource {
    
    func getPageTitle(table: ConfigurableTable!) -> String! {
        "\(PDFModel.title)\n\(amountDiscount)"
    }
    
    func getPageLogo(table: ConfigurableTable!) -> String! {
        "ic_my-business"
    }
    
    func getHeaderVisiblity(table: ConfigurableTable!) -> Bool! {
        return true
    }
    
    func getSeperatorVisiblity(table: ConfigurableTable!) -> Bool! {
        return true
    }
    
    func getTableHeader(table: ConfigurableTable!) -> [String]? {
        return PDFModel.columsTitles
    }
    
    func getNoOfTabelRows(table: ConfigurableTable!) -> Int! {
        procedures.count
    }
    
    func getTableRows(table: ConfigurableTable!, for indexRow: Int!) -> [ColumnCell]! {
        let procedure = procedures[indexRow! - 1]

        let amountsValueTotal = Current.shared.formatterAmountsReport(amounts: procedure.value )
        let amountsCosts = Current.shared.formatterAmountsReport(amounts: procedure.costs ?? "")
        let amountsLiquid = Current.shared.formatterAmountsReport(amounts: procedure.valueLiquid ?? procedure.value)
        
        let column1 = ConfigurableTable.make_string_cell(val: procedure.formPayment.rawValue)
        let column2 = ConfigurableTable.make_string_cell(val: procedure.nameClient)
        let column3 = ConfigurableTable.make_string_cell(val: procedure.currentDate)
        let column4 = ConfigurableTable.make_string_cell(val: amountsValueTotal)
        let column5 = ConfigurableTable.make_string_cell(val: amountsCosts)
        let column6 = ConfigurableTable.make_string_cell(val: amountsLiquid)
        
        return [column1, column2, column3, column4, column5, column6]
    }
    
}
