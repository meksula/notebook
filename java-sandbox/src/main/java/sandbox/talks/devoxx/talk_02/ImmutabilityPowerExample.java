package sandbox.talks.devoxx.talk_02;

import sandbox.utils.TimeMeasureDecorator;

import java.util.Arrays;
import java.util.List;

public class ImmutabilityPowerExample {
    private static List<Integer> numbers = Arrays.asList(1,2,3,4,5,6,7,8,9,0);

    public static void main(String[] args) {
        System.out.println("==> IMMUTABLE");
        TimeMeasureDecorator.execute(() -> immutableCodeExample(numbers));

        System.out.println("\n\n==> MUTABLE");
        TimeMeasureDecorator.execute(() -> mutableCodeExample(numbers));

        System.out.println("\n\n==> IMPURE FUNCTION");
        TimeMeasureDecorator.execute(() -> System.out.println("Result" + impureFunctionExample()));
    }

    private static int mutableCodeExample(List<Integer> numbers) {
        int counter = 0;
        for (int i = 0; i < numbers.size(); i++) {
            if (i % 2 == 0) {
                counter = counter * 2;
            }
        }
        return counter;
    }

    /**
     * Warto tutaj zaznaczyć, że jeśli użyjemy kilka operacji filter() jedna po drugiej
     * to pod spodem zostanie to zoptymalizowane tak, że wykona się jedna funkcja
     * */
    private static int immutableCodeExample(List<Integer> numbers) {
        return numbers.stream()
                .filter(integer -> integer % 2 == 0)
                .mapToInt(integer -> integer * 2)
                .sum();
    }

    /**
     * Wynik zawsze będzie taki sam dla podanych argumentów
     * */
    private static int pureFunctionExample(int x, int y) {
        return x * y;
    }

    /**
     * Nie rób tego w domu!
     * Ten strumień nie jest 'pure' ponieważ zależy od elementu mutowalnego - wartości tablicy zmieniają wartości
     * */
    private static int impureFunctionExample() {
        int factor[] = new int[] { 2 };

        Integer reduce = numbers.stream()
                .map(integer -> integer * factor[0])
                .reduce(0, (Integer::sum));

        factor[0] = 0;

        return reduce;
    }
}
