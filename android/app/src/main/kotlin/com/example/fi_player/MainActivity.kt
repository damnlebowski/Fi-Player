package com.example.fi_player

import io.flutter.embedding.android.FlutterActivity
import android.content.*
import androidx.annotation.NonNull
import io.flutter.embedding.engine. FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.provider.MediaStore


class MainActivity: FlutterActivity() {

    private val _channel = "com.lebowski/video_files/search"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            _channel
        ).setMethodCallHandler { call, result ->
            var videoList: List<String> = emptyList()
            if (call.method == "search") {

                videoList = fetchVideoFiles(applicationContext)

            }
            result.success( videoList )

        }

    }

    private fun fetchVideoFiles(context: Context): List<String> {
        val videoList = mutableListOf<String>()
        val projection = arrayOf(
            MediaStore.Video.Media.DATA,

        )

        val selection = null
        val selectionArgs = null
        val sortOrder = null

        context.contentResolver.query(
            MediaStore.Video.Media.EXTERNAL_CONTENT_URI,
            projection,
            selection,
            selectionArgs,
            sortOrder
        )?.use { cursor ->
            val dataColumn = cursor.getColumnIndexOrThrow(MediaStore.Video.Media.DATA)

            while (cursor.moveToNext()) {
                val path = cursor.getString(dataColumn)
                videoList.add(path)
            }
        }

        return videoList
    }

}
