package sandbox.talks.devoxx.talk_01;

import sandbox.model.Person;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.concurrent.ForkJoinPool;

import sandbox.model.PersonUtils;
import sandbox.utils.TimeMeasureDecorator;

public class ParallelStreamExample {

    private static List<String> names = Arrays.asList(
            "Ala",
            "Beata",
            "Celina",
            "Diana",
            "Ela",
            "Fiona",
            "Gienia"
    );

    public static void main(String[] args) {
        TimeMeasureDecorator.execute(
                ParallelStreamExample::findAnyAdultPerson
        );
    }

    /**
     * W tym wypadku lista będzie przetwarzana w strumieniu sekwencyjnie, po kolei
     * */
    static void streamExample() {
        names.stream()
                .map(Person::new)
                .forEach(System.out::println);
    }

    /**
     * W tym przypadku natomiast, lista jako strumień będzie przetwarzana równolegle,
     * więc kolejność nie będzie zachowana, ponieważ dane zostaną przetworzone
     * na różnych wątkach
     * */
    static void parallelStreamExample() {
        names.parallelStream()
                .map(Person::new)
                .forEach(System.out::println);
    }

    static void forEachOrderExample() {
        names.parallelStream()
                .map(Person::new)
                .filter(PersonUtils::isAdult)
                .forEachOrdered(System.out::println); /* Jeśli użyjemy forEachOrdered() to strumień zostanie przetworzony na jednym wątku!
                                                         Będzie to pomocniczy wątek, a nie "main",
                                                         Kolejność obiektów zostanie zachowana. */
    }

    static void reduceExample() {
        Integer reduce = names.parallelStream()
                .map(Person::new)
                .filter(PersonUtils::isAdult)
                .sorted((Comparator.comparingInt(person -> person.getFirstName().indexOf(0))))
                .peek(System.out::println)
                .map(Person::getAge)
                .reduce(0, Integer::sum);

        ForkJoinPool forkJoinPool = ForkJoinPool.commonPool();
        System.out.println(forkJoinPool.getActiveThreadCount());
        System.out.println("\nTotal age of adult persons: " + reduce);
    }

    /**
     * findFirst()  jest zawsze posortowany!
     * Niezależnie od tego czy użyję parallelStream czy stream sekwencyjny
     * */
    static void findFirstAdultPerson() {
        Person person = names.parallelStream()
                .map(Person::new)
                .filter(PersonUtils::isAdult)
                .findFirst()
                .orElseThrow();

        System.out.println(person);
    }

    /**
     * Nie jest posortowany, znajdzie jakikolwiek obiekt
     * */
    static void findAnyAdultPerson() {
        Person person = names.parallelStream()
                .map(Person::new)
                .filter(PersonUtils::isAdult)
                .findAny()
                .orElseThrow();

        System.out.println(person);
    }
}