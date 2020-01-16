package sandbox.talks.devoxx.talk_01;

import sandbox.model.Person;
import sandbox.utils.TimeMeasureDecorator;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;

import static sandbox.model.PersonUtils.factorize;

public class CompletableFutureExample {

    public static void main(String[] args) {
//        TimeMeasureDecorator.execute(
//                basicCompletableFuture()
//        );

        CompletableFuture<Void> completableFuture = CompletableFuture.supplyAsync(CompletableFutureExample::makeHardHttpRequestSimulation)
                .thenApply(integer -> integer + " HTTP Status")                                        //  thenApply() normalne mapowanie rezultatu operacji asynchronicznej
                .thenAccept(status -> System.out.println("Http Request ends with status: " + status))  //  thenAccept() konsumujemy rezultat ansynchronicznej operacji np. jakimś serwisem
                .whenCompleteAsync((aVoid, throwable) -> System.out.println("HTTP client finished work! Wątek "
                        + Thread.currentThread() + " zakończył swoją asynchroniczną pracę!"))
//                .completeExceptionally(new RuntimeException("Completed exceptionally"))              // Ten operator rzuca wyjątek jeśli operacja nie została jeszcze ukończona, a próbujemy zrobić get()

                .exceptionally(throwable -> {                                                          // służy do przechwycenia wyjątków, kiedy operacja się nie powiedzie
                    throw new RuntimeException("\"Unfortunatelly HTTP request not executed correctly\""); // dobrą praktyką jest zafiksować error i wrócić do normalnego wykonania
                })                       ;                                                              // jak nie mamy np. odpowiedzi, to dać jakąś defaultową czy coś

        for (int i = 0; i < 2000; i++) {
            try {
                Thread.sleep(1000);
                System.out.println("Iteration no. " + i + ", nie blokujemy głównego wątku " + Thread.currentThread());
                if (completableFuture.isDone()) {
                    System.out.println("HTTP request was executed");
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        TimeMeasureDecorator.execute(timeoutInPipelineExample());
    }

    /**
     * Na wstępie zauważ, że CompletableFuture jest "nieśmiertelne",
     * nie ginie kiedy jakaś akcja jest wywołana, zawsze będzie zwracany objekt tej klasy
     * Dlatego dostajemy Void.class opakowany w CompletableFuture
     * <p>
     * Nie używaj metody get() - to jest kod blokujący!
     */
    private static Runnable basicCompletableFuture() {
        return () -> {
            CompletableFuture<Integer> future = create();
            try {
                future.thenAccept(System.out::println)
                        .thenRun(() -> System.out.println("This CompletableFuture never dies!"))
                        .get();                                         /* Metoda get() rujnuje wszystko!
                                                                           Kod nie wykonuje się już asynchronicznie,
                                                                           ale blokuje się i czeka na wykonanie operacji w sposób synchroniczny!
                                                                           => Najlepiej zapomnieć o tej metodzie.

                       .getNow(5)                                          getNow(5) jest dobrym rozwiązaniem i oznacza, że jeśli wykonywanie
                                                                           kodu asynchronicznego w osobnym wątku się nie zakończyło,
                                                                           to zwraca zadeklarowaną wartość
                                                                        */
            } catch (InterruptedException | ExecutionException e) {
                e.printStackTrace();
            }
        };
    }

    /**
     * Nie rób niczego bez czasu oczekiwania.
     * Poniżej przykład użycia metody z timeoutem.
     * */
    private static Runnable timeoutInPipelineExample() {
        return () -> {
            CompletableFuture<Integer> future = create();

            // podajemy wartość zwracaną w razie błędu, potem timeout i na końcu jednostkę czasu
            future.completeOnTimeout(-10, 2, TimeUnit.SECONDS)
//                    .orTimeout(2, TimeUnit.SECONDS)                               // w ten sposób, po prostu deklarujemy timeout bez zwracanej wartości
                    .thenAccept(integer -> {
                        System.out.println(Thread.currentThread());
                        System.out.println("Integer is: " + integer);
                        if (integer == -10) {
                            System.out.println("Wątek użył domyślnej wartości, jaka ma być zwracana po skończeniu czasu zarezerwowanemu na timeout");
                        }
                    });
            try {
                System.out.println("Wątek zaczął oczekiwać");
                Thread.sleep(5000);
                System.out.println("Wątek skończył oczekiwać");
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        };
    }

    /**
     * combine() jest operatorem, dzięki któremu możemy złożyć dwa obiekty CompletableFuture w jedno,
     * wykonać operację na dwóch asynchronicznych operacjach, nie mających ze sobą faktycznie nic wspólnego
     * (zupełnie odrębne obiekty)
     *
     * To jest niesamowita opcja! Możemy sobie poczekać na dwie asynchronicznie wykonywane operacje,
     * a następnie je skorelować i zwrócić jakiś wynik za pomocą implementacji interfejsu funkcionalnego BiFunction
     * */
    private static CompletableFuture<Integer> combineExample() {
        CompletableFuture<Integer> future = create().thenApply(integer -> 2);
        CompletableFuture<Integer> future1 = create().thenApply(integer -> 2);

        return future.thenCombine(future1, Integer::sum);
    }

    private static CompletableFuture<Integer> create() {
        List<Person> people = factorize(5);
        return CompletableFuture.supplyAsync(() -> hardOperationSimulation(people));
    }

    private static int hardOperationSimulation(List<Person> personList) {
        return personList.stream()
                .peek(person -> {
                    threadInfo();
                    try {
                        Thread.sleep(2000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }).findAny()
                .orElseThrow()
                .getAge();
    }

    private static int makeHardHttpRequestSimulation() {
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return 200;  // Http OK
    }

    private static void threadInfo() {
        System.out.println(Thread.currentThread());
    }
}