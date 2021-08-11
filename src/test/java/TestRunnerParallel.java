import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

class TestRunnerParallel {

    @Test
    void apiFunctionalTest() {
        Results results = Runner.path("classpath:ntuc_memberportal/FeatureFiles/")
                .parallel(5);
    }
}
