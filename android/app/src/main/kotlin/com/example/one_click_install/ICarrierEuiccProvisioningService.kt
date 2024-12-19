package com.example.esim_flutter

interface IGetActivationCodeCallback {
    fun onSuccess(activationCode: String)
    fun onFailure()
}

interface ICarrierEuiccProvisioningService {
    fun getActivationCode(callback: IGetActivationCodeCallback)
    fun getActivationCodeForEid(eid: String, callback: IGetActivationCodeCallback)
}

