public class OpptiesUpdateService {
    
    public static WebHookParams mapValuesFromObject(String requestBody){
        
        WebHookParams result = new WebHookParams();                
        
        Map<String, object> values = (Map<String, object>)JSON.deserializeUntyped(requestBody);        
        
        result.WebHook = (WebHook)getDeserializedObject(values.get('Webhook'), WebHook.class);
        result.Title = (String)values.get('Title');
        result.Description = (String)values.get('Description');
        result.TimeLimit = (Integer)values.get('TimeLimit');
        result.AttemptNumber = (Integer)values.get('AttemptNumber');
        result.StartedUTC = (String)values.get('StartedUTC');
        result.EndedUTC = (String)values.get('EndedUTC');
        result.Score = (Decimal)values.get('Score');
        result.MinimumScore = (Decimal)values.get('MinimumScore');
        result.Status = (String)values.get('Status');
        result.objectives =  getObjectives(values);
        result.Enrollment = (Enrollment)getDeserializedObject(values.get('Enrollment'), Enrollment.class);        
        result.learner = (Learner)getDeserializedObject(values.get('Learner'), Learner.class);        
        
        
        return result;
        
    }
    
    public static void sendEmail(string body , string subject)
    {
        
        Messaging.reserveSingleEmailCapacity(2);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        String[] toAddresses = new String[] {'a.d.detrick@gmail.com'}; 
            
        mail.setToAddresses(toAddresses);         
        mail.setSubject(subject);         
        mail.setHtmlBody(body );
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
    public static List<String> getSobjectFields(String objectName){
        
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe();
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);        
        Map<String,Schema.SObjectField> mfields = SObjectTypeObj.getDescribe().fields.getMap();
        List<String> fields = new List<String>();
        
        for(String fieldName : mfields.keySet()){
            fields.add(fieldName);
        }
        
        return fields;
        
    }
    
    public static String insertUpdateOppty(WebHookParams params){
        
        Opportunity oppty = getCurrentOppty(params.learner.alternateId);
        // System.assert(oppty != null, oppty);
        oppty = oppty != null ? oppty : new Opportunity();
        oppty.Name = 'eLearning Enrollment';
        oppty.StageName = oppty.StageName == null ? 'Enrolled' : oppty.StageName;
        oppty.CloseDate = oppty.CloseDate == null ? date.today().addMonths(3) : oppty.CloseDate;
        oppty.Alternate_ID__c = params.learner.alternateId;
        oppty.Integration_Product_Code__c = params.Enrollment.ProductInventoryDefaultIntegrationCode;
        oppty.STUDENT_FIRST_NAME__c = params.learner.firstName;
        oppty.STUDENT_LAST_NAME__c = params.learner.lastName;
        oppty.Student_Email__c = params.learner.email;
        
        if(params.Status == 'Passed') setQuizGrades(oppty, params);   
        
        try{
            upsert oppty Alternate_ID__c;
            return 'true';
        } catch(DmlException ex){
            System.debug('Error Message:: '+ ex.getMessage());
            return ex.getMessage();
        }
        
        
    }
    
    private static List<Objective> getObjectives(Map<String, Object> valuesMap){
        
        List<Objective> values = new List<Objective>();        
        
        Object innerObject = valuesMap.get('Objectives');
        String innerQuestionsMap = JSON.serialize(innerObject);       
        
        for(Object obj : (List<Object>)JSON.deserializeUntyped(innerQuestionsMap)){
            String questionsJSON = JSON.serialize(obj);            
            Map<String, object> questionsMap = (Map<String, Object>)JSON.deserializeUntyped(questionsJSON);
            String questionJSON = JSON.serialize(questionsMap.get('Questions'));
            
            Objective objective = new Objective();
            objective.Questions = new List<Question>();
            
            for(Object q : (List<Object>) JSON.deserializeUntyped(questionJSON)){
                String innerJSON = JSON.serialize(q);
                Map<String, Object> questionMap = (Map<String, Object>)JSON.deserializeUntyped(innerJSON);
                //System.assert(valuesMap == null, questionMap.get('Number'));   
                
                Question question = new Question();
                question.NumberParam = (Integer)questionMap.get('Number');
                question.ResponseType = (String)questionMap.get('ResponseType');
                question.PointsPossible = (Integer)questionMap.get('PointsPossible');
                question.PointsAchieved = (Integer)questionMap.get('questionMap');
                question.StartedUTC = (String)questionMap.get('StartedUTC');
                question.TotalViewTimeSeconds = (Integer)questionMap.get('TotalViewTimeSeconds');
                question.Feedback = (String)questionMap.get('Feedback');
                question.Answers = (List<Answer>)getDeserializedObject(questionMap.get('Answers'), List<Answer>.class);
                
                objective.Questions.add(question);
                
            } 
            
            values.add(objective);
            
        }
        
        
        return values;               
    }
    
    private static Opportunity getCurrentOppty(String uniqueId){
        
        String query = 'Select ';
        query += String.join(new List<String>(getSobjectFields('Opportunity')), ',');
        query += ' From Opportunity';
        query += ' Where Alternate_ID__c = :uniqueId';
        
        List<Opportunity> opptyList = (List<Opportunity>)Database.query(query);
        return opptyList.isEmpty() == false ? opptyList.get(0) : null;
    }
    
    private static Integer getNumberOfTestsTaken(Opportunity oppty, String courseNumber){        
        
        Integer result = 0;
        
        for(Integer i = 1; i<=15; i++){            
            if(oppty.get('Course_' + courseNumber + '_Quiz_' + i + '_Grade__c') != null){
                result++;
            }
        }
        
        return result;
    }
    
    
    private static String getCourseNumber(Opportunity oppty, String productCode){        
        
        if(oppty.Course_1_Product_Code__c == null && 
           oppty.Course_2_Product_Code__c == null &&
           oppty.Course_3_Product_Code__c == null)
        {
            return '1';
        } else if(oppty.Course_1_Product_Code__c != null &&
                  !oppty.Course_1_Product_Code__c.equals(productCode) &&
                  oppty.Course_2_Product_Code__c == null)
        {
            return '2';
        } else if(oppty.Course_2_Product_Code__c != null &&
                  !oppty.Course_2_Product_Code__c.equals(productCode) &&
                  oppty.Course_3_Product_Code__c == null)
        {
            return '3';
        } else if(oppty.Course_1_Product_Code__c != null &&
                  oppty.Course_1_Product_Code__c.equals(productCode)){
                      return '1';
                  } else if(oppty.Course_2_Product_Code__c != null &&
                            oppty.Course_2_Product_Code__c.equals(productCode))
                  {
                      return '2';
                  } else if(oppty.Course_3_Product_Code__c != null &&
                            oppty.Course_3_Product_Code__c.equals(productCode))
                  {
                      return '3';
                  } else {
                      return '1';
                  }
        
        
        if(oppty.Course_2_Product_Code__c != null &&
           oppty.Course_2_Product_Code__c.equals(productCode))
        {
            return '2';
        } else if(oppty.Course_2_Product_Code__c != null &&
                  oppty.Course_3_Product_Code__c.equals(productCode))
        {
            return '3';
        } else {
            return '1';
        }
    }
    
    private static boolean getIsNotFinalExam(String title){
        final Set<String> finalExams = new Set<String>{'FE','FINAL EXAM', 'Final Exam'};
            Boolean result = false; 
        
        for(String fe : finalExams){
            if(title.containsIgnoreCase(fe)){
                result = true;
                break;
            }
            
        }
        
        return result;
    }
    
    private static String parseSingleValue(String body, string key){
        
        String regex = key;
        Pattern findPattern = Pattern.compile(regex);
        Matcher matcher = findPattern.matcher(body);
        
        if(matcher.find()){
            return matcher.group(0);
        } else {
            return null;
        }
    }
    
    private static String getAttempt(String title){
        String result;
        
        if(getIsNotFinalExam(title) == true){
            result = 'FE';
        } else {
            result = parseSingleValue(title, 'Q([0-9]*)');
            result = result.substring(1, result.length());            
        }
        
        return result;
    }
    
    private static void setQuizGrades(Opportunity oppty, WebHookParams params){
        
        String attempt = getAttempt(params.Title);
        String courseNumber = getCourseNumber(oppty, params.Enrollment.ProductInventoryDefaultIntegrationCode); 
        
        oppty.put('Course_' + courseNumber + '_Grade__c', params.Enrollment.overallScore);
        oppty.put('Course_' + courseNumber + '_Time_in_Content__c', (params.Enrollment.totalSeconds/60));
        
        if(attempt == 'FE'){
            oppty.put('Course_' + courseNumber + '_Grade_on_Final_Exam__c', params.score);    
        } else {
            oppty.put('Course_' + courseNumber + '_Quiz_' +attempt+ '_Grade__c', params.Score);            
        }
        
        oppty.put('Course_' + courseNumber + '_Tests_Taken__c', getNumberOfTestsTaken(oppty, courseNumber));
        oppty.put('Course_' + courseNumber + '_Product_Code__c', params.Enrollment.ProductInventoryDefaultIntegrationCode);
        
    }
    
    private static object getDeserializedObject(object reqBody, type apexType){
        return JSON.deserialize(JSON.serialize(reqBody), apexType);
    }
    
    public class WebHookParams{
        public WebHook WebHook {get; set;}
        public String Title {get; set;}
        public String Description {get; set;}
        public String MinimumPercentageToPass {get; set;}
        public Integer TimeLimit  {get; set;}
        public Integer AttemptNumber {get; set;}
        public String StartedUTC {get; set;}
        public String EndedUTC {get; set;}
        public Decimal Score {get; set;}
        public Decimal MinimumScore   {get; set;}
        public String Status {get; set;}
        public List<Objective> Objectives {get; set;}
        public Enrollment Enrollment {get; set;}
        public Learner Learner {get; set;}
        
    }
    
    public class Enrollment {
        public Integer status {get; set;}
        public String activeFromUTC {get; set;}
        public String activeThruUTC {get; set;}
        public String firstViewedUTC {get; set;}
        public String lastViewedUTC {get; set;}
        public String learnerEnrollmentDetailURL {get; set;}
        public String AdminEnrollmentDetailURL {get; set;}
        public Decimal overallScore {get; set;}
        public Decimal totalSeconds {get; set;}
        public String AchivedOnUTC {get; set;}
        public String ProductInventoryDefaultIntegrationCode {get; set;}
        public String ProductInventoryCompletionIntegrationCode {get; set;}
    }
    
    public class WebHook{
        public Integer typeId {get; set;}
        public String typeDescription {get; set;}
        public String Name {get; set;}
    }
    
    public class Objective{
        public String Title {get; set;}
        public Integer MinimumPercentageToPass {get; set;}
        public List<Question> Questions {get; set;}
        
    }
    
    public class Question {
        public Integer NumberParam {get; set;}
        public String ResponseType {get; set;}
        public Integer PointsPossible {get; set;}
        public Integer PointsAchieved {get; set;}
        public String StartedUTC {get; set;}
        public Integer TotalViewTimeSeconds {get; set;}
        public String Feedback {get; set;}
        public List<Answer> Answers {get; set;}
    }
    
    public class Answer {
        public Boolean IsCorrectChoice {get; set;}
        public Boolean IsLearnerChoice {get; set;}
        public String Choice {get; set;}
        public String Answer {get; set;}
    }
    
    
    public class Learner {
        public String firstName {get; set;}
        public String lastName {get; set;}
        public String email {get; set;}
        public String alternateId {get; set;}
        public String systemTimeZone {get; set;}
        public String birthDate {get; set;}
        public String gender {get; set;}
        public String address1 {get; set;}
        public String address2 {get; set;}
        public String address3 {get; set;}
        public String cityLocality {get; set;}
        public String stateProvince {get; set;}
        public String zipPostalCode {get; set;}
        public Integer country {get; set;}
        public PhoneNumber phoneNumber1 {get; set;}
        public BooleanValue boolean1 {get; set;}
        public BooleanValue boolean2 {get; set;}
        public DateValue date1 {get; set;}
        public DateValue date2 {get; set;}
        public GroupValue group1 {get; set;}
        public GroupValue group2 {get; set;}
        public GroupValue group3 {get; set;}
        public GroupValue group4 {get; set;}
        public GroupValue group5 {get; set;}
        public LookUp lookUp1 {get; set;}
        public LookUp lookUp2 {get; set;}
        public LookUp lookUp3 {get; set;}
        public LookUp lookUp4 {get; set;}
        public LookUp lookUp5 {get; set;}
        public LookUp lookUp6 {get; set;}
        public LookUp lookUp7 {get; set;}
        public LookUp lookUp8 {get; set;}
        public LookUp lookUp9 {get; set;}
        public LookUp lookUp10 {get; set;}
        public LookUp lookUp11 {get; set;}
        public LookUp lookUp12 {get; set;}
        public LookUp lookUp13 {get; set;}
        public LookUp lookUp14 {get; set;}
        public FreeText freeText1 {get; set;}
        public FreeText freeText2 {get; set;}
        public FreeText freeText3 {get; set;}
        public FreeText freeText4 {get; set;}
        public String manageLearnerURL {get; set;}
        public String insertedUTC {get; set;}
        public String lastLoginUTC {get; set;}
        public String nABPeProfileId {get; set;}
        public String status {get; set;}
        public String statusLastChangedUTC {get; set;}
        
        
    }
    
    public class PhoneNumber {
        public String label {get; set;}
        public String value {get; set;}
    }
    
    public class BooleanValue {
        public String label {get; set;}
        public Boolean value {get; set;}
    }
    
    public class DateValue {
        public String label {get; set;}
        public String value {get; set;}
    }
    
    public class GroupValue {
        public String label {get; set;}
        public String code {get; set;}
        public String description {get; set;}
    }
    
    public class LookUp {
        public String label {get; set;}
        public String code {get; set;}
        public String description {get; set;}
    }
    
    public class FreeText {
        public String label {get; set;}
        public String value {get; set;}
    }    
    
    public class Result {
        public Integer statusCode {get; set;}
        public String message {get; set;}
    }
    
}