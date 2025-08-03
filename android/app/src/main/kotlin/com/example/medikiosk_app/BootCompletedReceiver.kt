package com.example.medikiosk_app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.Toast

class BootCompletedReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            Toast.makeText(context, "🔄 Boot Completed! Launching App...", Toast.LENGTH_LONG).show()
            Log.d("BOOT_RECEIVER", "✅ Device booted. Launching BootLauncherActivity...")

            try {
                val launchIntent = Intent(context, BootLauncherActivity::class.java)
                launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                context.startActivity(launchIntent)
                Log.d("BOOT_RECEIVER", "🚀 BootLauncherActivity launched successfully.")
            } catch (e: Exception) {
                Log.e("BOOT_RECEIVER", "❌ Failed to launch BootLauncherActivity: ${e.message}", e)
            }
        }
    }
}
