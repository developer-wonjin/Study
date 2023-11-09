package chap02;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Example {
    public static void main(String[] args) {

        String str = "Tom";
        String regex = "[A-Za-z0-9]";
        boolean res = str.matches(regex);

        Pattern pattern = Pattern.compile(regex);

        System.out.println(res);
    }
}
