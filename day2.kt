import java.util.*;
import java.io.*;

fun main(args: Array<String>) {
    val br = BufferedReader(InputStreamReader(System.`in`))
    val pw = PrintWriter(BufferedWriter(OutputStreamWriter(System.`out`)))

    var sum: Long = 0
    val ranges: List<String> = br.readLine().trim().split(',')
    for(range in ranges) {
        val endPoints = range.split('-')
        outer@ for(i in endPoints[0].toLong().. endPoints[1].toLong()) {
            val str = i.toString()
            //Bruh this is so inefficient
            lengths@ for(len in 1..str.length / 2) {
                if(str.length % len != 0) continue
                val substr = str.substring(0, len)
                for(idx in len.. str.length - len step len) {
                    // println("${idx} ${str.substring(idx, idx + len)}")
                    if(str.substring(idx, len + idx) != substr) {
                        continue@lengths
                    }
                }
                sum += i
                continue@outer
            }
        }
    }
    println(sum)

    br.close()
    pw.close()
}
