//
//  PrSoapConnector.swift
//  PrSoapTool
//
//  Created by iOS Papiroom on 27/01/15.
//  Authors : Gökhan Çokkeçeci,Eren Çelik
//  Copyright (c) 2015 Papiroom. All rights reserved.
//

import UIKit

class PrSoapConnector: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate
{
    var delegate : PrDelegate?
    
    var mutableData:NSMutableData = NSMutableData.alloc()
    var currentElementName:NSString = ""
    var returnWServiceDataString = ""
    
    init(delegate: PrDelegate?)
    {
        self.delegate = delegate
    }
    
    func process(functionName: String, getWServiceParamaters: Array<String>, getWServiceParamatersValues: Array<String>, getWServiceURL: String)
    {
        delegate?.onPreExecute()
        var soapMessage = "<?xml version='1.0' encoding='utf-8'?>"
        soapMessage += "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"
        soapMessage += "<soap:Body>"
        soapMessage += "<\(functionName) xmlns=\"http://tempuri.org/\">"
        for var i=0; i<getWServiceParamaters.count; i++
        {
            soapMessage += "<\(getWServiceParamaters[i])>\(getWServiceParamatersValues[i])</\(getWServiceParamaters[i])>"
        }
        soapMessage += "</\(functionName)>"
        soapMessage += "</soap:Body>"
        soapMessage += "</soap:Envelope>"
        
        var urlString = getWServiceURL
        var url: NSURL = NSURL(string: urlString)!
        var theRequest = NSMutableURLRequest(URL: url)
        var msgLength = String(countElements(soapMessage))
        
        theRequest.HTTPMethod = "POST"
        theRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        theRequest.HTTPBody = soapMessage.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        var connection = NSURLConnection(request: theRequest, delegate: self, startImmediately: true)
        var mutableData : Void = NSMutableData.initialize()
        
        connection!.start()
        connection?.start()
        if let connection = connection
        {
            connection.start()
        }
        else
        {
            
        }
    }
    
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!)
    {
        mutableData.length = 0;
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!)
    {
        mutableData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!)
    {
        var xmlParser = NSXMLParser(data: mutableData)
        xmlParser.delegate = self
        xmlParser.parse()
        xmlParser.shouldResolveExternalEntities = true
        returnWServiceDataString = NSString(data: mutableData, encoding: NSUTF8StringEncoding)!
        delegate?.onPostExecute(returnWServiceDataString)
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!)
    {
        currentElementName = elementName
    }
    
}
