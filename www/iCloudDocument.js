
module.exports = {

    test: function (name, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "iCLoudDocument", "test", [name]);
    },

    checkFile: function (fileName,successCallback, errorCallback) {
    var args = fileName;
        cordova.exec(successCallback, errorCallback, "iCLoudDocument", "checkFile", [args]);
    },

    setContainer: function (name) {
        cordova.exec(null, null, "iCLoudDocument", "setContainer", [name]);
    },

    listDocuments: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "iCLoudDocument", "listDocuments", []);
    },

    uploadFile: function (fileName, successCallback, errorCallback) {
        var args = fileName;
        cordova.exec(successCallback, errorCallback, "iCLoudDocument", "uploadFile", [args]);
    },

    retrieveFile: function (fileName, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "iCLoudDocument", "retrieveFile", []);
    }
};


/*global cordova, module*/

// module.exports = {
//     test: function (name, successCallback, errorCallback) {
//         cordova.exec(successCallback, errorCallback, "iCLoudDocument", "test", [name]);
//     }
// };
