package com.example.wechat

import android.graphics.Bitmap
import android.media.MediaMetadataRetriever
import android.os.AsyncTask
import android.os.Bundle
import android.util.Log

import java.io.ByteArrayOutputStream
import java.io.FileOutputStream
import java.util.HashMap

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(flutterView, "app.wechat.channel").setMethodCallHandler { call, result ->
            val args = call.arguments<Map<String, Any>>()

            try {
                val video = args["video"] as String
                val format = args["format"] as Int
                val maxhow = args["maxhow"] as Int
                val quality = args["quality"] as Int
                Thread {
                    if (call.method == "file") {
                        val path = args["path"] as String
                        val data = buildThumbnailFile(video, path, format, maxhow, quality)
                        runOnUiThread { result.success(data) }
                    } else if (call.method == "data") {
                        val data = buildThumbnailData(video, format, maxhow, quality)
                        runOnUiThread { result.success(data) }
                    } else {
                        runOnUiThread { result.notImplemented() }
                    }
                }.start()

            } catch (e: Exception) {
                e.printStackTrace()
                result.error("exception", e.message, null)
            }
        }
    }

    private fun buildThumbnailData(vidPath: String, format: Int, maxhow: Int, quality: Int): ByteArray {
        Log.d(TAG, String.format("buildThumbnailData( format:%d, maxhow:%d, quality:%d )", format, maxhow, quality))
        val bitmap = createVideoThumbnail(vidPath, maxhow) ?: throw NullPointerException()

        val stream = ByteArrayOutputStream()
        bitmap.compress(intToFormat(format), quality, stream)
        bitmap.recycle()
        if (bitmap == null)
            throw NullPointerException()
        return stream.toByteArray()
    }

    private fun buildThumbnailFile(vidPath: String, path: String?, format: Int, maxhow: Int, quality: Int): String {
        Log.d(TAG, String.format("buildThumbnailFile( format:%d, maxhow:%d, quality:%d )", format, maxhow, quality))
        val bytes = buildThumbnailData(vidPath, format, maxhow, quality)
        val ext = formatExt(format)
        val i = vidPath.lastIndexOf(".")
        var fullpath = vidPath.substring(0, i + 1) + ext

        if (path != null) {
            if (path.endsWith(ext)) {
                fullpath = path
            } else {
                // try to save to same folder as the vidPath
                val j = fullpath.lastIndexOf("/")

                if (path.endsWith("/")) {
                    fullpath = path + fullpath.substring(j + 1)
                } else {
                    fullpath = path + fullpath.substring(j)
                }
            }
        }

        try {
            val f = FileOutputStream(fullpath)
            f.write(bytes)
            f.close()
            Log.d(TAG, String.format("buildThumbnailFile( written:%d )", bytes.size))
        } catch (e: java.io.IOException) {
            e.stackTrace
            throw RuntimeException(e)
        }

        return fullpath
    }

    companion object {
        private val TAG = "Android Platform"
        private val HIGH_QUALITY_MIN_VAL = 70

        private fun intToFormat(format: Int): Bitmap.CompressFormat {
            when (format) {
                0 -> return Bitmap.CompressFormat.JPEG
                1 -> return Bitmap.CompressFormat.PNG
                2 -> return Bitmap.CompressFormat.WEBP
                else -> return Bitmap.CompressFormat.JPEG
            }
        }

        private fun formatExt(format: Int): String {
            when (format) {
                0 -> return "jpg"
                1 -> return "png"
                2 -> return "webp"
                else -> return "jpg"
            }
        }

        /**
         * Create a video thumbnail for a video. May return null if the video is corrupt
         * or the format is not supported.
         *
         * @param video      the URI of video
         * @param targetSize max width or height of the thumbnail
         */
        fun createVideoThumbnail(video: String, targetSize: Int): Bitmap? {
            var bitmap: Bitmap? = null
            val retriever = MediaMetadataRetriever()
            try {
                Log.d(TAG, String.format("setDataSource: %s )", video))
                if (video.startsWith("file://") || video.startsWith("/")) {
                    retriever.setDataSource(video)
                } else {
                    retriever.setDataSource(video, HashMap())
                }
                bitmap = retriever.getFrameAtTime(-1)
            } catch (ex: IllegalArgumentException) {
                ex.printStackTrace()
            } catch (ex: RuntimeException) {
                ex.printStackTrace()
            } finally {
                try {
                    retriever.release()
                } catch (ex: RuntimeException) {
                    ex.printStackTrace()
                }

            }

            if (bitmap == null)
                return null

            if (targetSize != 0) {
                val width = bitmap.getWidth()
                val height = bitmap.getHeight()
                val max = Math.max(width, height)
                val scale = targetSize.toFloat() / max
                val w = Math.round(scale * width)
                val h = Math.round(scale * height)
                Log.d(TAG, String.format("original w:%d, h:%d, scale:%6.4f => %d, %d", width, height, scale, w, h))
                bitmap = Bitmap.createScaledBitmap(bitmap, w, h, true)
            }
            return bitmap
        }
    }
}