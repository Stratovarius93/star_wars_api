package com.example.star_wars_app

import io.flutter.embedding.android.FlutterActivity

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(), SensorEventListener {

 private var sensorManager: SensorManager? = null
 private var gyroSensor: Sensor? = null
 private var methodChannel: MethodChannel? = null

 override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
     super.configureFlutterEngine(flutterEngine)
     methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "gyroscope_channel")
     sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
     gyroSensor = sensorManager?.getDefaultSensor(Sensor.TYPE_GYROSCOPE)
 }

 override fun onResume() {
     super.onResume()
     gyroSensor?.let {
         sensorManager?.registerListener(this, it, SensorManager.SENSOR_DELAY_NORMAL)
     }
 }

 override fun onPause() {
     super.onPause()
     sensorManager?.unregisterListener(this)
 }

 override fun onSensorChanged(event: SensorEvent?) {
     event?.let {
         if (it.sensor == gyroSensor) {
             val xValue = event.values[0]
             val yValue = event.values[1]
             methodChannel?.invokeMethod("updateGyroscopeValues", listOf(xValue, yValue ))
         }
     }
 }

 override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
 }
}