import ballerina/http;
// import ballerina/observe;
import ballerina/log;
import ballerinax/prometheus as _;
import ballerinax/jaeger as _;

type Mail record {
    string mailTo;
    string mailFrom;
    string mailSubject;
};

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9092) {

    # A resource for generating greetings
    # + singleMessage - the mail payload
    # + return - bool true or false
    resource function post checkmail(@http:Payload Mail singleMessage, http:Request request) returns boolean|error {
        log:printDebug("checkmail service invoked.");
        log:printDebug("Traceparent: " + check request.getHeader("traceparent"));
        // Send a response back to the caller.
        if singleMessage.mailTo == "" {
            return false;
        } else {
            return true;
        }
    }
}
