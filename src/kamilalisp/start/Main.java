package kamilalisp.start;

import kamilalisp.api.Evaluation;
import kamilalisp.data.Atom;
import kamilalisp.data.Environment;

import java.util.List;
import java.util.Scanner;

public class Main {
    private static void banner() {
        System.out.println("KamilaLisp v 1.0 - Copyright (C) Kamila Szewczyk, 2021.");
        System.out.println("Interactive mode.");
        System.out.println();
    }

    private static void prompt() {
        System.out.print("% ");
        System.out.flush();
    }

    public static void main(String[] args) {
        Environment env = Evaluation.createDefaultEnv();
        Scanner s = new Scanner(System.in);
        banner(); prompt();
        while(s.hasNextLine()) {
            List<Atom> result = Evaluation.evalString(env, s.nextLine());
            result.forEach(System.out::println);
            prompt();
        }
    }
}
