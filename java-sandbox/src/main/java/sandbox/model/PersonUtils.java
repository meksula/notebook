package sandbox.model;

public class PersonUtils {

    public static boolean isAdult(Person person) {
        return person.getAge() > 18;
    }
}
