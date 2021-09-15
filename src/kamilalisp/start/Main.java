package kamilalisp.start;

import kamilalisp.api.Evaluation;
import kamilalisp.data.Environment;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Environment env = Evaluation.createDefaultEnv();
        Scanner s = new Scanner(System.in);
        while(s.hasNextLine())
            Evaluation.evalString(env, s.nextLine());
    }
}
