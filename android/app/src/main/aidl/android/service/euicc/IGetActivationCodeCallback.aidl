package android.service.euicc;

interface IGetActivationCodeCallback {
    oneway void onSuccess(String activationCode);
    oneway void onFailure();
}