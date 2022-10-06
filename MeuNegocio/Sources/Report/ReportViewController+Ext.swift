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
        "BarberImage"
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

        let amounts = Current.shared.formatterAmounts(amounts: procedures)
        let amount = amounts[indexRow! - 1]

        let column1 = ConfigurableTable.make_image_cell(imageName:"ic_\(procedure.formPayment).png")
        let column2 = ConfigurableTable.make_string_cell(val: procedure.nameClient)
        let column3 = ConfigurableTable.make_string_cell(val: procedure.currentDate)
        let column4 = ConfigurableTable.make_string_cell(val: amount)
        
        return [column1, column2, column3, column4]
    }
    
}
