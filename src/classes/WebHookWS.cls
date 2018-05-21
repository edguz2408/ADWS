@RestResource(urlMapping='/webhooks/*')
global without sharing class WebHookWS {
    
    
    @httpPost
    global static void postWebHook(){
        
        Restrequest req = RestContext.request; 
        
        OpptiesUpdateService.sendEmail(req.requestBody.toString(),  'Webhook got a message' + system.now());
        insert new Webhook_Message__c (JSON_received__c = req.requestBody.toString());
        
        OpptiesUpdateService.WebHookParams params = OpptiesUpdateService.mapValuesFromObject(req.requestBody.toString());
        OpptiesUpdateService.Result result = new OpptiesUpdateService.Result();
        
        
        if(!params.title.containsIgnoreCase('QP') && !params.title.containsIgnoreCase('TP'))
        {
            final String METHOD_RESPONSE = OpptiesUpdateService.insertUpdateOppty(params);
            
            if(METHOD_RESPONSE == 'true'){
                result.statusCode = 200;
                result.message = 'Records saved!';
            } else {
                result.statusCode = 500;
                result.message = METHOD_RESPONSE;
            }
            
            String JSONResult = JSON.serialize(params).replace('NumberParam', 'Number');
            
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.statusCode = result.statusCode;
            RestContext.response.responseBody = blob.valueOf(JSONResult); 
            
        }
        
    }
    
    
}