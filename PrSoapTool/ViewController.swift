//
//  ViewController.swift
//  PrSoapTool
//
//  Created by iOS Papiroom on 27/01/15.
//  Authors : Gökhan Çokkeçeci,Eren Çelik
//  Copyright (c) 2015 Papiroom. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,PrDelegate
{
    override func viewDidLoad() {
        super.viewDidLoad()
        let serviceParamaters = ["ParamOne","ParamTwo","ParamThree"]  // Webservice paramaters
        let serviceParamatersValues = ["ValueOne","ValueTwo","ValueThree"]  //Webservice paramaters values
        var urlString = "https://.../Services.asmx" // Add your webservice asmx link
        
        var connector = PrSoapConnector(delegate: self)
        connector.process("Login", getWServiceParamaters: serviceParamaters, getWServiceParamatersValues: serviceParamatersValues, getWServiceURL: urlString)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onPreExecute()
    {
        
    }
    func onPostExecute(response: String)
    {
        NSLog("Data%@", response);
    }

}

