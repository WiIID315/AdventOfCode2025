import java.util.*;
import java.io.*;

fun main(args: Array<String>) {
    val br = BufferedReader(InputStreamReader(System.`in`))
    val pw = PrintWriter(BufferedWriter(OutputStreamWriter(System.`out`)))

    var num: Int = 50
    var ans: Int = 0
    var str: String? = br.readLine();
    while(!str.isNullOrEmpty()) {
        var add = str.substring(1).toInt()
        if (str[0] == 'L') {
            if(add >= num) {
                ans += (add - num) / 100  + if(num == 0) 0 else 1
            }
            num = (num - add) % 100
            if(num < 0) num += 100
        } else {
            if(add >= 100 - num) {
                ans += (add + num) / 100
            }
            num = (num + add) % 100
        }
        str = br.readLine()
    }

    pw.println(ans)

    br.close()
    pw.close()
}
