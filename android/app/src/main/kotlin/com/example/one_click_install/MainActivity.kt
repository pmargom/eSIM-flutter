package com.example.esim_flutter

import android.app.Activity
import android.content.Intent
import android.telephony.euicc.EuiccManager
import android.util.Log
import androidx.activity.result.contract.ActivityResultContracts
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "samples.flutter.dev/esim"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "launchESimSetup") {

                val activationCode = (call.arguments as HashMap<*, *>).values.first()
                launchESimSetup(activationCode.toString())
            } else {
                result.notImplemented()
            }
        }
    }

    private fun launchESimSetup(activationCode: String) {
        try {
            val intent = Intent(EuiccManager.ACTION_START_EUICC_ACTIVATION)
            intent.putExtra(EuiccManager.EXTRA_USE_QR_SCANNER, false)
            Log.d("TAG", "launchESimSetup: Start activity")
            val eSIMCode = "LPA:1\$xxxxxx.com\$activation_code"
            EsimActivationCodeManager().setLpa(eSIMCode)
            eSimInstallLauncher.launch(intent)
            Log.d("TAG", "launchESimSetup: Start activity started")
        } catch (e: Exception) {
            Log.w("TAG", "launchESimSetup: Error")
            e.printStackTrace();
        }
    }

    private val eSimInstallLauncher = registerForActivityResult(
        ActivityResultContracts.StartActivityForResult()
    ) { result ->
        when (result.resultCode) {
            Activity.RESULT_OK -> {
                //viewModel.saveESimState(eSimData.iccid)
                Log.w("TAG", "Activity.RESULT_OK")
            }

            EuiccManager.EMBEDDED_SUBSCRIPTION_RESULT_ERROR -> {
                Log.w("TAG", "EMBEDDED_SUBSCRIPTION_RESULT_ERROR")
//                findNavController()
//                    .navigate(
//                        DetailCardFragmentDirections
//                            .actionDetailCardFragmentToInstallationFailedFragment()
//                    )
            }

            else -> {
                Log.w("TAG", "else")
//                findNavController()
//                    .navigate(
//                        DetailCardFragmentDirections
//                            .actionDetailCardFragmentToInstallationFailedFragment()
//                    )
            }
        }
    }





}
