package sandbox.model;

import org.apache.commons.lang3.RandomStringUtils;

import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class PersonUtils {
    private static final Random RANDOM = new Random();

    public static boolean isAdult(Person person) {
        return person.getAge() > 18;
    }

    public static List<Person> factorize(int amount) {

        return Stream.generate(() -> new Person(RandomStringUtils.random(RANDOM.nextInt(8))))
                .limit(amount)
                .collect(Collectors.toList());
    }
}
