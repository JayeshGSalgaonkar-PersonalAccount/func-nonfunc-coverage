import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class TestRunner {

    @Test
    void apiFunctionalTest() {
        Results results = Runner.path("classpath:ntuc_memberportal")
                .parallel(5);
    }
}