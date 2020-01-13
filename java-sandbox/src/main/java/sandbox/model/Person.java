package sandbox.model;

import lombok.Getter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

@Getter
public class Person {
    private static final Random random = new Random();
    private LocalDateTime createLocalDate;
    private String firstName;
    private int age;

    public Person(String firstName) {
        this.firstName = firstName;
        this.createLocalDate = LocalDateTime.now();
        this.age = random.nextInt(70);
    }

    public Person(String firstName, int age, LocalDateTime createLocalDate) {
        this.firstName = firstName;
        this.createLocalDate = createLocalDate;
        this.age = age;
    }

    @Override
    public String toString() {
        return "\nCreated at: [" + this.createLocalDate.format(DateTimeFormatter.ofPattern("YYYY-MM-dd")) + "]" +
                "\nPerson with name: " + this.firstName +
                "\nAge: " + this.age +
                "\nProcessed by Thread: " + Thread.currentThread().getName();
    }
}
