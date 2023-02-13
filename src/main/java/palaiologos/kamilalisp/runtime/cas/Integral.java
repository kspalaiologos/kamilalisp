package palaiologos.kamilalisp.runtime.cas;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Integral extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 2) {
            Atom expr = args.get(0);
            Atom var = args.get(1);
            var.assertTypes(Type.IDENTIFIER);
            String differential = var.getIdentifier().substring(1);
            if(!differential.matches("[a-zA-Z]+") || differential.isEmpty())
                throw new RuntimeException("Invalid differential.");
            String expressionCode = CasExpressionGenerator.generateExpression(env, expr);
            String instruction = "integrate(" + expressionCode + ", " + differential + ")\n";
            EvaluationResult r = (EvaluationResult) FriCAS.withFriCas(x -> {
                x.apply(")clear all\n");
                x.apply(")set output algebra off\n");
                x.apply(")set output fortran on\n");
                System.out.println("digits: " + env.get("fr"));
                x.apply("digits(" + env.get("fr") + ")\n");
                System.out.println("instruction: " + instruction);
                return x.apply(instruction);
            });
            if(r.isSuccessful()) {
                return FortranParser.parse(r.getResult());
            } else {
                throw new RuntimeException("Failed to evaluate integral. " + r.getResult());
            }
        } else if(args.size() == 4) {
            Atom begin = Evaluation.evaluate(env, args.get(0));
            Atom end = Evaluation.evaluate(env, args.get(1));
            Atom expr = args.get(2);
            Atom var = args.get(3);
            var.assertTypes(Type.IDENTIFIER);
            String differential = var.getIdentifier().substring(1);
            if(!differential.matches("[a-zA-Z]+") || differential.isEmpty())
                throw new RuntimeException("Invalid differential.");
            String expressionCode = CasExpressionGenerator.generateExpression(env, expr);
            String beginCode = CasExpressionGenerator.generateExpression(env, begin);
            String endCode = CasExpressionGenerator.generateExpression(env, end);
            String instruction = "integrate(" + expressionCode + ", " + differential + ", " + differential + "=(" + beginCode + ")..(" + endCode + "))\n";
            EvaluationResult r = (EvaluationResult) FriCAS.withFriCas(x -> {
                x.apply(")clear all\n");
                x.apply(")set output algebra off\n");
                x.apply(")set output fortran on\n");
                x.apply("digits(" + env.get("fr") + ")\n");
                return x.apply(instruction);
            });
            if(r.isSuccessful()) {
                return FortranParser.parse(r.getResult());
            } else {
                throw new RuntimeException("Failed to evaluate integral. " + r.getResult());
            }
        } else {
            throw new RuntimeException("Invalid number of arguments.");
        }
    }

    @Override
    protected String name() {
        return "cas:integral";
    }
}
