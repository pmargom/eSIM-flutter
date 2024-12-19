package com.example.esim_flutter

import java.util.concurrent.atomic.AtomicReference

class EsimActivationCodeManager {

    companion object {
        private val currentLpa = AtomicReference<String?>(null)
        private const val TAG = "EsimActivationCodeManager"

        fun getCurrentLpa(): String? {
            return currentLpa.getAndSet(null)
        }
    }

    fun setLpa(lpa: String) {
        currentLpa.set(lpa)
    }
}