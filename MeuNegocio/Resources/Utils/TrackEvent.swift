//
//  TrackEvent.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 21/12/22.
//

import Foundation
import FirebaseAnalytics

class TrackEvent {
    static func track(event: MNEvent, parameters: [String: Any]? = nil) {
        Analytics.logEvent(event.rawValue, parameters: parameters)
    }
}

public enum MNEvent: String {
    
    // Home
    case homeReport = "home_relatorios"
    case homeInfo = "home_informacoes"
    case homeAddProcedure = "home_adicionar_procedimentos"
    case homeProfile = "home_perfil"
    case homeFilterAll = "home_filtro_todos"
    case homeFilterToday = "home_filtro_hoje"
    case homeFilterSevenDays = "home_filtro_sete_dias"
    case homeFilterThirtyDays = "home_filtro_trinta_dias"
    case homeFilterPerson = "home_filtro_personalizado"
    case homeProcedure = "home_procedimento"
    case homeDeleteProcedure = "home_deletar_procedimento"
    
    // Rate App
    case rateEmail = "avaliacao_email"
    case rateApple = "avaliacao_apple_click"
}
