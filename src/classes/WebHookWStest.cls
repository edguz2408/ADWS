@isTest
public class WebHookWStest {
    
    static String getJSON(String productCode){
       
        OpptiesUpdateService.WebHook webHook = new OpptiesUpdateService.WebHook();
        webhook.Name = 'Assessment Submitted';
        webhook.typeDescription = 'Assessment Submitted';
        webhook.typeId = 10;
        
        OpptiesUpdateService.Enrollment enrollment = new OpptiesUpdateService.Enrollment();
        enrollment.AchivedOnUTC = '';
        enrollment.activeFromUTC = '';
        enrollment.activeThruUTC = '';
        enrollment.AdminEnrollmentDetailURL = '';
        enrollment.firstViewedUTC = '';
        enrollment.lastViewedUTC = '';
        enrollment.learnerEnrollmentDetailURL = '';
        enrollment.overallScore = 90.7;
        enrollment.ProductInventoryCompletionIntegrationCode = '';
        enrollment.ProductInventoryDefaultIntegrationCode = productCode;
        enrollment.status = 2;
        enrollment.totalSeconds = 80;
        
        OpptiesUpdateService.FreeText freeText =  new OpptiesUpdateService.FreeText();
        freeText.label = '';
        freeText.value = '';
        
        OpptiesUpdateService.GroupValue groupValue = new OpptiesUpdateService.GroupValue();
        groupValue.code = '';
        groupValue.description = '';
        groupValue.label = '';
        
        OpptiesUpdateService.LookUp lookup = new OpptiesUpdateService.LookUp();
        lookup.code = '';
        lookup.description = '';
        lookup.label = '';
        
        OpptiesUpdateService.PhoneNumber phoneNumber = new OpptiesUpdateService.PhoneNumber();
        phoneNumber.label = '';
        phoneNumber.value = '';
        
        OpptiesUpdateService.BooleanValue booleanValue = new OpptiesUpdateService.BooleanValue();
        booleanValue.label = '';
        booleanValue.value = false;
        
        OpptiesUpdateService.DateValue dateValue = new OpptiesUpdateService.DateValue();
        dateValue.label = '';
        dateValue.value = '';
        
        OpptiesUpdateService.Learner learner = new OpptiesUpdateService.Learner();
        learner.firstName = 'One';
        learner.lastName = 'Detrick Test 01/05';
        learner.address1 = '';
        learner.address2 = '';
        learner.address3 = '';
        learner.alternateId = '576936e3-59fb-4ff8-a8a9-5def3ffca87ce';
        learner.birthDate = date.today().addYears(-30).format();
        learner.boolean1 = booleanValue;
        learner.boolean2 = booleanValue;
        learner.cityLocality = '';
        learner.country = 10;
        learner.date1 = dateValue;
        learner.date2 = dateValue;
        learner.email = 'adetrick@metriverseTest.com';
        learner.manageLearnerURL = '';
        learner.status = 'Active';
        learner.gender = 'M';
        learner.zipPostalCode = '';
        learner.stateProvince = '';
        learner.freeText1 = freeText;
        learner.freeText2 = freeText;
        learner.freeText3 = freeText;
        learner.freeText4 = freeText;
        learner.group1 = groupValue;
        learner.group2 = groupValue;
        learner.group3 = groupValue;
        learner.group4 = groupValue;
        learner.group5 = groupValue;
        learner.lookUp1 = lookup;
        learner.lookUp2 = lookup;
        learner.lookUp3 = lookup;
        learner.lookUp4 = lookup;
        learner.lookUp5 = lookup;
        learner.lookUp6 = lookup;
        learner.lookUp7 = lookup;
        learner.lookUp8 = lookup;
        learner.lookUp9 = lookup;
        learner.lookUp10 = lookup;
        learner.lookUp11 = lookup;
        learner.lookUp12 = lookup;
        learner.lookUp13 = lookup;
        learner.lookUp14 = lookup;
        learner.phoneNumber1 = phoneNumber;
        learner.systemTimeZone = '';
        learner.insertedUTC = '';
        learner.lastLoginUTC = '';
        learner.nABPeProfileId = '';
        learner.lastLoginUTC = '';
        learner.statusLastChangedUTC = '';
        
        OpptiesUpdateService.Answer answer = new OpptiesUpdateService.Answer();
        answer.Answer = '';
        answer.Choice = '';
        answer.IsCorrectChoice = false;
        answer.IsLearnerChoice = false;
        
        OpptiesUpdateService.Question question = new OpptiesUpdateService.Question();
        question.Answers = new List<OpptiesUpdateService.Answer>{answer};
        question.Feedback = '';
        question.NumberParam = 0;
        question.PointsAchieved = 0;
        question.PointsPossible = 1;
        question.ResponseType = '';
        question.StartedUTC = '';
        question.TotalViewTimeSeconds = 1;
        
        OpptiesUpdateService.Objective objective = new OpptiesUpdateService.Objective();
        objective.MinimumPercentageToPass = 0;
        objective.Questions = new List<OpptiesUpdateService.Question>{question};
        objective.Title = '';
        
        OpptiesUpdateService.WebHookParams params = new OpptiesUpdateService.WebHookParams();
        params.WebHook = webhook;
        params.Enrollment = enrollment;
        params.Learner = learner;
        params.Description = 'Dialysis Technician Quiz 15.1';
        params.Title = 'Dialysis Technician Q3 of 5';
        params.EndedUTC = '';
        params.MinimumPercentageToPass = '70.00';
        params.MinimumScore = 70.00;
        params.Score = 0;
        params.StartedUTC = '1/5/2018 3:07 PM';
        params.Status = 'Passed';
        params.TimeLimit = 0;
        params.AttemptNumber = 1;
        params.Objectives = new List<OpptiesUpdateService.Objective>{objective};
        
        return JSON.serialize(params);

    }
    
    static RestResponse getRESTResponse(String JSONBody){
        
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueof(JSONBody);
        request.requestUri = URL.getSalesforceBaseUrl().toExternalForm()+'/services/apexrest/webhooks/'; 
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        return response;
    }
    
    @isTest
    public static void doPostTest(){
        //string JsonMsg = '{"Webhook":{"TypeId":10,"TypeDescription":"Assessment Submitted","Name":"Assessment Submitted"},"Title":"Dialysis Technician Q3 of 5","Description":"Dialysis Technician Quiz 15.1","MinimumPercentageToPass":70.00,"TimeLimit":0,"AttemptNumber":2,"StartedUTC":"1/5/2018 3:07 PM","EndedUTC":"1/5/2018 3:20 PM","Score":100.00,"MinimumScore":70.00,"Status":"Passed","Objectives":[{"Title":"All Objectives","MinimumPercentageToPass":70,"Questions":[{"Number":21,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":55,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"B","Answer":"B"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":14,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":11,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"B","Answer":"B"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":22,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":15,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"D","Answer":"D"}]},{"Number":2,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":25,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"C","Answer":"C"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":12,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":14,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"C","Answer":"C"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":15,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":13,"Feedback":null,"Answers":[{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"A","Answer":"A"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":24,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":7,"Feedback":null,"Answers":[{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"A","Answer":"A"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":9,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":7,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"C","Answer":"C"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":10,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":97,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"C","Answer":"C"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":6,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":33,"Feedback":null,"Answers":[{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"A","Answer":"A"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":7,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":19,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"D","Answer":"D"}]},{"Number":20,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":12,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"D","Answer":"D"}]},{"Number":13,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":11,"Feedback":null,"Answers":[{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"A","Answer":"A"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":23,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":11,"Feedback":null,"Answers":[{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"A","Answer":"A"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":18,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":17,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"C","Answer":"C"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":25,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":19,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"D","Answer":"D"}]},{"Number":17,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":19,"Feedback":null,"Answers":[{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"A","Answer":"A"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":8,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":24,"Feedback":null,"Answers":[{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"A","Answer":"A"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":4,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":46,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"B","Answer":"B"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":11,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":67,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"D","Answer":"D"}]},{"Number":16,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":48,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"C","Answer":"C"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":5,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":60,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"C","Answer":"C"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":19,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":40,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"C","Answer":"C"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":3,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":64,"Feedback":null,"Answers":[{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"A","Answer":"A"},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"D","Answer":""}]},{"Number":1,"ResponseType":"Correct","PointsPossible":1,"PointsAchieved":1,"StartedUTC":"","TotalViewTimeSeconds":22,"Feedback":null,"Answers":[{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"A","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"B","Answer":""},{"IsCorrectChoice":false,"IsLearnerChoice":false,"ChoiceNumber":"C","Answer":""},{"IsCorrectChoice":true,"IsLearnerChoice":true,"ChoiceNumber":"D","Answer":"D"}]}]}],"Enrollment":{"Status":2,"ActiveFromUTC":"2017-12-20T05:00:00","ActiveThruUTC":"2018-07-03T03:59:59.9999999","FirstViewedUTC":"2018-01-03T18:33:17.247","LastViewedUTC":"2018-01-05T15:20:04.057","LearnerEnrollmentDetailURL":"http://auburn.lms.edu2learn.com/activity/enrollment?enrollmentId=c85e02cb-e950-4765-9eee-ec10e54fd82c","AdminEnrollmentDetailURL":"http://auburn.lms.edu2learn.com/admin/learners/enrollments?learnerId=96fa5489-2ce1-4bbe-90ee-ae372d73a660","OverallScore":89.00,"TotalSeconds":11475,"AchivedOnUTC":"0001-01-01T00:00:00","AchievedOnUTC":"0001-01-01T00:00:00","ProductSectionIntegrationCode":"HET.DIAL","ProductInventoryDefaultIntegrationCode":"HET.DIAL","ProductInventoryCompletionIntegrationCode":null},"Learner":{"FirstName":"One","LastName":"Detrick","Email":"adetrick@metriverse.com","AlternateId":"576936e3-59fb-4ff8-a8a9-5def3ffca87c","SystemTimeZone":15,"BirthDate":null,"Gender":null,"Address1":null,"Address2":null,"Address3":null,"CityLocality":null,"StateProvince":null,"ZipPostalCode":null,"Country":null,"PhoneNumber1":{"Label":null,"Value":null},"Boolean1":{"Label":null,"Value":null},"Boolean2":{"Label":null,"Value":null},"Date1":{"Label":null,"Value":null},"Date2":{"Label":null,"Value":null},"Group1":{"Label":"School","Code":"healthedtoday","Description":"healthedtoday"},"Group2":{"Label":null,"Code":null,"Description":null},"Group3":{"Label":null,"Code":null,"Description":null},"Group4":{"Label":null,"Code":null,"Description":null},"Group5":{"Label":null,"Code":null,"Description":null},"Lookup1":{"Label":null,"Code":null,"Description":null},"Lookup2":{"Label":null,"Code":null,"Description":null},"Lookup3":{"Label":null,"Code":null,"Description":null},"Lookup4":{"Label":null,"Code":null,"Description":null},"Lookup5":{"Label":null,"Code":null,"Description":null},"Lookup6":{"Label":null,"Code":null,"Description":null},"Lookup7":{"Label":null,"Code":null,"Description":null},"Lookup8":{"Label":null,"Code":null,"Description":null},"Lookup9":{"Label":null,"Code":null,"Description":null},"Lookup10":{"Label":null,"Code":null,"Description":null},"Lookup11":{"Label":null,"Code":null,"Description":null},"Lookup12":{"Label":null,"Code":null,"Description":null},"Lookup13":{"Label":null,"Code":null,"Description":null},"Lookup14":{"Label":null,"Code":null,"Description":null},"FreeText1":{"Label":null,"Value":null},"FreeText2":{"Label":null,"Value":null},"FreeText3":{"Label":null,"Value":null},"FreeText4":{"Label":null,"Value":null},"ManageLearnerURL":"http://auburn.lms.edu2learn.com/admin/learners/info?learnerId=96fa5489-2ce1-4bbe-90ee-ae372d73a660","InsertedUTC":"2017-09-05T13:07:48.443","LastLoginUTC":"2018-01-05T04:47:22.56","NABPeProfileId":null,"Status":"Active","StatusLastChangedUTC":"2017-09-05T13:07:48.443"}}';
        
        test.startTest();
        
        
        //First attempt test
        RestResponse firstResponse = getRESTResponse(getJSON('course 1'));
        WebHookWS.postWebHook();
        
        //Second attempt test
        RestResponse secondResponse = getRESTResponse(getJSON('course 2'));
        WebHookWS.postWebHook();
        
        //Third attempt test
        RestResponse thirdResponse = getRESTResponse(getJSON('course 3'));
        WebHookWS.postWebHook();
        
        //Attempt to Update values for courses 
        RestResponse firstUpdateResponse = getRESTResponse(getJSON('course 1'));
        WebHookWS.postWebHook();
        
        RestResponse secondUpdateResponse = getRESTResponse(getJSON('course 2'));
        WebHookWS.postWebHook();
        
        RestResponse thirdUpdateResponse = getRESTResponse(getJSON('course 3'));
        WebHookWS.postWebHook();
        
        
        test.stopTest();
        
        System.assertEquals(200, firstResponse.statusCode);
        System.assertEquals(200, secondResponse.statusCode);
        System.assertEquals(200, thirdResponse.statusCode);
        
        System.assertEquals(200, firstUpdateResponse.statusCode);
        System.assertEquals(200, secondUpdateResponse.statusCode);
        System.assertEquals(200, thirdUpdateResponse.statusCode);
        
        
    }
}