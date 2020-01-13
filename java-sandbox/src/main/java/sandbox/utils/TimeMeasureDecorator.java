package sandbox.utils;

import com.google.common.base.Stopwatch;

import java.util.concurrent.TimeUnit;

public abstract class TimeMeasureDecorator {

    private TimeMeasureDecorator() {}

    abstract void execute();

    public static void execute(Runnable runnable) {
        new TimeMeasureDecorator() {
            @Override
            public void execute() {
                System.out.println("===> Start method");
                Stopwatch stopwatch = Stopwatch.createStarted();
                runnable.run();
                System.out.println("\n\n===> Ends with milliseconds: " + stopwatch.elapsed(TimeUnit.MILLISECONDS));
            }
        }.execute();
    }
}
