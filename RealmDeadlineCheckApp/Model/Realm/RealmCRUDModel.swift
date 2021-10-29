//
//  RealmCRUDModel.swift
//  RealmDeadlineCheckApp
//
//  Created by UrataHiroki on 2021/10/26.
//

import RealmSwift

class RealmCRUDModel{
    
    private let registerDatas = RegisterDatas()
    private let alert = Alert()
    
    lazy public var readResultAllDatas:[[String:String]] = []
    lazy public var todayReadResultDatas:[[String:String]] = []
    
}


extension RealmCRUDModel{
    
    public func createRealmData(createProductName:String?,createJanCode:String?,createDeadlineDay:String?,alertTarget:UIViewController){
        
        guard let productName = createProductName else { return }
        guard let janCode = createJanCode else { return }
        guard let deadlineDay = createDeadlineDay else { return }
        
        do{
            let realm = try Realm()
            registerDatas.productName = productName
            registerDatas.janCode = janCode
            registerDatas.deadlineDay = deadlineDay
            
            try realm.write({
                
                realm.add(registerDatas)
            })
            
        }catch{
            
            alert.showWarningAlert(warningContent: "データの保存", targetView: alertTarget)
        }
    }
}


extension RealmCRUDModel{
    
    public func readRealmAllData(alertTarget:UIViewController){
        
        do{
            let realm = try Realm()
            readResultAllDatas = []
            
                realm.objects(RegisterDatas.self).forEach { item in
                    
                    readResultAllDatas.append(["allReadProductName":item.productName,
                                               "allReadJanCode":item.janCode,
                                               "allReadDeadlineDay":item.deadlineDay])
                }
            
        }catch{
            
            alert.showWarningAlert(warningContent: "データの取得", targetView: alertTarget)
        }
    }
}

