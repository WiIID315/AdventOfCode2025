import java.util.*;
import java.io.*;

fun main(args: Array<String>) {
    var br = BufferedReader(InputStreamReader(System.`in`))
    var st: StringTokenizer
    var pw = PrintWriter(BufferedWriter(OutputStreamWriter(System.`out`)))

    var num: Int = 50
    var ans: Int = 0
    var str: String? = br.readLine();
    while(!str.isNullOrEmpty()) {
        var add = str.substring(1).toInt()
        if (str[0] == 'L') {
            add *= -1
        }
        num = (num + 100 + add) % 100
        if(num == 0) {
            ans++;
        }
        str = br.readLine()
    }

    pw.println(ans)

    br.close()
    pw.close()
}
