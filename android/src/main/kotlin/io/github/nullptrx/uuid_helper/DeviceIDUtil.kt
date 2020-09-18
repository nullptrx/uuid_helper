package io.github.nullptrx.uuid_helper

import android.annotation.SuppressLint
import android.media.MediaDrm
import android.os.Build
import java.security.MessageDigest
import java.util.*

object DeviceIDUtil {
  private val WIDEVINE_UUID = UUID(-0x121074568629b532L, -0x5c37d8232ae2de13L)
  val uniqueID: String?
    get() {
      var uniqueId = getUniqueID(WIDEVINE_UUID)
      if (uniqueId == null) {
        uniqueId = uniquePsuedoID
      }
      return uniqueId
    }

  private fun getUniqueID(uuid: UUID): String? {
    var wvDrm: MediaDrm? = null
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
      try {
        wvDrm = MediaDrm(uuid)
        val mivevineId = wvDrm.getPropertyByteArray(MediaDrm.PROPERTY_DEVICE_UNIQUE_ID)
        val md = MessageDigest.getInstance("SHA-256")
        md.update(mivevineId)
        UUID.nameUUIDFromBytes(md.digest()).toString()
      } catch (e: Exception) {
        //WIDEVINE is not available
        null
      } finally {
        if (wvDrm != null) {
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            wvDrm.close()
          } else {
            wvDrm.release()
          }
        }
      }
    } else null
  }


  /**
   *  获得独一无二的Psuedo ID
   */
  @get:SuppressLint("MissingPermission")
  private val uniquePsuedoID: String
    get() {
      var serial: String? = null
      val szDevID = "35" + Build.BOARD.length % 10 + Build.BRAND.length % 10 + Build.CPU_ABI.length % 10 + Build.DEVICE.length % 10 + Build.DISPLAY.length % 10 + Build.HOST.length % 10 + Build.ID.length % 10 + Build.MANUFACTURER.length % 10 + Build.MODEL.length % 10 + Build.PRODUCT.length % 10 + Build.TAGS.length % 10 + Build.TYPE.length % 10 + Build.USER.length % 10 //13 位
      try {
        serial = Build::class.java.getField("SERIAL").get(null).toString()
        //API>=9 使用serial号
        return UUID(szDevID.hashCode().toLong(), serial.hashCode().toLong()).toString()
      } catch (e: Exception) {
        //serial需要一个初始化
        serial = "serial" // 随便一个初始化
      }
      //使用硬件信息拼凑出来的15位号码
      return UUID(szDevID.hashCode().toLong(), serial.hashCode().toLong()).toString()
    }
}