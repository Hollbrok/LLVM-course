#include <stdio.h>


// [x]
void funcStartLogger(char* funcName, long int valID){
    return;
    printf("[LOG] %s %s\n", funcName);
}

// [x]
void funcEndLogger(char* funcName, long int valID){
    // ret <from>
    printf("[Ret] %s\n", funcName);
}

////////////////////////////////////////////////

// [x]
void callLogger(char* calleeName, char* callerName, long int valID){
    // from -> tp
    printf("[Call] %s %s\n", calleeName, callerName);
}

// [x]
void cmpLogger(char* funcName, char* opName, long int valID) {
    //printf("[Cmp] %d = %d %s %d\n", /*funcName,*/ val, arg0, opName, arg1);
    printf("[Cmp] %s %s\n", funcName, opName);
}

// [x]
void binOptLogger(char* funcName, char* opName, long int valID){
    printf("[Bin] %s %s\n", funcName, opName);
}

// [x]
void allocOptLogger(char* funcName, char* opName, long int valID){
    printf("[alloca] %s %s\n", funcName, opName);
}

// [x]
void castLogger(char* funcName, char* opName, long int valID) {
    printf("[cast] %s %s\n", funcName, opName);
}

// [x]
void getelemptrLogger(char* funcName, char* opName, long int valID) {
    printf("[Addr Op] %s %s\n", funcName, opName);
}

// [x]
void condBranchLogger(char* funcName, char* opName, long int valID) {
    printf("[Cond br] %s %s\n", funcName, opName);
}

// [x]
void uncondBranchLogger(char* funcName, char* opName, long int valID) {
    printf("[Uncond br] %s %s\n", funcName, opName);
}

// [x]
void storeLogger(char* funcName, char* opName, long int valID) {
    printf("[Store] %s %s\n", funcName, opName);
}

// [x]
void loadLogger(char* funcName, char* opName, long int valID) {
    printf("[Load] %s %s\n", funcName, opName);
}

void logAll(const char* log) {
    printf("[LA] %s\n", log);
}